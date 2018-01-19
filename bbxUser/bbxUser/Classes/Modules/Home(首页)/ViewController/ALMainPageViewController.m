//
//  ALMainPageViewController.m
//  AnyHelp
//
//  Created by along on 2017/7/24.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMainPageViewController.h"
#import "ALCustomNavigationView.h"
#import "ALFastCallViewController.h"
#import "ALCustomizationViewController.h"
#import "ALCustomNavigationView.h"
#import "ALSegmentedView.h"
#import "ALMainPageBootPicView.h"
#import "ALDisplayRedEnvelopeView.h"
#import "ALGetTimelimitCouponApi.h"
#import "ALQueryOpenPageApi.h"
#import "ALOpenPageView.h"
#import <SDImageCache.h>

@interface ALMainPageViewController ()
@property (nonatomic, strong) ALFastCallViewController *fastCallVC;
@property (nonatomic, strong) ALCustomizationViewController *customiztionVC;
@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, strong) ALQueryOpenPageApi *queryOpenPageApi;
@property (nonatomic, strong) UIImageView *tempImageView;
@end

@implementation ALMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //启动界面顺序逻辑
    [self startUpInterfaceSequence];
    
    //个性定制
    _customiztionVC = [[ALCustomizationViewController alloc] init];
    [self addChildViewController:_customiztionVC];
    [self.view addSubview:_customiztionVC.view];

    //快速呼叫
    _fastCallVC = [[ALFastCallViewController alloc] init];
    [self addChildViewController:_fastCallVC];
    [self.view addSubview:_fastCallVC.view];
    _currentVC = _fastCallVC;

    AL_WeakSelf(self);
    //切换按钮事件
    ((ALBaseNavigationController *)self.navigationController).customNavigationView.segmentedView.segemtedDidValueChanged = ^(NSUInteger index) {
        if(index == 0) {
            [weakSelf replaceOldController:weakSelf.currentVC newController:weakSelf.fastCallVC];
        } else {
            [weakSelf replaceOldController:weakSelf.currentVC newController:weakSelf.customiztionVC];
        }
    };
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginSuceesssNotification) name:UserLoginSuceesssNotification object:nil];
}

//交换两个控制器
- (void)replaceOldController:(UIViewController *)oldController newController:(UIViewController *)newController {
    [self addChildViewController:newController];
    
    [self transitionFromViewController:oldController toViewController:newController duration:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
    } completion:^(BOOL finished) {
        if(finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
        } else {
            self.currentVC = oldController;
        }
    }];
}

- (void)startUpInterfaceSequence {
    //首次启动显示提示图片
    if(![[NSObject AL_localObjWithKey:@"ALMainPageFistLaunch"] isEqualToString:@"1"]) {
        [@"1" AL_saveLocalWithLocalKey:@"ALMainPageFistLaunch"];
        ALMainPageBootPicView *mainPageBootPicView = [[ALMainPageBootPicView alloc] init];
        [ALKeyWindow addSubview:mainPageBootPicView];
        [mainPageBootPicView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        AL_WeakSelf(self);
        mainPageBootPicView.viewClickRemove = ^{
            [weakSelf queryOpenPage];
        };
    } else {
        [self queryOpenPage];
    }
}

//使用优惠券事件
- (void)emergencyCallAction {
    [_fastCallVC emergencyCallAction];
}

//查询是否有满减红包
- (void)queryDisplayFullCutRedEnvelope {
    if([AL_MyAppDelegate.userModel.idModel.userId isVaild]) {
        ALGetTimelimitCouponApi *getTimelimitCouponApi = [[ALGetTimelimitCouponApi alloc] initGetTimelimitCouponApi];
        AL_WeakSelf(getTimelimitCouponApi);
        [getTimelimitCouponApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            if(weakSelf.timeCouponList.count > 0) {
                ALDisplayRedEnvelopeView *displayRedEnvelopeView = [[ALDisplayRedEnvelopeView alloc] initWithFrame:CGRectZero array:weakSelf.timeCouponList];
                [displayRedEnvelopeView show];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    }
}

- (void)userLoginSuceesssNotification {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self queryDisplayFullCutRedEnvelope];
    });
}

- (void)queryOpenPage {
    AL_WeakSelf(self);
    _queryOpenPageApi = [[ALQueryOpenPageApi alloc] initQueryOpenPageApi];
    
    NSString *iosUrl = [NSObject AL_localObjWithKey:@"openPage_iosUrl"];
    
    ALOpenPageView *openPageView = [[ALOpenPageView alloc] initWithFrame:CGRectZero url:iosUrl];
    [openPageView show];
    openPageView.removeFromWindowBlock = ^{
        [weakSelf queryDisplayFullCutRedEnvelope];
    };
    
    [_queryOpenPageApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSNumber *uploadTime = [NSObject AL_localObjWithKey:@"openPage_uploadTime"];
        NSNumber *requestUploadTime = weakSelf.queryOpenPageApi.data[@"uploadTime"];
        NSString *url = weakSelf.queryOpenPageApi.data[@"iosUrl"];
        
        if(![uploadTime isEqualToNumber:requestUploadTime]) {
            [[SDImageCache sharedImageCache] removeImageForKey:url withCompletion:nil];
            
            [weakSelf.tempImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image) {
                    [requestUploadTime AL_saveLocalWithLocalKey:@"openPage_uploadTime"];
                    [url AL_saveLocalWithLocalKey:@"openPage_iosUrl"];
                }
            }];
            
            if(![url isVaild]) {
                [NSObject AL_clearDataWithLocalKey:@"openPage_iosUrl"];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf queryDisplayFullCutRedEnvelope];
    }];
}

- (UIImageView *)tempImageView {
    if(!_tempImageView) {
        _tempImageView = [UIImageView new];
    }
    return _tempImageView;
}
@end

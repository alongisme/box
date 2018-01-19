//
//  ALFastCallViewController.m
//  bbxUser
//
//  Created by xlshi on 2017/11/6.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALFastCallViewController.h"
#import "ALStepOneViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <APAuthV2Info.h>
#import "RSADataSigner.h"
#import "ALQueryOrderNumApi.h"
#import "ALOrderViewController.h"
#import "ALCustomTagView.h"
#import <SDCycleScrollView.h>
#import "ALQueryBannerListApi.h"
#import "ALBannerViewController.h"

@interface ALFastCallViewController ()
@property (nonatomic, strong) UIButton *orderWorkingNumBtn;
@property (nonatomic, strong) UIButton *orderWorkingNumTopBtn;
@property (nonatomic, strong) ALActionButton *emergencyCallBtn;
@property (nonatomic, strong) BMKPoiInfo *firstPoiModel;
@property (nonatomic, strong) ALQueryOrderNumApi *queryOrderNumApi;
@property (nonatomic, strong) ALQueryBannerListApi *queryBannerListApi;
@property (nonatomic, strong) UIButton *telephoneBtn;
@property (nonatomic, strong) SDCycleScrollView *sdcycleScrollView;
@end

@implementation ALFastCallViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //这里在做一次隐藏 是防止手势返回时 导航栏没有变
    ((ALBaseNavigationController *)self.navigationController).customNavigationView.hidden = NO;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化子界面
    [self initSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //加载轮播图数据
    [self loadBannerData];
}

- (void)loadBannerData {
    AL_WeakSelf(self);

    if(self.queryBannerListApi.isExecuting) {
        [self.queryBannerListApi stop];
    }
    
    [self.queryBannerListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSMutableArray *picUrlArr = [NSMutableArray array];
        
        for (ALBannerListModel *model in weakSelf.queryBannerListApi.bannerListArray) {
            [picUrlArr addObject:ALStringFormat(@"%@%@",URL_Image,model.picUrl)];
        }
        if(picUrlArr.count > 0) {
            weakSelf.sdcycleScrollView.imageURLStringsGroup = picUrlArr;
            weakSelf.sdcycleScrollView.hidden = NO;
        } else {
            weakSelf.sdcycleScrollView.hidden = YES;
        }
        [weakSelf loadOrderNumberDoing];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf loadOrderNumberDoing];
    }];
}

- (void)loadOrderNumberDoing {
    AL_WeakSelf(self);
    if(self.queryOrderNumApi.isExecuting) {
        [self.queryOrderNumApi stop];
    }
    if([AL_MyAppDelegate.userModel.idModel.userId isVaild]) {
        [self.queryOrderNumApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSString *num = weakSelf.queryOrderNumApi.doingNumber;
            if([num integerValue] > 0) {
                if(weakSelf.sdcycleScrollView.imageURLStringsGroup.count > 0) {
                    weakSelf.orderWorkingNumBtn.hidden = NO;
                    [weakSelf.orderWorkingNumBtn setTitle:ALStringFormat(@"%@个订单正在派单...",num) forState:UIControlStateNormal];
                } else {
                    weakSelf.orderWorkingNumTopBtn.hidden = NO;
                    [weakSelf.orderWorkingNumTopBtn setTitle:ALStringFormat(@"您有%@个订单正在派单中~~",num) forState:UIControlStateNormal];
                    [weakSelf.view layoutIfNeeded];
                    [UIView animateWithDuration:0.6 animations:^{
                        [weakSelf.orderWorkingNumTopBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.top.mas_equalTo(ALNavigationBarHeight + 42);
                        }];
                        [weakSelf.view layoutIfNeeded];
                    }];
                }
            } else {
                if(weakSelf.sdcycleScrollView.imageURLStringsGroup.count > 0) {
                    if(weakSelf.orderWorkingNumBtn) {
                        weakSelf.orderWorkingNumBtn.hidden = YES;
                    }
                } else {
                    if(weakSelf.orderWorkingNumTopBtn) {
                        weakSelf.orderWorkingNumTopBtn.hidden = YES;
                    }
                }
            }
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    } else {
        if(_orderWorkingNumBtn) {
            [_orderWorkingNumBtn removeFromSuperview];
            _orderWorkingNumBtn = nil;
        }
    }

}

//停止定位后获取定位信息
- (void)loacationStopWithcoor:(CLLocationCoordinate2D)coor {;
    [self startReverseGeoCodeWithGeoPoint:coor];
}

#pragma mark BMKGeoCodeSearchDelegate
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if(result.poiList.count > 0) {
        self.firstPoiModel = [result.poiList firstObject];
        AL_MyAppDelegate.poiInfoModel = [result.poiList firstObject];
    }
}

#pragma mark Action
- (void)orderWorkingNumButtonAction {
    ALOrderViewController *orderVC = [ALOrderViewController new];
    orderVC.closePopGestureRecognizerEnabled = YES;
    [ALKeyWindow.currentViewController.navigationController pushViewController:orderVC animated:YES];
}

- (void)emergencyCallAction {
    if(AL_MyAppDelegate.userModel.idModel.userId) {
        [MobClick event:ALMobEventID_B2];
        ALStepOneViewController *stepOneVC = [[ALStepOneViewController alloc] init];
        stepOneVC.poiInfoModel = self.firstPoiModel;
        [ALKeyWindow.currentViewController.navigationController pushViewController:stepOneVC animated:YES];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:ReSetToLoginModule object:nil];
    }
}

#pragma mark init subviews
- (void)initSubviews {
    [self.mapView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(ALNavigationBarHeight + 42, 0, 0, 0));
    }];
    
    [self.emergencyCallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(@-20);
    }];
    
    [self.locationBtn setBackgroundImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateNormal];
    [self.locationBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-14);
        make.bottom.equalTo(self.emergencyCallBtn).offset(4);
    }];
    
    [self.telephoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.locationBtn);
        make.bottom.equalTo(self.locationBtn.mas_top).offset(-15);
    }];
    
    self.orderWorkingNumBtn.hidden = YES;

    [self.sdcycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.mapView);
        make.height.equalTo(@50);
    }];
}

#pragma mark lazy load
- (UIButton *)orderWorkingNumBtn {
    if(!_orderWorkingNumBtn) {
        _orderWorkingNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderWorkingNumBtn setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateNormal];
        _orderWorkingNumBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 15);
        _orderWorkingNumBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _orderWorkingNumBtn.titleLabel.font = ALThemeFont(12);
        _orderWorkingNumBtn.titleLabel.numberOfLines = 0;
        _orderWorkingNumBtn.adjustsImageWhenHighlighted = NO;
        [_orderWorkingNumBtn setBackgroundImage:[UIImage imageNamed:@"paidanzhuangtai"] forState:UIControlStateNormal];
        [_orderWorkingNumBtn addTarget:self action:@selector(orderWorkingNumButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_orderWorkingNumBtn];
        
        [_orderWorkingNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.bottom.equalTo(@-75);
            make.size.mas_equalTo(CGSizeMake(176/2, 96/2));
        }];
    }
    return _orderWorkingNumBtn;
}

- (UIButton *)orderWorkingNumTopBtn {
    if(!_orderWorkingNumTopBtn) {
        _orderWorkingNumTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _orderWorkingNumTopBtn.titleLabel.font = ALThemeFont(14);
        _orderWorkingNumTopBtn.backgroundColor = [UIColor colorWithRed:75/255.0 green:128/255.0 blue:235/255.0 alpha:0.8/1.0];
        _orderWorkingNumTopBtn.titleLabel.textColor = [UIColor whiteColor];
        _orderWorkingNumTopBtn.adjustsImageWhenHighlighted = NO;
        [_orderWorkingNumTopBtn addTarget:self action:@selector(orderWorkingNumButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_orderWorkingNumTopBtn];
        
        [_orderWorkingNumTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ALNavigationBarHeight - 26 + 42);
            make.width.equalTo(self.view);
            make.centerX.equalTo(self.view);
            make.height.equalTo(@26);
        }];
    }
    return _orderWorkingNumTopBtn;
}

- (ALActionButton *)emergencyCallBtn {
    if(!_emergencyCallBtn) {
        _emergencyCallBtn = [ALActionButton buttonWithType:UIButtonTypeCustom];
        [_emergencyCallBtn setBackgroundImage:[UIImage imageNamed:@"btn_Emergency call_nor"] forState:UIControlStateNormal];
        [_emergencyCallBtn addTarget:self action:@selector(emergencyCallAction) forControlEvents:UIControlEventTouchUpInside];
        [_emergencyCallBtn.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeMake(0, 4) radius:1];
        [self.view addSubview:_emergencyCallBtn];
    }
    return _emergencyCallBtn;
}

- (UIButton *)telephoneBtn {
    if(!_telephoneBtn) {
        _telephoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_telephoneBtn setBackgroundImage:[UIImage imageNamed:@"tel"] forState:UIControlStateNormal];
        [self.view addSubview:_telephoneBtn];
    }
    [_telephoneBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [MobClick event:ALMobEventID_B1];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4001066964"]];
        });
    }];
    return _telephoneBtn;
}

- (ALQueryOrderNumApi *)queryOrderNumApi {
    if(!_queryOrderNumApi) {
        _queryOrderNumApi = [[ALQueryOrderNumApi alloc] initWithOrderNumApi];
    }
    return _queryOrderNumApi;
}

- (ALQueryBannerListApi *)queryBannerListApi {
    if(!_queryBannerListApi) {
        _queryBannerListApi = [[ALQueryBannerListApi alloc] initQueryBannerListApi];
    }
    return _queryBannerListApi;
}

- (SDCycleScrollView *)sdcycleScrollView {
    if(!_sdcycleScrollView) {
        _sdcycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:@[]];
        _sdcycleScrollView.showPageControl = NO;
        _sdcycleScrollView.autoScrollTimeInterval = 5;
        _sdcycleScrollView.hidden = YES;
        _sdcycleScrollView.placeholderImage = [UIImage imageNamed:@"zhanweitu"];
        [self.view addSubview:_sdcycleScrollView];
        
        AL_WeakSelf(self);
        _sdcycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
            ALBannerListModel *model = weakSelf.queryBannerListApi.bannerListArray[currentIndex];
            ALBannerViewController *webVC = [[ALBannerViewController alloc] init];

            if([model.bannerType isEqualToString:@"1"]) {
                webVC.requestUrl = model.bannerLink;
                webVC.title = @"镖镖资讯";
            } else {
                if(!(AL_MyAppDelegate.netWorkstatus == AFNetworkReachabilityStatusNotReachable || AL_MyAppDelegate.netWorkstatus == AFNetworkReachabilityStatusUnknown)) {
                    webVC.bannerId = model.bannerId;
                }
            }
            [ALKeyWindow.currentViewController.navigationController pushViewController:webVC animated:YES];
        };
    }
    return _sdcycleScrollView;
}
@end

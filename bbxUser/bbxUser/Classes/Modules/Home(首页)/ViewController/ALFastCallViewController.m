//
//  ALFastCallViewController.m
//  bbxUser
//
//  Created by xlshi on 2017/11/6.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALFastCallViewController.h"
#import "ALCallBBXViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <APAuthV2Info.h>
#import "RSADataSigner.h"
#import "ALQueryOrderNumApi.h"
#import "ALOrderViewController.h"
#import "ALCustomTagView.h"
#import <SDCycleScrollView.h>
#import "ALQueryBannerListApi.h"
#import "ALBannerViewController.h"
#import "ALDynamicsViewController.h"
#import "ALCheckVersionApi.h"

@interface ALFastCallViewController ()
@property (nonatomic, strong) UIButton *orderWorkingNumBtn;
//@property (nonatomic, strong) UIButton *orderWorkingNumTopBtn;
@property (nonatomic, strong) ALActionButton *emergencyCallBtn;
@property (nonatomic, strong) BMKPoiInfo *firstPoiModel;
@property (nonatomic, strong) ALQueryOrderNumApi *queryOrderNumApi;
@property (nonatomic, strong) ALQueryBannerListApi *queryBannerListApi;
@property (nonatomic, strong) UIButton *telephoneBtn;
@property (nonatomic, strong) SDCycleScrollView *sdcycleScrollView;

@property (nonatomic, strong) NSDictionary *lastOrderDic;
@property (nonatomic, strong) ALCheckVersionApi *checkVersionApi;
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
    [self customLocationAccuracyCircle:YES];
    //初始化子界面
    [self initSubviews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessToDynamics:) name:@"paySuccessToDynamics" object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //加载轮播图数据
    [self loadBannerData];
    [self loadOrderNumberDoing];
    [self checkVersion];
}

- (void)checkVersion {
    _checkVersionApi = [[ALCheckVersionApi alloc] initWithCheckVersionApi];
    AL_WeakSelf(self);
    [_checkVersionApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if(![weakSelf.checkVersionApi.data[@"iOSVersion"] isEqualToString:ALAppVersion]) {
            UIView *bgView = [[UIView alloc] init];
            bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
            [ALKeyWindow addSubview:bgView];
            
            [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(@0);
            }];
            
            UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newVersion"]];
            [bgView addSubview:iv];
            
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(ALKeyWindow);
                make.size.mas_equalTo(CGSizeMake(540/2.0, 594/2.0));
            }];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn-update"] forState:UIControlStateNormal];
            [bgView addSubview:btn];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(ALKeyWindow);
                make.bottom.equalTo(iv.mas_bottom).offset(-28);
            }];
            
            [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/id1273047690?mt=8"]];
            }];
            
            ALLabel *label = [[ALLabel alloc] init];
            label.text = @"发现新版本，升级后体验更流畅！不升级当前版本不可使用~";
            label.numberOfLines = 0;
            label.textColor = [UIColor colorWithRGB:0x444444];
            [bgView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(ALKeyWindow);
                make.bottom.equalTo(btn.mas_top).offset(-17);
                make.width.equalTo(iv).offset(-28);
            }];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)paySuccessToDynamics:(NSNotification *)notification {
    if([notification.object[@"orderId"] isVaild]) {
        ALDynamicsViewController *dynamicsVC = [ALDynamicsViewController new];
        dynamicsVC.orderId = notification.object[@"orderId"];
        dynamicsVC.orderStatus = OrderStatusPS;
        [self.navigationController pushViewController:dynamicsVC animated:YES];
    }
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
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

    }];
}

- (void)loadOrderNumberDoing {
    AL_WeakSelf(self);
    if(self.queryOrderNumApi.isExecuting) {
        [self.queryOrderNumApi stop];
    }
    if([AL_MyAppDelegate.userModel.idModel.userId isVaild]) {
        [self.queryOrderNumApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//            NSString *lastOrderStatus = weakSelf.queryOrderNumApi.data[@"lastOrderStatus"];
            weakSelf.lastOrderDic = weakSelf.queryOrderNumApi.data;
            if([weakSelf.queryOrderNumApi.data[@"statusDes"] isVaild]) {
                [weakSelf showLeftTagWith:weakSelf.queryOrderNumApi.data[@"statusDes"]];
                weakSelf.orderWorkingNumBtn.hidden = NO;
            } else {
                weakSelf.orderWorkingNumBtn.hidden = YES;
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

- (void)showLeftTagWith:(NSString *)text {
    self.orderWorkingNumBtn.hidden = NO;
    [self.orderWorkingNumBtn setTitle:text forState:UIControlStateNormal];
    [self.orderWorkingNumBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@-22);
        make.bottom.equalTo(@-75);
        CGFloat wid = [self.orderWorkingNumBtn.currentTitle widthForFont:self.orderWorkingNumBtn.titleLabel.font] + 52/2.0 + 30 + 15 + 5 ;
        make.size.mas_equalTo(CGSizeMake(wid, 52));
    }];
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
    ALDynamicsViewController *dynamicsVC = [ALDynamicsViewController new];
    dynamicsVC.orderId = self.lastOrderDic[@"orderId"];
    dynamicsVC.orderStatus = self.lastOrderDic[@"lastOrderStatus"];
    [self.navigationController pushViewController:dynamicsVC animated:YES];
}

- (void)emergencyCallAction {
    AL_WeakSelf(self);
    if(AL_MyAppDelegate.userModel.idModel.userId) {
        if([self.lastOrderDic[@"lastOrderStatus"] isEqualToString:OrderStatusWaitAllocating] ||[self.lastOrderDic[@"lastOrderStatus"] isEqualToString:OrderStatusPS] || [self.lastOrderDic[@"lastOrderStatus"] isEqualToString:OrderStatusAllocatingWaitStart] || [self.lastOrderDic[@"lastOrderStatus"] isEqualToString:OrderStatusWorking] || [self.lastOrderDic[@"lastOrderStatus"] isEqualToString:OrderStatusZ]) {
            [ALAlertViewController showAlertOnlyCancelButton:self title:nil message:self.lastOrderDic[@"tips"] style:UIAlertControllerStyleAlert Destructive:@"查看镖师动态" clickBlock:^{
                [weakSelf orderWorkingNumButtonAction];
            }];
        } else if([self.lastOrderDic[@"lastOrderStatus"] isEqualToString:OrderStatusWaitPay]) {
            [ALAlertViewController showAlertOnlyCancelButton:self title:nil message:self.lastOrderDic[@"tips"] style:UIAlertControllerStyleAlert Destructive:@"前往" clickBlock:^{
                
            }];
        } else if([self.lastOrderDic[@"lastOrderStatus"] isEqualToString:OrderStatusZ]) {
            [ALAlertViewController showAlertOnlyCancelButton:self title:nil message:self.lastOrderDic[@"tips"] style:UIAlertControllerStyleAlert Destructive:@"去支付" clickBlock:^{
                
            }];
        } else {
            [MobClick event:ALMobEventID_B2];
            ALCallBBXViewController *callBBxVC = [[ALCallBBXViewController alloc] init];
            callBBxVC.poiInfoModel = self.firstPoiModel;
            [ALKeyWindow.currentViewController.navigationController pushViewController:callBBxVC animated:YES];
        }
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
        [_orderWorkingNumBtn setTitleColor:[UIColor colorWithRGBA:ALLabelTextColor] forState:UIControlStateNormal];
        _orderWorkingNumBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 5);
        [_orderWorkingNumBtn setImage:[UIImage imageNamed:@"biaobiao"] forState:UIControlStateNormal];
        [_orderWorkingNumBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        _orderWorkingNumBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _orderWorkingNumBtn.titleLabel.font = ALThemeFont(12);
        _orderWorkingNumBtn.titleLabel.numberOfLines = 0;
        _orderWorkingNumBtn.adjustsImageWhenHighlighted = NO;
        [_orderWorkingNumBtn addTarget:self action:@selector(orderWorkingNumButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _orderWorkingNumBtn.backgroundColor = [UIColor whiteColor];
        _orderWorkingNumBtn.layer.cornerRadius = 52/2.0;
        [_orderWorkingNumBtn.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeZero radius:1];
        [self.view addSubview:_orderWorkingNumBtn];
    }
    return _orderWorkingNumBtn;
}

//- (UIButton *)orderWorkingNumTopBtn {
//    if(!_orderWorkingNumTopBtn) {
//        _orderWorkingNumTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _orderWorkingNumTopBtn.titleLabel.font = ALThemeFont(14);
//        _orderWorkingNumTopBtn.backgroundColor = [UIColor colorWithRed:75/255.0 green:128/255.0 blue:235/255.0 alpha:0.8/1.0];
//        _orderWorkingNumTopBtn.titleLabel.textColor = [UIColor whiteColor];
//        _orderWorkingNumTopBtn.adjustsImageWhenHighlighted = NO;
//        [_orderWorkingNumTopBtn addTarget:self action:@selector(orderWorkingNumButtonAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:_orderWorkingNumTopBtn];
//
//        [_orderWorkingNumTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(ALNavigationBarHeight - 26 + 42);
//            make.width.equalTo(self.view);
//            make.centerX.equalTo(self.view);
//            make.height.equalTo(@26);
//        }];
//    }
//    return _orderWorkingNumTopBtn;
//}

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

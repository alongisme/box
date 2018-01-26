//
//  ALDynamicsViewController.m
//  bbxUser
//
//  Created by xlshi on 2018/1/22.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALDynamicsViewController.h"
#import "ALCancelOrderApi.h"
#import "ALRefreshOrderDetailApi.h"
#import "ALNewSecurityLListView.h"
#import "ALDynamicsBottomView.h"
#import "ALMobilePayService.h"
#import "ALPayPresentView.h"
#import "ALCreateAppPayApi.h"
#import "ALSencondPayInitApi.h"
#import "ALRedEnvelopeViewController.h"
#import "ALNewManySecutityListView.h"
#import "ALSecurityLocationModel.h"
#import "ALRealTImePositionAnnotationView.h"
#import "ALSecurityInfoViewController.h"
#import "ALEvaluateViewController.h"

@interface ALDynamicsViewController ()<ALRedEnvelopeDelegate>
@property (nonatomic, strong) UIButton *orderStatusView;
@property (nonatomic, strong) UIButton *orderStatusDesBtn;
@property (nonatomic, strong) ALDynamicsBottomView *dynamicsBottomView;
@property (nonatomic, strong) ALCancelOrderApi *cancelOrderApi;
@property (nonatomic, strong) ALRefreshOrderDetailApi *refreshOrderDetailApi;
@property (nonatomic, strong) ALNewSecurityLListView *neSecurityListOnlyOneView;
@property (nonatomic, strong) ALCreateAppPayApi *createAppPayApi;
@property (nonatomic, strong) ALPayPresentView *payPresentView;
@property (nonatomic, strong) ALSencondPayInitApi *sencondPayInitApi;
@property (nonatomic, strong) NSDictionary *sencondPayDic;
@property (nonatomic, strong) NSString *couponId;
//红包选择行数标记
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, strong) ALNewManySecutityListView *neManySecutityListView;
@property (nonatomic, strong) ALNewManySecutityListView *windowManySecutityListView;
@end

@implementation ALDynamicsViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //这里在做一次隐藏 是防止手势返回时 导航栏没有变
    ((ALBaseNavigationController *)self.navigationController).customNavigationView.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)refreshOrderDetailAction {
    _refreshOrderDetailApi = [[ALRefreshOrderDetailApi alloc] initWithRefreshOrderDetailApi:self.orderId];
    AL_WeakSelf(self);
    [_refreshOrderDetailApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ALOrderModel *model = weakSelf.refreshOrderDetailApi.orderModel;
        if([model.orderStatus isEqualToString:OrderStatusFinished]) {
            weakSelf.dynamicsBottomView = [[ALDynamicsBottomView alloc] initWithFrame:CGRectZero flag:300 expireInterval:model.expireInterval];
            
            weakSelf.dynamicsBottomView.toEvaluateBlock = ^{
                [weakSelf.dynamicsBottomView removeFromSuperview];
                weakSelf.dynamicsBottomView = nil;
                ALEvaluateViewController *evaluateVC = [[ALEvaluateViewController alloc] init];
                ALOrderModel *evaOrderModel = [[ALOrderModel alloc] init];
                evaOrderModel.orderId = weakSelf.orderId;
                evaOrderModel.securityList = model.securityList;
                evaluateVC.orderModel = evaOrderModel;
                evaluateVC.indexPath = 9999;
                [weakSelf.navigationController pushViewController:evaluateVC animated:YES];
            };
        }
        
        if([model.orderStatus isEqualToString:OrderStatusWorking] || [model.orderStatus isEqualToString:OrderStatusZ] || [model.orderStatus isEqualToString:OrderStatusAllocatingWaitStart]) {
            
            [weakSelf.mapView removeAnnotations:weakSelf.mapView.annotations];

            for (ALSecurityLocationModel *securityLocationModel in weakSelf.refreshOrderDetailApi.poiListArray) {
                BMKPointAnnotation *animatedAnnotation = [[BMKPointAnnotation alloc]init];
                animatedAnnotation.coordinate = CLLocationCoordinate2DMake([securityLocationModel.latitude floatValue], [securityLocationModel.longitude floatValue]);
                animatedAnnotation.subtitle = securityLocationModel.securityId;
                [weakSelf.mapView addAnnotation:animatedAnnotation];
            }
            
            if([model.orderStatus isEqualToString:OrderStatusAllocatingWaitStart]) {
                weakSelf.dynamicsBottomView = [[ALDynamicsBottomView alloc] initWithFrame:CGRectZero flag:100 expireInterval:model.expireInterval];
                [weakSelf.mapView addSubview:weakSelf.dynamicsBottomView];
                [weakSelf.dynamicsBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.left.bottom.equalTo(@0);
                    make.height.equalTo(@155);
                }];
            } else if([model.orderStatus isEqualToString:OrderStatusZ]) {
                weakSelf.dynamicsBottomView = [[ALDynamicsBottomView alloc] initWithFrame:CGRectZero flag:200 expireInterval:model.expireInterval];
                [weakSelf.mapView addSubview:weakSelf.dynamicsBottomView];
                [weakSelf.dynamicsBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.left.bottom.equalTo(@0);
                    make.height.equalTo(@200);
                }];
            } else if([model.orderStatus isEqualToString:OrderStatusWaitAllocating] || [model.orderStatus isEqualToString:OrderStatusPS]) {
                weakSelf.dynamicsBottomView = [[ALDynamicsBottomView alloc] initWithFrame:CGRectZero flag:0 expireInterval:model.expireInterval];
                [weakSelf.mapView addSubview:weakSelf.dynamicsBottomView];
                [weakSelf.dynamicsBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.left.bottom.equalTo(@0);
                    make.height.equalTo(@155);
                }];
            }
            
            if([weakSelf.orderStatus isEqualToString:OrderStatusZ]) {
                weakSelf.dynamicsBottomView.waitFinished.enabled = NO;
            } else {
                weakSelf.dynamicsBottomView.waitFinished.enabled = YES;
            }
        
            weakSelf.dynamicsBottomView.payBlock = ^{
                weakSelf.sencondPayInitApi = [[ALSencondPayInitApi alloc] initSencondPayInitApi:weakSelf.orderId];
                [weakSelf.sencondPayInitApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    weakSelf.sencondPayDic = weakSelf.sencondPayInitApi.data;
                    weakSelf.couponId = @"";
                    weakSelf.selectedIndex = 0;
                    [weakSelf.payPresentView removeFromSuperview];
                    weakSelf.payPresentView = nil;
                    [weakSelf.payPresentView showToViewController:weakSelf];
                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                    
                }];
                
            };
            
            if(model.securityList.count == 1) {
                weakSelf.neSecurityListOnlyOneView = [[ALNewSecurityLListView alloc] initWithFrame:CGRectZero onlyOne:model.securityList.lastObject];
                [weakSelf.mapView addSubview:weakSelf.neSecurityListOnlyOneView];
                [weakSelf.neSecurityListOnlyOneView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@14);
                    make.top.equalTo(@10);
                    make.right.equalTo(@-14);
                    make.height.equalTo(@94);
                }];
                
            } else {
                weakSelf.neManySecutityListView = [[ALNewManySecutityListView alloc] initWithFrame:CGRectZero arr:model.securityList];
                [self.mapView addSubview:weakSelf.neManySecutityListView];
                
                [weakSelf.neManySecutityListView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@10);
                    make.left.equalTo(@14);
                    make.right.equalTo(@-14);
                    make.height.equalTo(@(85 + 45));
                }];
                
                weakSelf.neManySecutityListView.itemDidSelectedAtIndex = ^(NSUInteger index) {
                    if(index == 0) {
                        
                        weakSelf.windowManySecutityListView = [[ALNewManySecutityListView alloc] initWithFrame:CGRectZero arr:model.securityList];
                        UIView *bgView = [[UIView alloc] init];
                        [ALKeyWindow addSubview:bgView];
                        
                        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.edges.equalTo(@0);
                        }];
                        
                        [bgView addSubview:weakSelf.windowManySecutityListView];
                        
                        [weakSelf.windowManySecutityListView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo(@(ALNavigationBarHeight + 10));
                            make.left.equalTo(@14);
                            make.right.equalTo(@-14);
                            make.height.equalTo(@(85 * model.securityList.count + 45));
                        }];
                        
                        [UIView animateWithDuration:0.3 animations:^{
                            bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
                        }];
                        
                        [ALKeyWindow layoutIfNeeded];
                        
                        [weakSelf.windowManySecutityListView lookManyAction];
                        
                        weakSelf.windowManySecutityListView.itemDidSelectedAtIndex = ^(NSUInteger index) {
                            if(index == 1) {
                                [weakSelf.neManySecutityListView lookManyAction];
                                [UIView animateWithDuration:0.3 animations:^{
                                    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
                                } completion:^(BOOL finished) {
                                    [bgView removeFromSuperview];
                                }];
                            }
                        };
                        
                    }
                };
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationBtn.hidden = YES;
    if([self.orderStatus isEqualToString:OrderStatusPS]) {
        self.title = @"呼叫镖师";
        self.mapView.showsUserLocation = NO;
        [self.orderStatusDesBtn setTitle:@"您的订单已成功受理，系统正在为您匹配镖师" forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消订单" style:UIBarButtonItemStyleDone target:self action:@selector(cancelOrder)];
    } else if([self.orderStatus isEqualToString:OrderStatusWaitAllocating]) {
        self.title = @"呼叫镖师";
        self.mapView.showsUserLocation = NO;
        [self.orderStatusDesBtn setTitle:@"您的订单已开始受理，请耐心等待，小镖正在接单" forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消订单" style:UIBarButtonItemStyleDone target:self action:@selector(cancelOrder)];
    } else {
        self.mapView.showsUserLocation = YES;
        self.title = @"镖师动态";
        [self customLocationAccuracyCircle:NO];
    }
    
    [self refreshOrderDetailAction];

}

- (void)cancelOrder {
    AL_WeakSelf(self);
    [ALAlertViewController showAlertOnlyCancelButton:self title:nil message:@"镖师正在匹配中，确定要取消订单吗？取消后会重新排队等待派单。" style:UIAlertControllerStyleAlert Destructive:@"取消订单" clickBlock:^{
        weakSelf.cancelOrderApi = [[ALCancelOrderApi alloc] initWithCancelOrderApi:weakSelf.orderId];
        
        [weakSelf.cancelOrderApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [MobClick event:ALMobEventID_F1];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [ALKeyWindow showHudError:@"取消订单失败～"];
        }];
    }];
}

- (void)loacationStopWithcoor:(CLLocationCoordinate2D)coor {
    if([self.orderStatus isEqualToString:OrderStatusPS] || [self.orderStatus isEqualToString:OrderStatusWaitAllocating]) {
        BMKPointAnnotation * pointAnnotation = [[BMKPointAnnotation alloc]init];
        
        pointAnnotation.coordinate = coor;
        
        [self.mapView addAnnotation:pointAnnotation];
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        NSString *AnnotationViewID = @"AnimatedAnnotation";
        ALRealTImePositionAnnotationView *annotationView = nil;
        if (annotationView == nil) {
            annotationView = [[ALRealTImePositionAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            annotationView.canShowCallout = NO;
        }
        for (ALSecurityLocationModel *model in self.refreshOrderDetailApi.poiListArray) {
            if([model.securityId isEqualToString:annotation.subtitle]) {
                [annotationView.annotationImageView sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@",model.icon)] placeholderImage:[UIImage imageNamed:@"touxiang_weidenglu"]];
            }
        }
        return  annotationView;
    } else {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        
        //设置标注的颜色
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        
        //设置标注的动画效果
        newAnnotationView.animatesDrop = NO;
        newAnnotationView.selected = YES;
        //自定义标注的图像
        newAnnotationView.image = [UIImage imageNamed:@"dizhi"];
        
        newAnnotationView.annotation = annotation;
        
        UIView *paopaoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 316/2.0, 92/2.0)];
        UIImageView *xuanfuIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xuanfu"]];
        [paopaoView addSubview:xuanfuIV];
        
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 316/2.0 - 10, 92/2.0 - 10)];
        timeLab.text = @"已等候 00:02:26";
        timeLab.font = ALThemeFont(15);
        timeLab.textAlignment = NSTextAlignmentCenter;
        timeLab.textColor = [UIColor blueColor];
        [paopaoView addSubview:timeLab];
        
        BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc] initWithCustomView:paopaoView];
        pView.frame = CGRectMake(0, 0, 316/2.0, 92/2.0);
        
        ((BMKPinAnnotationView *)newAnnotationView).paopaoView = pView;
        return newAnnotationView;
    }

    return nil;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
//    if([view isKindOfClass:[ALRealTImePositionAnnotationView class]]) {
//        for (ALSecurityLocationModel *model in self.refreshOrderDetailApi.poiListArray) {
//            if([model.securityId isEqualToString:view.annotation.subtitle]) {
//                ALSecurityInfoViewController *securityInfoVC = [[ALSecurityInfoViewController alloc] init];
//                securityInfoVC.securityId = view.annotation.subtitle;
//                [self.navigationController pushViewController:securityInfoVC animated:YES];
//                break;
//            }
//        }
//    }
}

#pragma mark ALRedEnvelopeDelegate
- (void)didSelectedWithIndex:(int)index model:(ALRedEnvelopoModel *)model {
    _selectedIndex = index;
    if(model) {
        self.payPresentView.disCount = model.discount;
        self.couponId = model.couponId;
    } else {
        self.payPresentView.disCount = @"-1";
        self.couponId = @"";
    }
}

#pragma mark lazy load
- (UIButton *)orderStatusView {
    if(!_orderStatusView) {
        _orderStatusView = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_orderStatusView];
    }
    return _orderStatusView;
}

- (UIButton *)orderStatusDesBtn {
    if(!_orderStatusDesBtn) {
        _orderStatusDesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _orderStatusDesBtn.backgroundColor = [UIColor whiteColor];
        [_orderStatusDesBtn setTitleColor:[UIColor colorWithRGB:0x666666] forState:UIControlStateNormal];
        _orderStatusDesBtn.titleLabel.font = ALThemeFont(14);
        _orderStatusDesBtn.titleLabel.numberOfLines = 0;
        [_orderStatusDesBtn.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeZero radius:1];
        [self.mapView addSubview:_orderStatusDesBtn];
        
        [_orderStatusDesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(@5);
            make.right.equalTo(@-14);
            make.height.equalTo(@60);
        }];
    }
    return _orderStatusDesBtn;
}

- (ALPayPresentView *)payPresentView {
    if(!_payPresentView) {
        ALOrderModel *orderModel = [ALOrderModel new];
        orderModel.orderId = self.orderId;
        
        _payPresentView = [[ALPayPresentView alloc] initWithFrame:CGRectZero orderModel:orderModel first:NO dic:self.sencondPayDic];
        
        AL_WeakSelf(self);
        _payPresentView.toRedEnv = ^{
            [MobClick event:ALMobEventID_E1];
            ALRedEnvelopeViewController *redEnvelopeVC = [[ALRedEnvelopeViewController alloc] init];
            redEnvelopeVC.orderId = weakSelf.orderId;
            redEnvelopeVC.redEvelopeDelegate = weakSelf;
            redEnvelopeVC.selectedIndex = weakSelf.selectedIndex;
            [weakSelf.navigationController pushViewController:redEnvelopeVC animated:YES];
        };
        
        _payPresentView.toPayBlock = ^(ALPayType payType) {
            if(payType == ALPayTypeAliPay) {
                
                _createAppPayApi = [[ALCreateAppPayApi alloc] initWithCreateAppPayApi:self.orderId PayType:@"1" couponId:self.couponId payChannel:@"aliPay"];
                
                [weakSelf.createAppPayApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    // NOTE: 调用支付结果开始支付
                    [[ALMobilePayService sharedInstance] alipayWithOrderString:weakSelf.createAppPayApi.data[@"aliPayStr"]];
                }
                                                                           failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                                                                               [ALKeyWindow showHudError:@"支付失败～"];
                                                                           }];
                
            } else {
                //微信支付
                _createAppPayApi = [[ALCreateAppPayApi alloc] initWithCreateAppPayApi:self.orderId PayType:@"1" couponId:self.couponId payChannel:@"wxPay"];
                
                [weakSelf.createAppPayApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    [[ALMobilePayService sharedInstance] wechatOayOrderString:weakSelf.createAppPayApi.data[@"wxPayStr"]];
                }
                                                                           failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                                                                               [ALKeyWindow showHudError:@"支付失败～"];
                                                                           }];
            }
        };
        
        [ALMobilePayService sharedInstance].PayCompltedHandleBlock = ^(ALPayHandle handel) {
            if(handel == ALPayHandleSuceess) {
                [weakSelf.payPresentView removeFromSuperview];
                weakSelf.payPresentView = nil;
                
            }
        };
    }
    return _payPresentView;
}
@end

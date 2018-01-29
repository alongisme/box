//
//  ALOrderInfoViewController.m
//  bbxUser
//
//  Created by along on 2017/8/8.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALOrderInfoViewController.h"
#import "ALStepView.h"
#import "ALPaySuccessViewController.h"
#import "ALOrderInfoView.h"
#import "ALOrderDetailApi.h"
#import "ALRedEnvelopeViewController.h"
#import "ALCreateAppPayApi.h"
#import "ALEvaluateViewController.h"
#import "ALMobilePayService.h"
#import "ALCancelOrderApi.h"
#import "ALSecurityInfoViewController.h"
#import "ALRealTimePositionViewController.h"
#import "ALPayPresentView.h"
#import "ALDynamicsViewController.h"
#import "ALSencondPayInitApi.h"

@interface ALOrderInfoViewController () <ALRedEnvelopeDelegate, ALPaySuccessDelegate, ALEvaluateDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ALStepView *stepView;
//订单信息
@property (nonatomic, strong) ALOrderInfoView *orderInfoView;
//订单id信息
@property (nonatomic, strong) ALOrderInfoView *orderIdView;
//镖师列表
@property (nonatomic, strong) ALOrderInfoView *orderSecurityView;
//红包
@property (nonatomic, strong) ALOrderInfoView *orderRedView;
//支付
@property (nonatomic, strong) ALOrderInfoView *orderPayView;
@property (nonatomic, strong) ALPayPresentView *payPresentView;
@property (nonatomic, strong) ALSencondPayInitApi *sencondPayInitApi;
@property (nonatomic, strong) NSDictionary *sencondPayDic;
@property (nonatomic, strong) NSString *couponId;
//红包选择行数标记
@property (nonatomic, assign) int selectedIndex;
//支付时间
//@property (nonatomic, strong) YYLabel *payTimeLab;
//支付时间下面的提示文字
//@property (nonatomic, strong) ALLabel *payMsgLab;
//支付按钮
//@property (nonatomic, strong) ALActionButton *payBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *payBtn;
//持续发布的提示文字
@property (nonatomic, strong) ALLabel *reminderLab;
//评价按钮
@property (nonatomic, strong) UIButton *evaluateBtn;
//订单详情接口
@property (nonatomic, strong) ALOrderDetailApi *orderDetailApi;
//取消订单接口
@property (nonatomic, strong) ALCancelOrderApi *cancelOrderApi;
//创建支付接口
@property (nonatomic, strong) ALCreateAppPayApi *createAppPayApi;
//时间计时器
//@property (nonatomic, strong) NSTimer *timer;
//当前选择的红包数据模型
@property (nonatomic, strong) ALRedEnvelopoModel *selectedRedEnvModel;
@end

@implementation ALOrderInfoViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //这里在做一次隐藏 是防止手势返回时 导航栏没有变
    ((ALBaseNavigationController *)self.navigationController).customNavigationView.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    //如果是创建新订单
    if([_orderModel.orderStatus isEqualToString:OrderStautsNew]) {
        self.title = @"呼叫镖镖";
        [self addCloseLeftItem];
        [self initSubviews];
        [self bindAction];
    } else if([_orderModel.orderStatus isEqualToString:OrderStautsCustom]) {
        self.title = @"支付确认";
        [self addCloseLeftItem];
        [self loadData];
    } else {
        self.title = @"订单详情";
        [self loadData];
    }
}

- (void)addCloseLeftItem {
    UIBarButtonItem *closeItem = [self createButtonItemWithImageName:@"icon_close_nor" selector:@selector(dismissAction)];
    self.navigationItem.leftBarButtonItem = closeItem;
}

- (void)loadData {
    _orderDetailApi = [[ALOrderDetailApi alloc] initWithOrderDetailApi:_orderModel.orderId];
    AL_WeakSelf(self);
    [_orderDetailApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        weakSelf.orderModel = weakSelf.orderDetailApi.orderModel;
        [weakSelf initSubviews];
        [weakSelf bindAction];
        [weakSelf removeRequestStatusView];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [ALKeyWindow showHudError:@"获取订单信息失败～"];
    }];
    
    _orderDetailApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _orderDetailApi.dataErrorBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusDataError];
    };
}

- (void)reloadData {
    [self loadData];
}

- (void)initSubviews {
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self.view);
        make.height.equalTo(self.view);
        make.top.equalTo(@0);
    }];
    
    if([_orderModel.orderStatus isEqualToString:OrderStautsNew]) {
        [self.stepView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.width.equalTo(self.view);
            make.centerX.equalTo(self.view);
            make.height.equalTo(@75);
        }];
        
        [self.orderIdView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.stepView.mas_bottom).offset(10);
            make.width.equalTo(self.scrollView).offset(-28);
            make.centerX.equalTo(self.scrollView);
            make.height.equalTo(@75);
        }];
    } else {
        NSString *addressString = self.orderDetailApi.orderModel.seviceAddress;
        
        CGFloat addressHeight = [addressString heightForFont:ALThemeFont(14) width:ALScreenWidth - 14 - 16 - 20 - 15 - 14 - 14];
        
        [self.orderInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.height.equalTo(@(148 + addressHeight));
            make.width.equalTo(self.scrollView).offset(-28);
            make.centerX.equalTo(self.scrollView);
        }];
        
        [self.orderIdView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderInfoView.mas_bottom).offset(10);
            make.width.equalTo(self.scrollView).offset(-28);
            make.centerX.equalTo(self.scrollView);
            make.height.equalTo(@75);
        }];
    }
    
    if([_orderModel.orderStatus isEqualToString:OrderStatusCancel]) {
    } else if([_orderModel.orderStatus isEqualToString:OrderStatusFinished]) {
        [self.orderSecurityView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderIdView.mas_bottom).offset(10);
            make.width.equalTo(self.scrollView).offset(-28);
            make.centerX.equalTo(self.scrollView);
            CGFloat height = self.orderDetailApi.orderModel.securityList.count * (68 + 1) + 28;
            make.height.equalTo(@(height));
        }];
        
        if([self.orderDetailApi.orderModel.isCommented isEqualToString:@"0"]) {
            [self.evaluateBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.scrollView).offset(-30);
                make.centerX.equalTo(self.scrollView);
                make.top.equalTo(self.orderSecurityView.mas_bottom).offset(30);
            }];
            [self.view layoutIfNeeded];
            
            self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.evaluateBtn .frame) + 10);
        } else {
            [self.view layoutIfNeeded];
            
            self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.orderSecurityView.frame) + 10);
        }
        
    } else if([_orderModel.orderStatus isEqualToString:OrderStatusWaitPay] || [_orderModel.orderStatus isEqualToString:OrderStautsNew]) {
        [self.orderRedView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.orderIdView);
            make.top.equalTo(self.orderIdView.mas_bottom).offset(12);
            make.height.equalTo(@46);
        }];
        
        [self.orderPayView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.orderIdView);
            make.top.equalTo(self.orderRedView.mas_bottom).offset(12);
            if([WXApi isWXAppInstalled])
                make.height.equalTo(@91);
            else
                make.height.equalTo(@45);
        }];
        
        if(ALScreenWidth == 320) {
            //            [self.payTimeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            //                make.centerX.equalTo(self.scrollView);
            //                make.bottom.equalTo(self.orderPayView.mas_bottom).offset(50);
            //            }];
            
            //            [self.payMsgLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            //                make.centerX.equalTo(self.scrollView);
            //                make.bottom.equalTo(self.orderPayView.mas_bottom).offset(21);
            //            }];
            
            //            [self.payBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            //                make.top.equalTo(self.orderPayView.mas_bottom).offset(8);
            //                make.width.equalTo(self.scrollView).offset(-22);
            //                make.centerX.equalTo(self.scrollView);
            //            }];
        } else {
            //            [self.payBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            //                CGFloat topValue = ALScreenHeight - 45 - 64 - 20;
            //                make.top.mas_equalTo(topValue);
            //                make.width.equalTo(self.scrollView).offset(-22);
            //                make.centerX.equalTo(self.scrollView);
            //            }];
            
            //            [self.payMsgLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            //                make.centerX.equalTo(self.scrollView);
            //                make.bottom.equalTo(self.payBtn.mas_top).offset(-5);
            //            }];
            
            //            [self.payTimeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            //                make.centerX.equalTo(self.scrollView);
            //                make.bottom.equalTo(self.payMsgLab.mas_top).offset(-8);
            //            }];
        }
        
        if([_orderModel.orderType isEqualToString:@"1"]) {
            [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.view);
                make.height.equalTo(@44);
                make.left.bottom.equalTo(@0);
            }];
            
            [self.view layoutIfNeeded];
            self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.orderIdView.frame) + 54);
        } else {
            [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.view).multipliedBy(0.5);
                make.height.equalTo(@44);
                make.left.bottom.equalTo(@0);
            }];
            
            [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.bottom.equalTo(self.payBtn);
                make.right.equalTo(@0);
                make.left.equalTo(self.payBtn.mas_right);
            }];
            
            [self.view layoutIfNeeded];
            self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.orderPayView.frame) + 54);
        }
        
        
    } else if([_orderModel.orderStatus isEqualToString:OrderStatusWorking] || [_orderModel.orderStatus isEqualToString:OrderStatusAllocatingWaitStart]) {
        //        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消订单" style:UIBarButtonItemStylePlain target:self action:@selector(cancelOrderAction)];
        [self.orderSecurityView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderIdView.mas_bottom).offset(10);
            CGFloat height = self.orderDetailApi.orderModel.securityList.count * (68 + 1) + 28;
            make.height.equalTo(@(height));
            make.width.equalTo(self.scrollView).offset(-28);
            make.centerX.equalTo(self.scrollView);
        }];
        [self.view layoutIfNeeded];
        
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.orderSecurityView .frame) + 10);
    } else if([_orderModel.orderStatus isEqualToString:OrderStautsAllocating]) {
        
        //        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消订单" style:UIBarButtonItemStylePlain target:self action:@selector(cancelOrderAction)];
        
        [self.reminderLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.mas_equalTo(ALScreenHeight - 64 - 18);
        }];
        
        [self.view layoutIfNeeded];
        
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.reminderLab .frame) + 10);
    } else if([_orderModel.orderStatus isEqualToString:OrderStatusZ]) {
        [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.view);
            make.height.equalTo(@44);
            make.left.bottom.equalTo(@0);
        }];
        
        [self.view layoutIfNeeded];
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.orderIdView.frame) + 54);
    }
}

- (void)bindAction {
    AL_WeakSelf(self);
    _orderRedView.clickBlock = ^ {
        [MobClick event:ALMobEventID_E1];
        ALRedEnvelopeViewController *redEnvelopeVC = [[ALRedEnvelopeViewController alloc] init];
        redEnvelopeVC.orderId = weakSelf.orderModel.orderId;
        redEnvelopeVC.redEvelopeDelegate = weakSelf;
        redEnvelopeVC.selectedIndex = weakSelf.selectedIndex;
        [weakSelf.navigationController pushViewController:redEnvelopeVC animated:YES];
    };
    
    [_evaluateBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        ALEvaluateViewController *evaluateVC = [[ALEvaluateViewController alloc] init];
        evaluateVC.delegate = weakSelf;
        evaluateVC.orderModel = weakSelf.orderDetailApi.orderModel;
        evaluateVC.indexPath = weakSelf.indexPath;
        [weakSelf.navigationController pushViewController:evaluateVC animated:YES];
    }];
    
    if([self.orderModel.orderStatus isEqualToString:OrderStatusCancel] || [self.orderModel.orderStatus isEqualToString:OrderStatusFinished]) {
    }
    
    if([self.orderModel.orderStatus isEqualToString:OrderStatusWaitPay] || [self.orderModel.orderStatus isEqualToString:OrderStautsNew]) {
        [ALMobilePayService sharedInstance].PayCompltedHandleBlock = ^(ALPayHandle handel) {
            if([weakSelf.selectedRedEnvModel.couponId isVaild]) {
                [MobClick event:ALMobEventID_E2];
            }
            
            if(handel == ALPayHandleSuceess) {
                ALPaySuccessViewController *paySuccessVC = [[ALPaySuccessViewController alloc] init];
                paySuccessVC.payType = weakSelf.orderPayView.payType;
                paySuccessVC.orderModel = weakSelf.orderModel;
                paySuccessVC.paySuccessDelegate = weakSelf;
                paySuccessVC.isNewOrder = [weakSelf.orderModel.orderStatus isEqualToString:OrderStatusWaitPay] ? NO : YES;
                [weakSelf presentViewController:[[ALBaseNavigationController alloc] initWithRootViewController:paySuccessVC] animated:YES completion:nil];
                
                if([weakSelf.orderModel.orderStatus isEqualToString:OrderStatusWaitPay]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:ChangeListIndexStatus object:@{@"index" : @(weakSelf.indexPath),@"commond" : @"orderToPaySuccess"}];
                }
            }
        };
    }
    
    _orderSecurityView.itemDidSelectedAtIndex = ^(NSUInteger index) {
        if(index == 999) {
            ALDynamicsViewController *dynamicsVC = [ALDynamicsViewController new];
            dynamicsVC.orderId = weakSelf.orderModel.orderId;
            dynamicsVC.orderStatus = weakSelf.orderModel.orderStatus;
            [weakSelf.navigationController pushViewController:dynamicsVC animated:YES];
            //            ALRealTimePositionViewController *realTimePositionVC = [[ALRealTimePositionViewController alloc] init];
            //            realTimePositionVC.orderId = weakSelf.orderModel.orderId;
            //            [weakSelf.navigationController pushViewController:realTimePositionVC animated:YES];
        } else {
            ALSecurityInfoViewController *securityInfoVC = [[ALSecurityInfoViewController alloc] init];
            ALSecurityModel *securityModel = weakSelf.orderDetailApi.orderModel.securityList[index];
            securityInfoVC.securityId = securityModel.securityId;
            [weakSelf.navigationController pushViewController:securityInfoVC animated:YES];
        }
    };
}

#pragma mark ALEvaluateDelegate
- (void)EvaluateFinished {
    [self.evaluateBtn removeFromSuperview];
    self.evaluateBtn = nil;
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

#pragma mark ALPaySuccessDelegate
- (void)resetOrderStatusInInfoViewController {
    self.title = @"订单详情";
    [self.scrollView removeAllSubviews];
    self.orderDetailApi = nil;
    self.cancelOrderApi = nil;
    //    [self.timer invalidate];
    //    self.timer = nil;
    self.stepView = nil;
    self.orderIdView = nil;
    self.orderInfoView = nil;
    self.orderPayView = nil;
    self.orderRedView = nil;
    self.payBtn = nil;
    self.evaluateBtn = nil;
    //    self.payMsgLab = nil;
    //    self.payTimeLab = nil;
    self.reminderLab = nil;
    [self loadData];
}

- (void)backToOrderListViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backMainPageViewController {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark Action
- (void)dismissAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelOrderAction {
    AL_WeakSelf(self);
    [ALAlertViewController showAlertOnlyCancelButton:self title:nil message:@"镖师正在匹配中，确定要取消订单吗？取消后会重新排队等待派单。" style:UIAlertControllerStyleAlert Destructive:@"取消订单" clickBlock:^{
        weakSelf.cancelOrderApi = [[ALCancelOrderApi alloc] initWithCancelOrderApi:weakSelf.orderModel.orderId];
        
        [weakSelf.cancelOrderApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [MobClick event:ALMobEventID_F1];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [weakSelf resetOrderStatusInInfoViewController];
            
            //更新列表取消订单的状态
            [[NSNotificationCenter defaultCenter] postNotificationName:ChangeListIndexStatus object:@{@"index" : @(weakSelf.indexPath),@"commond" : @"orderToCancel"}];
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [ALKeyWindow showHudError:@"取消订单失败～"];
        }];
    }];
}

- (void)payAction {
    if([_orderModel.orderType isEqualToString:@"1"]) {
        AL_WeakSelf(self);
        if(self.orderPayView.payType == ALPayTypeAliPay) {
            _createAppPayApi = [[ALCreateAppPayApi alloc] initWithCreateAppPayApi:self.orderModel.orderId PayType:@"0" couponId:nil payChannel:@"aliPay"];
            
            [weakSelf.createAppPayApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                // NOTE: 调用支付结果开始支付
                [[ALMobilePayService sharedInstance] alipayWithOrderString:weakSelf.createAppPayApi.data[@"aliPayStr"]];
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                [ALKeyWindow showHudError:@"支付失败～"];
            }];
            
        } else {
            //微信支付
            _createAppPayApi = [[ALCreateAppPayApi alloc] initWithCreateAppPayApi:self.orderModel.orderId PayType:@"0" couponId:nil payChannel:@"wxPay"];
            
            [weakSelf.createAppPayApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                [[ALMobilePayService sharedInstance] wechatOayOrderString:weakSelf.createAppPayApi.data[@"wxPayStr"]];
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                [ALKeyWindow showHudError:@"支付失败～"];
                
            }];
        }
        [ALMobilePayService sharedInstance].PayCompltedHandleBlock = ^(ALPayHandle handel) {
            if(handel == ALPayHandleSuceess) {
                [weakSelf.payPresentView removeFromSuperview];
                weakSelf.payPresentView = nil;
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:ChangeListIndexStatus object:@{@"index" : @(weakSelf.indexPath),@"commond" : @"secondPaySuccess"}];
            }
        };
        
    } else {
        if([_orderModel.orderStatus isEqualToString:OrderStatusZ]) {
            AL_WeakSelf(self);
            weakSelf.sencondPayInitApi = [[ALSencondPayInitApi alloc] initSencondPayInitApi:weakSelf.orderModel.orderId];
            [weakSelf.sencondPayInitApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                weakSelf.sencondPayDic = weakSelf.sencondPayInitApi.data;
                weakSelf.couponId = @"";
                weakSelf.selectedIndex = 0;
                [weakSelf.payPresentView removeFromSuperview];
                weakSelf.payPresentView = nil;
                [weakSelf.payPresentView showToViewController:weakSelf];
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                
            }];
        } else {
            [self.payPresentView show];
        }
    }
    
}

//- (void)startTimeWithSecound:(int)secound {
//    AL_WeakSelf(self);
//
//    __block int startSecound = secound;
//
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
//        startSecound --;
//        [weakSelf setupPayCountDownSecound:startSecound];
//        if(startSecound == 0) {
//            [ALAlertViewController showAlertCustomCancelButton:weakSelf title:@"提示" message:@"订单支付超时" style:UIAlertControllerStyleAlert cancelTitle:@"我知道了" clickBlock:^{
//                if([weakSelf.orderModel.orderStatus isEqualToString:OrderStautsNew]) {
//                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
//                } else {
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:ChangeListIndexStatus object:@{@"index" : @(weakSelf.indexPath),@"commond" : @"orderToPayTimeOut"}];
//                }
//            }];
//
//            [timer invalidate];
//            timer = nil;
//        }
//    } repeats:YES];
//}

//- (void)setupPayCountDownSecound:(int)secound {
//    NSMutableAttributedString *resultAttr = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"支付时间：00:%02d:%02d",secound / 60 % 60,secound % 60)];
//    resultAttr.yy_font = ALMediumTitleFont(14);
//    [resultAttr yy_setFont:ALMediumTitleFont(16) range:NSMakeRange(5, 8)];
//    [resultAttr yy_setColor:[UIColor colorWithRGBA:ALThemeColor] range:NSMakeRange(5, 8)];
//    self.payTimeLab.attributedText = resultAttr;
//}

#pragma mark lazy load
- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (ALStepView *)stepView {
    if(!_stepView) {
        _stepView = [[ALStepView alloc] initWithFrame:CGRectZero title:@"第三步骤" subTitle:@"请选择支付方式"];
        [self.scrollView addSubview:_stepView];
    }
    return _stepView;
}

- (ALOrderInfoView *)orderInfoView {
    if(!_orderInfoView) {
        _orderInfoView = [[ALOrderInfoView alloc] initWithFrame:CGRectZero style:ALOrderInfoStyleInfo model:self.orderModel];
        [self.scrollView addSubview:_orderInfoView];
    }
    return _orderInfoView;
}

- (ALOrderInfoView *)orderIdView {
    if(!_orderIdView) {
        _orderIdView = [[ALOrderInfoView alloc] initWithFrame:CGRectZero style:ALOrderInfoStyleID model:self.orderModel];
        [self.scrollView addSubview:_orderIdView];
    }
    return _orderIdView;
}

- (ALOrderInfoView *)orderSecurityView {
    if(!_orderSecurityView) {
        _orderSecurityView = [[ALOrderInfoView alloc] initWithFrame:CGRectZero style:ALOrderInfoStyleSecurity model:self.orderModel];
        [self.scrollView addSubview:_orderSecurityView];
    }
    return _orderSecurityView;
}

- (ALLabel *)reminderLab {
    if(!_reminderLab) {
        _reminderLab = [[ALLabel alloc] init];
        [self.scrollView addSubview:_reminderLab];
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"温馨提示:订单会在后台持续发布，您只需联系领镖者即可"];
        attString.yy_font = ALThemeFont(12);
        attString.yy_color = [UIColor colorWithRGB:0x2A2A2A];
        [attString yy_setColor:[UIColor colorWithRGBA:ALThemeColor] range:NSMakeRange(0, 5)];
        _reminderLab.attributedText = attString;
        
    }
    return _reminderLab;
}

- (ALOrderInfoView *)orderRedView {
    if(!_orderRedView) {
        _orderRedView = [[ALOrderInfoView alloc] initWithFrame:CGRectZero style:ALOrderInfoStyleRedEnvelope model:self.orderModel];
        [self.scrollView addSubview:_orderRedView];
    }
    return _orderRedView;
}

- (ALOrderInfoView *)orderPayView {
    if(!_orderPayView) {
        _orderPayView = [[ALOrderInfoView alloc] initWithFrame:CGRectZero style:ALOrderInfoStylePay model:nil];
        [self.scrollView addSubview:_orderPayView];
    }
    return _orderPayView;
}

//- (YYLabel *)payTimeLab {
//    if(!_payTimeLab) {
//        _payTimeLab = [[YYLabel alloc] init];
//        _payTimeLab.textColor = [UIColor colorWithRGBA:0x666666FF];
//        [self.scrollView addSubview:_payTimeLab];
//        int sumSecond = (int)[_orderModel.expireInterval integerValue] - 1;
//        [self setupPayCountDownSecound:sumSecond];
//        [self startTimeWithSecound:sumSecond];
//    }
//    return _payTimeLab;
//}

//- (ALLabel *)payMsgLab {
//    if(!_payMsgLab) {
//        _payMsgLab = [[ALLabel alloc] init];
//        _payMsgLab.text = @"订单生成后1小时内未付款，订单将自动关闭";
//        _payMsgLab.font = ALThemeFont(13);
//        _payMsgLab.textColor = [UIColor colorWithRGBA:0x999999FF];
//        [self.scrollView addSubview:_payMsgLab];
//    }
//    return _payMsgLab;
//}

- (UIButton *)payBtn {
    if(!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        _payBtn.backgroundColor = [UIColor colorWithRGBA:ALThemeColor];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_payBtn];
    }
    return _payBtn;
}

- (UIButton *)cancelBtn {
    if(!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelOrderAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (UIButton *)evaluateBtn {
    if(!_evaluateBtn) {
        _evaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_evaluateBtn setImage:[UIImage imageNamed:@"btn-pingjia"] forState:UIControlStateNormal];
        [self.scrollView addSubview:_evaluateBtn];
    }
    return _evaluateBtn;
}

- (ALPayPresentView *)payPresentView {
    if(!_payPresentView) {
        AL_WeakSelf(self);
        
        if([_orderModel.orderStatus isEqualToString:OrderStatusZ]) {
            _payPresentView = [[ALPayPresentView alloc] initWithFrame:CGRectZero orderModel:_orderModel first:NO dic:self.sencondPayDic];
            
            _payPresentView.toRedEnv = ^{
                [MobClick event:ALMobEventID_E1];
                ALRedEnvelopeViewController *redEnvelopeVC = [[ALRedEnvelopeViewController alloc] init];
                redEnvelopeVC.orderId = weakSelf.orderModel.orderId;
                redEnvelopeVC.redEvelopeDelegate = weakSelf;
                redEnvelopeVC.selectedIndex = weakSelf.selectedIndex;
                [weakSelf.navigationController pushViewController:redEnvelopeVC animated:YES];
            };
        } else if([_orderModel.orderStatus isEqualToString:OrderStatusWaitPay]) {
            _payPresentView = [[ALPayPresentView alloc] initWithFrame:CGRectZero orderModel:_orderModel first:YES dic:nil];
        }
        
        _payPresentView.toPayBlock = ^(ALPayType payType) {
            if(payType == ALPayTypeAliPay) {
                
                _createAppPayApi = [[ALCreateAppPayApi alloc] initWithCreateAppPayApi:self.orderModel.orderId PayType:@"3" couponId:self.couponId payChannel:@"aliPay"];
                
                [weakSelf.createAppPayApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    // NOTE: 调用支付结果开始支付
                    [[ALMobilePayService sharedInstance] alipayWithOrderString:weakSelf.createAppPayApi.data[@"aliPayStr"]];
                }
                                                                           failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                                                                               [ALKeyWindow showHudError:@"支付失败～"];
                                                                           }];
                
            } else {
                //微信支付
                _createAppPayApi = [[ALCreateAppPayApi alloc] initWithCreateAppPayApi:self.orderModel.orderId PayType:@"3" couponId:self.couponId payChannel:@"wxPay"];
                
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
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//                [[NSNotificationCenter defaultCenter] postNotificationName:ChangeListIndexStatus object:@{@"index" : @(weakSelf.indexPath),@"commond" : @"secondPaySuccess"}];
            }
        };
    }
    return _payPresentView;
}

- (void)dealloc {
    [_orderDetailApi stop];
}
@end

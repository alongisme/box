//
//  ALConfirmationOrderViewController.m
//  bbxUser
//
//  Created by xlshi on 2018/1/22.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALConfirmationOrderViewController.h"
#import "ALConfirmationInfoView.h"
#import "ALConfirLinkManInfoView.h"
#import "ALConfirContentView.h"
#import "ALCancelOrderApi.h"
#import "ALPayPresentView.h"
#import "ALCreateAppPayApi.h"
#import "ALMobilePayService.h"

@interface ALConfirmationOrderViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) ALConfirmationInfoView *confirmationInfoView;
@property (nonatomic, strong) ALConfirLinkManInfoView *confirLinkManInfoView;
@property (nonatomic, strong) ALConfirContentView *confirContentView;
@property (nonatomic, strong) ALPayPresentView *payPresentView;

//底部view
@property (nonatomic, strong) ALShadowView *shadowView;
@property (nonatomic, strong) ALLabel *priceLab;
@property (nonatomic, strong) ALActionButton *nextStepBtn;

@property (nonatomic, strong) ALCancelOrderApi *cancelOrderApi;
@property (nonatomic, strong) ALCreateAppPayApi *createAppPayApi;
@end

@implementation ALConfirmationOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    [self initSubviews];
    
}

- (void)backAction {
    AL_WeakSelf(self);
    [ALAlertViewController showAlertOnlyCancelButton:self title:nil message:@"主人，你要放弃这笔订单么？" style:UIAlertControllerStyleAlert Destructive:@"确认放弃" clickBlock:^{
        
        weakSelf.cancelOrderApi = [[ALCancelOrderApi alloc] initWithCancelOrderApi:weakSelf.orderModel.orderId];
        
        [weakSelf.cancelOrderApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [MobClick event:ALMobEventID_F1];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [ALKeyWindow showHudError:@"取消订单失败～"];
        }];
    }];
}

- (void)initSubviews {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
        make.bottom.equalTo(@-120);
    }];
    
    [self.confirmationInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView).offset(-28);
        make.top.equalTo(@10);
        make.height.equalTo(@200);
    }];
    
    [self.confirLinkManInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView).offset(-28);
        make.top.equalTo(self.confirmationInfoView.mas_bottom).offset(10);
        make.height.equalTo(@210);
    }];
    
    if([_orderModel.content isVaild]) {
        [self.confirContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView).offset(-28);
            make.top.equalTo(self.confirLinkManInfoView.mas_bottom).offset(10);
            make.height.equalTo(@(self.confirContentView.contentHeight + 14 + 14));
        }];
    }

    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@120);
        make.bottom.equalTo(@0);
    }];
    
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-10);
        make.left.equalTo(@11);
        make.right.equalTo(@-11);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shadowView);
        make.top.equalTo(@20);
    }];

    [self.view layoutIfNeeded];

    [self.confirmationInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@([self.confirmationInfoView maxSubviewsY] + 10));
    }];
    [self.view layoutIfNeeded];

    if([_orderModel.content isVaild]) {
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.confirContentView.frame) + 15);
    } else {
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.confirLinkManInfoView.frame) + 15);
    }
}

- (void)nextStepAction {
    [self.payPresentView show];
}

#pragma mark lazy load
- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (ALConfirmationInfoView *)confirmationInfoView {
    if(!_confirmationInfoView) {
        _confirmationInfoView = [[ALConfirmationInfoView alloc] initWithFrame:CGRectZero orderModel:_orderModel];
        [self.scrollView addSubview:_confirmationInfoView];
    }
    return _confirmationInfoView;
}

- (ALConfirLinkManInfoView *)confirLinkManInfoView {
    if(!_confirLinkManInfoView) {
        _confirLinkManInfoView = [[ALConfirLinkManInfoView alloc] initWithFrame:CGRectZero orderModel:_orderModel];
        [self.scrollView addSubview:_confirLinkManInfoView];
    }
    return _confirLinkManInfoView;
}

- (ALConfirContentView *)confirContentView {
    if(!_confirContentView) {
        _confirContentView = [[ALConfirContentView alloc] initWithFrame:CGRectZero content:_orderModel.content];
        [self.scrollView addSubview:_confirContentView];
    }
    return _confirContentView;
}

- (ALActionButton *)nextStepBtn {
    if(!_nextStepBtn) {
        _nextStepBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        [_nextStepBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_nextStepBtn addTarget:self action:@selector(nextStepAction) forControlEvents:UIControlEventTouchUpInside];
        [self.shadowView addSubview:_nextStepBtn];
    }
    return _nextStepBtn;
}

- (ALShadowView *)shadowView {
    if(!_shadowView) {
        _shadowView = [[ALShadowView alloc] init];
        [self.view addSubview:_shadowView];
    }
    return _shadowView;
}

- (ALLabel *)priceLab {
    if(!_priceLab) {
        _priceLab = [[ALLabel alloc] init];
        NSMutableAttributedString *priceAttString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"预付：¥%@",_orderModel.firstPrice)];
        priceAttString.yy_font = ALMediumTitleFont(24);
        priceAttString.yy_color = [UIColor colorWithRGB:0xF8504F];
        [priceAttString yy_setTextHighlightRange:NSMakeRange(0, 3) color:[UIColor colorWithRGBA:ALLabelTextColor] backgroundColor:nil userInfo:nil];
        [priceAttString yy_setFont:ALThemeFont(16) range:NSMakeRange(0, 3)];
        _priceLab.attributedText = priceAttString;
        [self.shadowView addSubview:_priceLab];
    }
    return _priceLab;
}

- (ALPayPresentView *)payPresentView {
    if(!_payPresentView) {
        _payPresentView = [[ALPayPresentView alloc] initWithFrame:CGRectZero orderModel:_orderModel first:YES dic:nil];
        
        AL_WeakSelf(self);
        _payPresentView.toPayBlock = ^(ALPayType payType) {
            if(payType == ALPayTypeAliPay) {
                
                _createAppPayApi = [[ALCreateAppPayApi alloc] initWithCreateAppPayApi:self.orderModel.orderId PayType:@"0" couponId:nil payChannel:@"aliPay"];
                
                [weakSelf.createAppPayApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    // NOTE: 调用支付结果开始支付
                    [[ALMobilePayService sharedInstance] alipayWithOrderString:weakSelf.createAppPayApi.data[@"aliPayStr"]];
                }
                                                                   failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                                                                       [ALKeyWindow showHudError:@"支付失败～"];
                                                                   }];
                
            } else {
                //微信支付
                _createAppPayApi = [[ALCreateAppPayApi alloc] initWithCreateAppPayApi:self.orderModel.orderId PayType:@"0" couponId:nil payChannel:@"wxPay"];
                
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
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paySuccessToDynamics" object:@{@"orderId" :weakSelf.orderModel.orderId}];
            }
        };
    }
    return _payPresentView;
}

- (void)dealloc {
    [_cancelOrderApi stop];
    _createAppPayApi = nil;
    [_createAppPayApi stop];
    _createAppPayApi = nil;
}
@end

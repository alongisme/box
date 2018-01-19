//
//  ALExchangeCouponViewController.m
//  bbxUser
//
//  Created by along on 2017/8/4.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALExchangeCouponViewController.h"
#import "ALExChangeCouponApi.h"

@interface ALExchangeCouponViewController ()
@property (nonatomic, strong) ALShadowView *inputExchangeView;
@property (nonatomic, strong) ALActionButton *exchangeBtn;
@property (nonatomic, strong) ALExChangeCouponApi *exChangeCouponApi;
@end

@implementation ALExchangeCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换优惠券";
    
    [self initSubviews];
    
    [self bindAction];
}

- (void)initSubviews {
    [self.inputExchangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.mas_equalTo(ALNavigationBarHeight + 10);
        make.height.equalTo(@45);
    }];
    
    [self.exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.equalTo(self.inputExchangeView.mas_bottom).offset(20);
        make.height.equalTo(@42);
    }];
}

- (void)bindAction {
    AL_WeakSelf(self);
    [self.inputExchangeView addObserverBlockForKeyPath:@"exchangeEnable" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
        NSString *val = ALStringFormat(@"%@", newVal);
        weakSelf.exchangeBtn.enabled = val.boolValue;
    }];
}

#pragma mark Action
- (void)exchangeBtnCallAction {
    AL_WeakSelf(self);
    _exChangeCouponApi = [[ALExChangeCouponApi alloc] initWithExChangeCouponApi:self.inputExchangeView.textString];
    
    [_exChangeCouponApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MobClick event:ALMobEventID_E4];
        [weakSelf.inputExchangeView clearTextFiledString];
        [ALKeyWindow showHudSuccess:@"兑换成功～"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [ALKeyWindow showHudError:@"兑换失败～"];
    }];
}

#pragma mark lazy load
- (ALShadowView *)inputExchangeView {
    if(!_inputExchangeView) {
        _inputExchangeView = [[ALShadowView alloc] initWithFrame:CGRectZero placeholder:@"请输入兑换码" type:ALShadowStyleTextFiled];
        [self.view addSubview:_inputExchangeView];
    }
    return _inputExchangeView;
}

- (ALActionButton *)exchangeBtn {
    if(!_exchangeBtn) {
        _exchangeBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        [_exchangeBtn addTarget:self action:@selector(exchangeBtnCallAction) forControlEvents:UIControlEventTouchUpInside];
        [_exchangeBtn setBackgroundImage:[UIImage imageNamed:@"btn_duihuan_nor"] forState:UIControlStateNormal];
        [_exchangeBtn setBackgroundImage:[UIImage imageNamed:@"btn_duihuan_disabled"] forState:UIControlStateDisabled];
        _exchangeBtn.enabled = NO;
        [self.view addSubview:_exchangeBtn];
    }
    return _exchangeBtn;
}

- (void)dealloc {
    [_exChangeCouponApi stop];
    [self.inputExchangeView removeObserverBlocksForKeyPath:@"exchangeEnable"];
}
@end

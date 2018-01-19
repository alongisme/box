//
//  ALMyWalletViewController.m
//  bbxServer
//
//  Created by along on 2017/9/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMyWalletViewController.h"
#import "ALBalanceRecordViewController.h"
#import "ALMyBalanceApi.h"
#import "ALWithDrawToAliApi.h"

@interface ALMyWalletViewController ()
@property (nonatomic, strong) UIImageView *walletIconIV;
@property (nonatomic, strong) ALLabel *myMoneyLab;
@property (nonatomic, strong) ALLabel *moneyLab;
@property (nonatomic, strong) ALActionButton *toAliPayBtn;
@property (nonatomic, strong) ALMyBalanceApi *myBalanceApi;
@property (nonatomic, strong) ALWithDrawToAliApi *withDrawToAliApi;
@end

@implementation ALMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"余额记录" style:UIBarButtonItemStyleDone target:self action:@selector(moneyList)];
    [self loadData];
}

- (void)moneyList {
    [self.navigationController pushViewController:[[ALBalanceRecordViewController alloc] init] animated:YES];
}

- (void)loadData {
    _myBalanceApi = [[ALMyBalanceApi alloc] initMyBalanceApi];
    AL_WeakSelf(self);
    [_myBalanceApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf initSubviews];
        weakSelf.moneyLab.text = ALStringFormat(@"¥%@",weakSelf.myBalanceApi.balance);
        if([weakSelf.myBalanceApi.balance integerValue] <= 0) {
            weakSelf.toAliPayBtn.enabled = NO;
        }
        [weakSelf removeRequestStatusView];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
    _myBalanceApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _myBalanceApi.dataErrorBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusDataError];
    };
}

- (void)reloadData {
    [self loadData];
}

- (void)initSubviews {
    [self.walletIconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@120);
    }];
    
    [self.myMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.walletIconIV.mas_bottom).offset(24);
    }];
    
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.myMoneyLab.mas_bottom).offset(10);
    }];
    
    [self.toAliPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.bottom.equalTo(@-20);
    }];
}

#pragma mark Action
- (void)drawToAli {
    _withDrawToAliApi = [[ALWithDrawToAliApi alloc] initWithDrawToAliApi];
    
    AL_WeakSelf(self);
    [_withDrawToAliApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [ALKeyWindow showHudSuccess:@"提现申请已提交，将在1-3个工作日到账～"];
        weakSelf.moneyLab.text = @"¥0.00";
        weakSelf.toAliPayBtn.enabled = NO;
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark lazy load
- (UIImageView *)walletIconIV {
    if(!_walletIconIV) {
        _walletIconIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yue"]];
        [self.view addSubview:_walletIconIV];
    }
    return _walletIconIV;
}

- (ALLabel *)myMoneyLab {
    if(!_myMoneyLab) {
        _myMoneyLab = [[ALLabel alloc] init];
        _myMoneyLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        _myMoneyLab.font = ALThemeFont(15);
        _myMoneyLab.text = @"我的余额";
        [self.view addSubview:_myMoneyLab];
    }
    return _myMoneyLab;
}

- (ALLabel *)moneyLab {
    if(!_moneyLab) {
        _moneyLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _moneyLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        _moneyLab.font = ALThemeFont(22);
        [self.view addSubview:_moneyLab];
    }
    return _moneyLab;
}

- (ALActionButton *)toAliPayBtn {
    if(!_toAliPayBtn) {
        _toAliPayBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        [_toAliPayBtn addTarget:self action:@selector(drawToAli) forControlEvents:UIControlEventTouchUpInside];
        [_toAliPayBtn setTitle:@"提现到支付宝" forState:UIControlStateNormal];
        [self.view addSubview:_toAliPayBtn];
    }
    return _toAliPayBtn;
}

- (void)dealloc {
    [_myBalanceApi stop];
    [_withDrawToAliApi stop];
}
@end

//
//  ALOrderDetailViewController.m
//  bbxServer
//
//  Created by along on 2017/8/30.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALOrderDetailViewController.h"
#import "ALOrderInfoView.h"
#import "ALOrderDetailApi.h"
#import "ALSecurityInfoViewController.h"
#import "ALQuestionViewController.h"

@interface ALOrderDetailViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ALOrderInfoView *orderInfoView;
@property (nonatomic, strong) ALLabel *myPostitionDesLab;
@property (nonatomic, strong) ALOrderInfoView *orderSecurityView;
@property (nonatomic, strong) UIButton *questionBtn;

@property (nonatomic, strong) ALOrderDetailApi *orderDetailApi;
@end

@implementation ALOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
}

- (void)viewDidAppear:(BOOL)animated {
    [self loadData];
}

- (void)loadData {
    AL_WeakSelf(self);
    _orderDetailApi = [[ALOrderDetailApi alloc] initWithOrderDetailApi:_orderId];
    
    [_orderDetailApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf initSubviews];
        [weakSelf bindAction];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)initSubviews {
    
    NSString *addressString = self.orderDetailApi.orderModel.seviceAddress;
    CGFloat serverAddressWidth = [@"服务地址" widthForFont:ALThemeFont(14)] + 0.5;
    CGFloat singleHeight = [@"下" heightForFont:ALThemeFont(14) width:30];
    CGFloat baseHeight = 16 + singleHeight * 5 + 14 * 7 + 2;
    
    CGFloat addressHeight = [addressString heightForFont:ALThemeFont(14) width:ALScreenWidth - 14 - 14 - 14 - 14 - 14 - serverAddressWidth];
    
    [self.orderInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.width.equalTo(self.scrollView).offset(-28);
        make.centerX.equalTo(self.scrollView);
        make.height.equalTo(@(baseHeight + addressHeight));
    }];
    
    [self.myPostitionDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(self.orderInfoView.mas_bottom).offset(15);
    }];
    
    [self.questionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myPostitionDesLab.mas_right).offset(10);
        make.centerY.equalTo(self.myPostitionDesLab);
    }];
    
    [self.orderSecurityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.questionBtn.mas_bottom).offset(15);
        make.width.equalTo(self.scrollView).offset(-28);
        make.centerX.equalTo(self.scrollView);
        CGFloat height = self.orderDetailApi.orderModel.securityList.count * (68 + 1) + 28;
        make.height.equalTo(@(height));
    }];
    
    [self.view layoutIfNeeded];
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.orderSecurityView .frame) + 10);
}

- (void)bindAction {
    AL_WeakSelf(self);
    self.orderSecurityView.multiItemBlock = ^(NSUInteger index) {
        ALSecurityInfoViewController *securityInfoVC = [[ALSecurityInfoViewController alloc] init];
        ALSecurityModel *securityModel = weakSelf.orderDetailApi.orderModel.securityList[index];
        securityInfoVC.securityId = securityModel.securityId;
        [weakSelf.navigationController pushViewController:securityInfoVC animated:YES];
    };
}

#pragma mark lazy load
- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor colorWithRGBA:ALVCbgColor];
        self.view = _scrollView;
    }
    return _scrollView;
}

- (ALOrderInfoView *)orderInfoView {
    if(!_orderInfoView) {
        _orderInfoView = [[ALOrderInfoView alloc] initWithFrame:CGRectZero model:self.orderDetailApi.orderModel];
        [self.scrollView addSubview:_orderInfoView];
    }
    return _orderInfoView;
}

- (ALLabel *)myPostitionDesLab {
    if(!_myPostitionDesLab) {
        _myPostitionDesLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _myPostitionDesLab.text = ALStringFormat(@"本单角色：%@",self.orderDetailApi.orderModel.myPositionDes);
        [self.scrollView addSubview:_myPostitionDesLab];
    }
    return _myPostitionDesLab;
}

- (UIButton *)questionBtn {
    if(!_questionBtn) {
        _questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_questionBtn setBackgroundImage:[UIImage imageNamed:@"icon_question"] forState:UIControlStateNormal];
        [self.scrollView addSubview:_questionBtn];
        
        [_questionBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [ALKeyWindow.currentViewController.navigationController pushViewController:[ALQuestionViewController new] animated:YES];
        }];
    }
    return _questionBtn;
}

- (ALOrderInfoView *)orderSecurityView {
    if(!_orderSecurityView) {
        _orderSecurityView = [[ALOrderInfoView alloc] initWithSecurityFrame:CGRectZero model:self.orderDetailApi.orderModel];
        [self.scrollView addSubview:_orderSecurityView];
    }
    return _orderSecurityView;
}

- (void)dealloc {
    [_orderDetailApi stop];
}
@end

//
//  ALPaySuccessViewController.m
//  AnyHelp
//
//  Created by along on 2017/7/26.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALPaySuccessViewController.h"
#import "ALOrderInfoViewController.h"

@interface ALPaySuccessViewController ()
@property (nonatomic, strong) ALPaySuccessView *paySuceessView;
@end

@implementation ALPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MobClick event:ALMobEventID_E3];
    
    [self initNavigationOption];
    
    [self initsubviews];
    
    [self bindAction];
}

- (void)bindAction {
    AL_WeakSelf(self);
    [self.paySuceessView.orderInfoBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if([weakSelf.paySuccessDelegate respondsToSelector:@selector(resetOrderStatusInInfoViewController)]) {
            [weakSelf.paySuccessDelegate resetOrderStatusInInfoViewController];
        }
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark ConfigureNavigation
- (void)initNavigationOption {
    self.title = @"支付成功";
    UIBarButtonItem *closeItem = [self createButtonItemWithImageName:@"icon_close_nor" selector:@selector(dismissAction)];
    self.navigationItem.leftBarButtonItem = closeItem;
}

#pragma mark Action
- (void)dismissAction {
    if(_isNewOrder) {
        [ALKeyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        if([self.paySuccessDelegate respondsToSelector:@selector(backToOrderListViewController)]) {
            [self.paySuccessDelegate backToOrderListViewController];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)initsubviews {
    [self.paySuceessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.equalTo(@80);
        make.height.equalTo(@190);
    }];
}

#pragma mark lazy load
- (ALPaySuccessView *)paySuceessView {
    if(!_paySuceessView) {
        _paySuceessView = [[ALPaySuccessView alloc] initWithFrame:CGRectZero type:_payType];
        [self.view addSubview:_paySuceessView];
    }
    return _paySuceessView;
}
@end

//
//  ALSystemSettingViewController.m
//  bbxUser
//
//  Created by along on 2017/8/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSystemSettingViewController.h"
#import "ALAboutUsViewController.h"
#import "ALFeedBackViewController.h"
#import <JPUSHService.h>
#import "ALSetPasswordViewController.h"
#import "ALAuthStatusViewController.h"

@interface ALSystemSettingViewController ()
@property (nonatomic, strong) ALShadowView *itemView;
@end

@implementation ALSystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统设置";
    
    [self initSubviews];
    
    [self bindAction];
}

- (void)initSubviews {
    [self.itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.top.equalTo(@(ALNavigationBarHeight + 10));
        make.height.equalTo(@184);
    }];
}

- (void)bindAction {
    AL_WeakSelf(self);
    self.itemView.multiItemBlock = ^(NSUInteger index) {
        if(index == 1) {
            ALSetPasswordViewController *setPasswordVC = [[ALSetPasswordViewController alloc] init];
            setPasswordVC.title = @"重置密码";
            [weakSelf.navigationController pushViewController:setPasswordVC animated:YES];
        } else if(index == 2) {
            [weakSelf.navigationController pushViewController:[[ALAboutUsViewController alloc] init] animated:YES];
        } else if(index == 3) {
            [weakSelf.navigationController pushViewController:[[ALFeedBackViewController alloc] init] animated:YES];
        } else if(index == 4) {
            [weakSelf.navigationController pushViewController:[[ALAuthStatusViewController alloc] init] animated:YES];
        }
    };
}

#pragma mark lazy load
- (ALShadowView *)itemView {
    if(!_itemView) {
        _itemView = [[ALShadowView alloc] initWithFrame:CGRectZero titleArray:@[@"重置密码",@"关于我们",@"意见反馈",@"个人认证"] contentArray:@[@"",@"",@"",AL_MyAppDelegate.authModel.authMsg ? AL_MyAppDelegate.authModel.authMsg : @""] rightView:YES];
        [self.view addSubview:_itemView];
    }
    return _itemView;
}


@end

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
        make.top.mas_equalTo(ALNavigationBarHeight + 10);
        make.height.equalTo(@92);
    }];
}

- (void)bindAction {
    AL_WeakSelf(self);
    self.itemView.multiItemBlock = ^(NSUInteger index) {
        if(index == 1) {
            [weakSelf.navigationController pushViewController:[[ALAboutUsViewController alloc] init] animated:YES];
        } else if(index == 2) {
            if(AL_MyAppDelegate.userModel.idModel.userId)
                [weakSelf.navigationController pushViewController:[[ALFeedBackViewController alloc] init] animated:YES];
            else
                [[NSNotificationCenter defaultCenter] postNotificationName:ReSetToLoginModule object:nil];
        }
    };
}

#pragma mark lazy load
- (ALShadowView *)itemView {
    if(!_itemView) {
        _itemView = [[ALShadowView alloc] initWithSystemSetting:CGRectZero];
        [self.view addSubview:_itemView];
    }
    return _itemView;
}
@end

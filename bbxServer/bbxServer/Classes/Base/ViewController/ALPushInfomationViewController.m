//
//  ALPushInfomationViewController.m
//  bbxUser
//
//  Created by xlshi on 2017/12/4.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALPushInfomationViewController.h"

@interface ALPushInfomationViewController ()

@end

@implementation ALPushInfomationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"shadowLine"]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGBA:ALThemeColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"icon_push_back"];
    UIButton *pushBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [pushBackBtn setBackgroundImage:image forState:UIControlStateNormal];
    [pushBackBtn setImage:image forState:UIControlStateNormal];
    [pushBackBtn setTitle:@"返回" forState:UIControlStateNormal];
    pushBackBtn.titleLabel.font = ALThemeFont(16);
    [pushBackBtn setTitleColor:[UIColor colorWithRGB:0x030303] forState:UIControlStateNormal];
    [pushBackBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -pushBackBtn.titleLabel.bounds.size.width - 10, 0, -pushBackBtn.titleLabel.bounds.size.width)];
    [pushBackBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:pushBackBtn];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

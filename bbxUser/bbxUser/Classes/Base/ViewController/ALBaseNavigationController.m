//
//  ALBaseNavigationController.m
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseNavigationController.h"
#import "ALOrderViewController.h"

@interface ALBaseNavigationController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property (nonatomic, weak) id popDelegate;
@end

@implementation ALBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

//显示自定义view
- (void)showCustomView {
    self.navigationBar.hidden = YES;
    self.customNavigationView.hidden = NO;
}

//移除自定义view
- (void)hideCustomView {
    self.navigationBar.hidden = NO;
    [self setNavigationBarHidden:NO animated:YES];
    self.customNavigationView.hidden = YES;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if([viewController isKindOfClass:NSClassFromString(@"ALMainPageViewController")]) {
        [self showCustomView];
    } else if([viewController isKindOfClass:NSClassFromString(@"ALStepOneViewController")] || [viewController isKindOfClass:NSClassFromString(@"ALInstructionsViewController")] || [viewController isKindOfClass:NSClassFromString(@"ALOrderViewController")] || [viewController isKindOfClass:NSClassFromString(@"ALCallBBXViewController")] || [viewController isKindOfClass:NSClassFromString(@"ALDynamicsViewController")] || [viewController isKindOfClass:NSClassFromString(@"ALOrderInfoViewController")]) {
        [self hideCustomView];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if([viewController isKindOfClass:NSClassFromString(@"ALBaseWebViewController")] || [viewController isKindOfClass:NSClassFromString(@"ALConfirmationOrderViewController")]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    } else if([viewController isKindOfClass:NSClassFromString(@"ALOrderViewController")]) {
        ALOrderViewController *orderViewController = (ALOrderViewController *)viewController;
        self.interactivePopGestureRecognizer.enabled = !orderViewController.closePopGestureRecognizerEnabled;
    } else{
        self.interactivePopGestureRecognizer.enabled = YES;
        if(viewController == [self.viewControllers firstObject]) {
            self.interactivePopGestureRecognizer.delegate = self.popDelegate;
        } else {
            self.interactivePopGestureRecognizer.delegate = nil;
        }
    }
}

- (ALCustomNavigationView *)customNavigationView {
    if(!_customNavigationView) {
        _customNavigationView = [[ALCustomNavigationView alloc] init];
        [self.view addSubview:_customNavigationView];
        
        [_customNavigationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(@0);
            make.height.mas_equalTo(ALNavigationBarHeight + 42);
        }];
    }
    return _customNavigationView;
}
@end

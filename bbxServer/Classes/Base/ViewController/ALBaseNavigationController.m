//
//  ALBaseNavigationController.m
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseNavigationController.h"

@interface ALBaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation ALBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    if([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if(self.viewControllers.count > 0) {
//        viewController.navigationItem.leftBarButtonItem = [self backBarButtonItem:viewController];
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    [super pushViewController:viewController animated:animated];
//}
//
//- (UIBarButtonItem *)backBarButtonItem:(UIViewController *)viewController {
//    
//    UIImage *image = [UIImage imageNamed:@"Back Chevron"];
//    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn setImage:image forState:UIControlStateNormal];
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wundeclared-selector"
//    [backBtn addTarget:viewController action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//#pragma clang diagnostic pop
//    backBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    
//    return backItem;
//}
@end

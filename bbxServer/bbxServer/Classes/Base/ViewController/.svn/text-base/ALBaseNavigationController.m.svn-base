//
//  ALBaseNavigationController.m
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseNavigationController.h"

@interface ALBaseNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@property (nonatomic, weak) id popDelegate;
@end

@implementation ALBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if(viewController == [self.viewControllers firstObject]) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    } else {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
@end

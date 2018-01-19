//
//  ALBaseViewController.m
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"

@interface ALBaseViewController ()

@end

@implementation ALBaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    ALBaseViewController *baseViewController = [super allocWithZone:zone];
    
    [baseViewController commonOption];
    
    return baseViewController;
}

- (void)commonOption {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRGBA:ALVCbgColor];
    
    if(self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [self createButtonItemWithImageName:@"Back Chevron" selector:@selector(backAction)];
    }
}

- (UIBarButtonItem *)createButtonItemWithImageName:(NSString *)imageName selector:(SEL)selector {
    UIImage *img = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButtonItem;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

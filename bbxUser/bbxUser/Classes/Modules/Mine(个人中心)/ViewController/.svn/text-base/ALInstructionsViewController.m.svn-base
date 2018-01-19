//
//  ALInstructionsViewController.m
//  bbxUser
//
//  Created by along on 2017/9/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALInstructionsViewController.h"
#import "ALBaseNavigationController.h"

@interface ALInstructionsViewController ()

@end

@implementation ALInstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"功能介绍";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    UIImage *image = [UIImage imageNamed:@"shiyongshuoming"];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [scrollView addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, image.size.height * self.view.frame.size.width / image.size.width);
    
    if([UIScreen mainScreen].bounds.size.width == 414) {
        scrollView.contentSize = CGSizeMake(0, image.size.height + 128);
    } else if([UIScreen mainScreen].bounds.size.width == 320) {
        scrollView.contentSize = CGSizeMake(0, image.size.height - 128);
    } else {
        scrollView.contentSize = CGSizeMake(0, image.size.height);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //这里在做一次隐藏 是防止手势返回时 导航栏没有变
    ((ALBaseNavigationController *)self.navigationController).customNavigationView.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

@end

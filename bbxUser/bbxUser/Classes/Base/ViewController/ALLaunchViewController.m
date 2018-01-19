//
//  ALLaunchViewController.m
//  bbxUser
//
//  Created by along on 2017/9/15.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALLaunchViewController.h"
#import "ALMainPageViewController.h"

@interface ALLaunchViewController ()

@end

@implementation ALLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    NSArray *imageArray = @[@"first",@"second",@"third"];
    for (unsigned int i = 0; i < imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i * ALScreenWidth, 0, ALScreenWidth, ALScreenHeight);
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [scrollView addSubview:imageView];
        
        if(i == imageArray.count - 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [scrollView addSubview:btn];
            
            btn.frame = CGRectMake(2 * ALScreenWidth + (ALScreenWidth - ALScreenWidth * 0.36) / 2, ALScreenHeight * 0.81, ALScreenWidth * 0.36, ALScreenHeight * 0.06);
            [btn addTarget:self action:@selector(startAppAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    scrollView.contentSize = CGSizeMake(imageArray.count * ALScreenWidth, 0);
}

- (void)startAppAction {
    [[NSNotificationCenter defaultCenter] postNotificationName:ReSetToMainPageModule object:nil];
}

@end

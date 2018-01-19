//
//  ALAuthStateViewController.m
//  bbxServer
//
//  Created by along on 2017/8/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAuthStateViewController.h"
#import "ALAuthenticationViewController.h"

@interface ALAuthStateViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) ALActionButton *subBtn;
@end

@implementation ALAuthStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交资料";
    [self initSubviews];
    
    if(self.hideBackButton) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    }
}

- (void)initSubviews {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(ALScreenWidth == 320) {
            CGFloat wid = self.imageView.image.size.width * 0.8;
            CGFloat hei = self.imageView.image.size.height * 0.8;
            make.width.mas_equalTo(wid);
            make.height.mas_equalTo(hei);
        } 
        make.top.equalTo(@84);
        make.centerX.equalTo(self.view);
    }];
    
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.bottom.equalTo(@-10);
    }];
}

- (void)subAction {
    [self.navigationController pushViewController:[[ALAuthenticationViewController alloc] init] animated:YES];
}

#pragma mark lazy load
- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"subInfo"]];
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (ALActionButton *)subBtn {
    if(!_subBtn) {
        _subBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        [_subBtn setTitle:@"提交资料" forState:UIControlStateNormal];
        [_subBtn addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_subBtn];
    }
    return _subBtn;
}
@end

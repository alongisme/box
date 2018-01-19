//
//  ALUpdateServerTagViewController.m
//  bbxServer
//
//  Created by along on 2017/8/30.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALUpdateServerTagViewController.h"
#import "ALServerTagView.h"

@interface ALUpdateServerTagViewController () <ALServerTagDelegate>
@property (nonatomic, strong) ALServerTagView *serverTagView;
@end

@implementation ALUpdateServerTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务标签";
    
    [self initSubviews];
}

- (void)initSubviews {
    [self.serverTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.top.mas_equalTo(ALNavigationBarHeight + 10);
        make.height.equalTo(@(50));
    }];
}

#pragma mark ALServerTagDelegate
- (void)clickedLabVievUpdate:(NSUInteger)value {
    [self.serverTagView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(value + 10));
    }];
}

#pragma mark lazy load
- (ALServerTagView *)serverTagView {
    if(!_serverTagView) {
        _serverTagView = [[ALServerTagView alloc] init];
        _serverTagView.delegate = self;
        [self.view addSubview:_serverTagView];
    }
    return _serverTagView;
}
@end

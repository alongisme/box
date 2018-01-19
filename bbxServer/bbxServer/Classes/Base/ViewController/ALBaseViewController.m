//
//  ALBaseViewController.m
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"

@interface ALBaseViewController ()
@property (nonatomic, strong) ALRequestStatusView *requestStatusView;
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
        self.navigationItem.leftBarButtonItem = [self createButtonItemWithImageName:@"icon-back" selector:@selector(backAction)];
    }
}

- (void)showRequestStauts:(ALRequestStatus)status {
    [self removeRequestStatusView];
    
    _requestStatusView = [[ALRequestStatusView alloc] initWithFrame:CGRectZero status:status];
    [self.view addSubview:_requestStatusView];
    
    AL_WeakSelf(self);
    _requestStatusView.reloadDataBlock = ^{
        [weakSelf reloadData];
    };
    
    [_requestStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)removeRequestStatusView {
    if(_requestStatusView) {
        [_requestStatusView removeFromSuperview];
        _requestStatusView = nil;
    }
}

- (void)reloadData {}

- (UIBarButtonItem *)createButtonItemWithImageName:(NSString *)imageName selector:(SEL)selector {
    UIImage *img = [UIImage imageNamed:imageName];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:selector];
    return barButtonItem;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

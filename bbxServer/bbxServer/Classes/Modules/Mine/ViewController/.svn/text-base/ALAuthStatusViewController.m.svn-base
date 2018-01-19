//
//  ALAuthStatusViewController.m
//  bbxServer
//
//  Created by along on 2017/9/1.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAuthStatusViewController.h"
#import "ALStatusView.h"

@interface ALAuthStatusViewController ()
@property (nonatomic, strong) ALStatusView *statusView;
@end

@implementation ALAuthStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人认证";
    
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
}

#pragma mark lazy load
- (ALStatusView *)statusView {
    if(!_statusView) {
        ALAuthStatus authStatus = 0;
        if([AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusFirst] || [AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusSecond] || [AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusThird]) {
            authStatus = ALAuthStatusing;
        } else if([AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusFirstReject] || [AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusSecondReject] || [AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusThirdReject]) {
            authStatus = ALAuthStatusFaild;
        } else if([AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusSuccess]) {
            authStatus = ALAuthStatusSuccess;
        }
        _statusView = [[ALStatusView alloc] initWithFrame:CGRectZero status:authStatus];
        [self.view addSubview:_statusView];
    }
    return _statusView;
}
@end

//
//  ALMainPageViewController.m
//  bbxServer
//
//  Created by along on 2017/8/29.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMainPageViewController.h"
#import "ALMineViewController.h"
#import "ALMyDoingOrderApi.h"
#import "ALAuthStateViewController.h"
#import "ALStatusView.h"
#import "ALStartOrderReceivingApi.h"
#import "ALWorkingView.h"
#import "ALSecurityLocationApi.h"
#import "ALAuthenticationViewController.h"

@interface ALMainPageViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) ALStatusView *statusView;
@property (nonatomic, strong) ALMyDoingOrderApi *myDoingOrderApi;
@property (nonatomic, strong) ALStartOrderReceivingApi *startOrderReceivingApi;
@property (nonatomic, strong) ALActionButton *reSubInfoBtn;

@property (nonatomic, strong) ALWorkingView *workingView;
@property (nonatomic, strong) NSTimer *reloadTimer;
@property (nonatomic, assign) CGFloat lastContentOffsetY;
@end

@implementation ALMainPageViewController

- (void)viewDidAppear:(BOOL)animated {
    [self loadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [_myDoingOrderApi stop];
    if(self.reloadTimer) {
        [self.reloadTimer invalidate];
        self.reloadTimer = nil;
    }
}

- (void)loadData {
    if(![AL_MyAppDelegate.userModel.idModel.userId isVaild]) {
        return;
    }
    _myDoingOrderApi = [[ALMyDoingOrderApi alloc] initMyDoingOrderApi];
    AL_WeakSelf(self);
    [_myDoingOrderApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        AL_MyAppDelegate.authModel.authStatus = weakSelf.myDoingOrderApi.myDoingOrderModel.authStatus;
        AL_MyAppDelegate.authModel.authMsg = weakSelf.myDoingOrderApi.myDoingOrderModel.authMsg;
        if([weakSelf.myDoingOrderApi.myDoingOrderModel.authStatus isEqualToString:UserAuthStatusInit]) {
            ALAuthStateViewController *authStateVC = [[ALAuthStateViewController alloc] init];
            authStateVC.hideBackButton = YES;
            [weakSelf.navigationController pushViewController:authStateVC animated:NO];
        } else {
            [weakSelf initSubviews];
            weakSelf.navigationItem.rightBarButtonItem = [weakSelf createButtonItemWithImageName:@"icon-Personal Center" selector:@selector(userCenterAction)];
        }
        
        if([weakSelf.myDoingOrderApi.myDoingOrderModel.hasOrder integerValue] == 1) {
            [weakSelf removeSubviews];
            
            [weakSelf.workingView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.centerX.equalTo(self.view);
                    make.bottom.top.equalTo(@0);
                }];
            
            [weakSelf.view layoutIfNeeded];
            [weakSelf.workingView setContentOffset:CGPointMake(0, weakSelf.lastContentOffsetY) animated:NO];
        }
        
        if([weakSelf.myDoingOrderApi.myDoingOrderModel.isOnline integerValue] == 1) {
            if(!weakSelf.reloadTimer) {
                [[ALBaiduLocation shardInstance] startUserLocationService];
                weakSelf.reloadTimer = [NSTimer scheduledTimerWithTimeInterval:30.0f target:weakSelf selector:@selector(startOrderCanWorkingAction) userInfo:nil repeats:YES];
            }
        }
        
        [weakSelf removeRequestStatusView];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

    }];
    
    _myDoingOrderApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _myDoingOrderApi.dataErrorBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusDataError];
    };
}

- (void)reloadData {
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"镖镖服务端";
//    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeTimer) name:@"closeTimer" object:nil];
}

- (void)closeTimer {
    [[ALBaiduLocation shardInstance] stopUserLocationService];
    [self.reloadTimer invalidate];
    self.reloadTimer = nil;
}

- (void)removeSubviews {
    if(_statusView) {
        [_statusView removeFromSuperview];
        _statusView = nil;
    }
    
    if(_reSubInfoBtn) {
        [_reSubInfoBtn removeFromSuperview];
        _reSubInfoBtn = nil;
    }
    
    if(_workingView) {
        [_workingView removeFromSuperview];
        _workingView = nil;
    }
}

- (void)initSubviews {
    
    [self removeSubviews];
    
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64,0,0,0));
    }];
    
    if([AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusFirstReject] || [AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusSuccess]) {
        
        [self.reSubInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.right.equalTo(@-14);
            make.bottom.equalTo(@-15);
        }];
        
        if([self.myDoingOrderApi.myDoingOrderModel.isOnline integerValue] == 1) {
            self.reSubInfoBtn.selected = YES;
            [self.statusView setValue:[UIImage imageNamed:@"Waiting for dispatch"] forKeyPath:@"_IV.image"];
            [self.statusView setValue:@"正在等待派单~" forKeyPath:@"_subLab.text"];
        }
    }
}

- (void)startOrderCanWorkingAction {
    [self loadData];
}

#pragma mark Action
- (void)userCenterAction {
    [self.navigationController presentViewController:[[ALBaseNavigationController alloc] initWithRootViewController:[[ALMineViewController alloc] init]] animated:YES completion:nil];
}

- (void)reSubInfoButtonAction {
    AL_WeakSelf(self);
    if([AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusSuccess]) {
        if(self.reSubInfoBtn.selected) {
            _startOrderReceivingApi = [[ALStartOrderReceivingApi alloc] initStartOrderReceiving:@"0"];
            
            [_startOrderReceivingApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                [weakSelf.reloadTimer invalidate];
                weakSelf.reloadTimer = nil;
                [weakSelf.statusView setValue:[UIImage imageNamed:@"Waiting for orders"] forKeyPath:@"_IV.image"];
                [weakSelf.statusView setValue:@"您还没有开始接单哟~" forKeyPath:@"_subLab.text"];
                weakSelf.reSubInfoBtn.selected = !weakSelf.reSubInfoBtn.selected;
                
                //停止定位
                [[ALBaiduLocation shardInstance] stopUserLocationService];

            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                
            }];
        } else {
            _startOrderReceivingApi = [[ALStartOrderReceivingApi alloc] initStartOrderReceiving:@"1"];
            
            [_startOrderReceivingApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                [weakSelf.statusView setValue:[UIImage imageNamed:@"Waiting for dispatch"] forKeyPath:@"_IV.image"];
                [weakSelf.statusView setValue:@"正在等待派单~" forKeyPath:@"_subLab.text"];
                weakSelf.reloadTimer = [NSTimer scheduledTimerWithTimeInterval:30.0f target:weakSelf selector:@selector(startOrderCanWorkingAction) userInfo:nil repeats:YES];
                weakSelf.reSubInfoBtn.selected = !weakSelf.reSubInfoBtn.selected;
                
                //启动定位
                [[ALBaiduLocation shardInstance] startUserLocationService];
                
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                
            }];
        }
    } else {
        [self.navigationController pushViewController:[[ALAuthStateViewController alloc] init] animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.lastContentOffsetY = scrollView.contentOffset.y;
}

#pragma mark lazy load
- (ALStatusView *)statusView {
    if(!_statusView) {
        _statusView = [[ALStatusView alloc] initWithFrame:CGRectZero sourceDic:self.myDoingOrderApi.data];
        [self.view addSubview:_statusView];
    }
    return _statusView;
}

- (ALWorkingView *)workingView {
    if(!_workingView) {
        _workingView = [[ALWorkingView alloc] initWithFrame:CGRectZero model:self.myDoingOrderApi.myDoingOrderModel];
        _workingView.delegate = self;
        [self.view addSubview:_workingView];
        
        AL_WeakSelf(self);
        _workingView.orderCompleteBlock = ^{
            [weakSelf loadData];
        };
        
        _workingView.headTapAction = ^(UIViewController *viewController) {
            [weakSelf.navigationController pushViewController:viewController animated:YES];
        };
        
    }
    return _workingView;
}

- (ALActionButton *)reSubInfoBtn {
    if(!_reSubInfoBtn) {
        _reSubInfoBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        if([AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusSuccess]) {
            [_reSubInfoBtn setTitle:@"开始接单" forState:UIControlStateNormal];
            [_reSubInfoBtn setTitle:@"结束接单" forState:UIControlStateSelected];
        } else {
            [_reSubInfoBtn setTitle:@"重新提交材料" forState:UIControlStateNormal];
        }

        [_reSubInfoBtn addTarget:self action:@selector(reSubInfoButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_reSubInfoBtn];
    }
    return _reSubInfoBtn;
}

- (void)dealloc {
    [_reloadTimer invalidate];
    _reloadTimer = nil;
    [_startOrderReceivingApi stop];
    _startOrderReceivingApi = nil;
    [_myDoingOrderApi stop];
    _myDoingOrderApi = nil;
}
@end

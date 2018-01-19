//
//  ALWorkingView.m
//  bbxServer
//
//  Created by along on 2017/9/1.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALWorkingView.h"
#import "ALLeaderView.h"
#import "ALOrderInfoView.h"
#import "ALStartMissionApi.h"
#import "ALCompleteMissionApi.h"
#import <CoreLocation/CoreLocation.h>
#import "ALSecurityInfoViewController.h"
#import "ALOrderFinishedView.h"
#import "ALQuestionViewController.h"

@interface ALWorkingView ()
@property (nonatomic, strong) ALMyDoingOrderModel *model;
@property (nonatomic, strong) ALLeaderView *leaderView;
@property (nonatomic, strong) ALOrderInfoView *orderInfoView;
@property (nonatomic, strong) ALLabel *myPostitionDesLab;
@property (nonatomic, strong) UIButton *questionBtn;
@property (nonatomic, strong) ALActionButton *taskBtn;
@property (nonatomic, strong) ALOrderInfoView *orderSecurityView;
@property (nonatomic, strong) NSTimer *taskTimer;
@property (nonatomic, strong) ALStartMissionApi *startMissApi;
@property (nonatomic, strong) ALCompleteMissionApi *completeMissionApi;
@property (nonatomic, assign) NSUInteger timerValue;
@property (nonatomic, assign) NSUInteger currentY;
@end

@implementation ALWorkingView

- (instancetype)initWithFrame:(CGRect)frame model:(ALMyDoingOrderModel *)model {
    if(self = [super initWithFrame:frame]) {
        _model = model;
        self.bounces = NO;
        if([model.orderInfo.orderStatus isEqualToString:OrderStatusWorking]) {
            self.taskBtn.enabled = NO;
            if([model.orderInfo.expireInterval isEqualToNumber:@0]) {
                if([model.orderInfo.myPosition isEqualToNumber:@1]) {
                    [self.taskBtn setTitle:@"结束任务" forState:UIControlStateNormal];
                    self.taskBtn.enabled = YES;
                } else {
                    [self.taskBtn setTitle:@"等待领队结束" forState:UIControlStateDisabled];
                }
            } else {
                self.timerValue = [model.orderInfo.expireInterval integerValue];
                NSString *currentValue = ALStringFormat(@"%02lu:%02lu:%02lu",self.timerValue / 3600,self.timerValue / 60 % 60,self.timerValue % 60);
                
                [self.taskBtn setTitle:ALStringFormat(@"能量剩余：%@",currentValue) forState:UIControlStateDisabled];
                self.timerValue = [model.orderInfo.expireInterval integerValue];
                self.taskTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(taskTimerAction) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.taskTimer forMode:NSRunLoopCommonModes];
            }
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.leaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).offset(-28);
        make.centerX.equalTo(self);
        make.top.equalTo(@10);
        make.height.equalTo(@72);
    }];
    
    NSString *addressString = _model.orderInfo.seviceAddress;
    CGFloat serverAddressWidth = [@"服务地址" widthForFont:ALThemeFont(15)] + 0.5;
    CGFloat singleHeight = [@"下" heightForFont:ALThemeFont(14) width:30];
    CGFloat baseHeight = 16 + singleHeight * 5 + 14 * 7 + 2;
    
    CGFloat addressHeight = [addressString heightForFont:ALThemeFont(14) width:ALScreenWidth - 14 - 14 - 14 - 14 - 14 - serverAddressWidth];
    
    [self.orderInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self.leaderView);
        make.top.equalTo(self.leaderView.mas_bottom).offset(10);
        make.height.equalTo(@(baseHeight + addressHeight));
    }];
    
    [self.myPostitionDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(self.orderInfoView.mas_bottom).offset(15);
    }];
    
    [self.questionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myPostitionDesLab.mas_right).offset(10);
        make.centerY.equalTo(self.myPostitionDesLab);
    }];
    
    [self.taskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self.orderInfoView);
        make.top.equalTo(self.myPostitionDesLab.mas_bottom).offset(15);
    }];
    
    [self.orderSecurityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.taskBtn.mas_bottom).offset(8);
        make.width.equalTo(self).offset(-28);
        make.centerX.equalTo(self);
        CGFloat height = _model.orderInfo.securityList.count * (68 + 1) + 28;
        make.height.equalTo(@(height));
    }];
    
    [self layoutIfNeeded];
    
    self.contentSize = CGSizeMake(0, CGRectGetMaxY(self.orderSecurityView .frame) + 10);
}

- (void)taskTimerAction {
    self.taskBtn.enabled = NO;

    self.timerValue--;
    
    NSString *currentValue = ALStringFormat(@"%02lu:%02lu:%02lu",self.timerValue / 3600,self.timerValue / 60 % 60,self.timerValue % 60);
    
    [self.taskBtn setTitle:ALStringFormat(@"能量剩余：%@",currentValue) forState:UIControlStateDisabled];
    
    if([currentValue isEqualToString:@"00:00:00"]) {
        [self.taskTimer invalidate];
        self.taskTimer = nil;
        
        if([self.model.orderInfo.myPosition integerValue] == 1) {
            self.taskBtn.enabled = YES;
            [self.taskBtn setTitle:@"结束任务" forState:UIControlStateNormal];
        } else {
            [self.taskBtn setTitle:@"等待领队结束" forState:UIControlStateDisabled];
        }
    }
}

#pragma mark lazy load
- (ALLeaderView *)leaderView {
    if(!_leaderView) {
        _leaderView = [[ALLeaderView alloc] initWithFrame:CGRectZero model:_model];
        [self addSubview:_leaderView];
    }
    return _leaderView;
}

- (ALOrderInfoView *)orderInfoView {
    if(!_orderInfoView) {
        _orderInfoView = [[ALOrderInfoView alloc] initWithFrame:CGRectZero model:_model.orderInfo];
        [self addSubview:_orderInfoView];
    }
    return _orderInfoView;
}

- (ALLabel *)myPostitionDesLab {
    if(!_myPostitionDesLab) {
        _myPostitionDesLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _myPostitionDesLab.font = ALThemeFont(13);
        _myPostitionDesLab.text = ALStringFormat(@"本单角色：%@",_model.orderInfo.myPositionDes);
        [self addSubview:_myPostitionDesLab];
    }
    return _myPostitionDesLab;
}

- (UIButton *)questionBtn {
    if(!_questionBtn) {
        _questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_questionBtn setBackgroundImage:[UIImage imageNamed:@"icon_question"] forState:UIControlStateNormal];
        [self addSubview:_questionBtn];
        
        [_questionBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [ALKeyWindow.currentViewController.navigationController pushViewController:[ALQuestionViewController new] animated:YES];
        }];
    }
    return _questionBtn;
}

- (ALActionButton *)taskBtn {
    if(!_taskBtn) {
        _taskBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        [_taskBtn setTitle:@"开始任务" forState:UIControlStateNormal];
        [_taskBtn setTitle:@"任务未开始" forState:UIControlStateDisabled];
        [_taskBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [self addSubview:_taskBtn];
        
        if([_model.orderInfo.orderStatus isEqualToString:OrderStatusWorking]) {} else {
            if([_model.orderInfo.myPosition integerValue] != 1) {
                _taskBtn.enabled = NO;
            }
        }
        
        AL_WeakSelf(self);
        [_taskBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if([weakSelf.taskBtn.titleLabel.text isEqualToString:@"开始任务"]) {
                
                if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
                    
                    [ALAlertViewController showAlertCustomCancelButton:AL_MyAppDelegate.window.rootViewController title:@"提示" message:@"请确认你的定位服务是否开启~" style:UIAlertControllerStyleAlert cancelTitle:@"取消" clickBlock:nil];
                    
                    return ;
                }

                [ALAlertViewController showAlertOnlyCancelButton:ALKeyWindow.rootViewController title:@"开始任务" message:@"开始用户任务时候才能点击哦～～" style:UIAlertControllerStyleAlert Destructive:@"确定" clickBlock:^{
                    weakSelf.startMissApi = [[ALStartMissionApi alloc] initStartMissionApi:weakSelf.model.orderInfo.orderId];
                    
                    [weakSelf.startMissApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        weakSelf.timerValue = [weakSelf.model.orderInfo.serviceLength integerValue] * 60 * 60;
                        
                        weakSelf.taskTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:weakSelf selector:@selector(taskTimerAction) userInfo:nil repeats:YES];
                        [[NSRunLoop currentRunLoop] addTimer:weakSelf.taskTimer forMode:NSRunLoopCommonModes];
                        
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        
                    }];
                }];
                
                
            } else if ([weakSelf.taskBtn.titleLabel.text isEqualToString:@"结束任务"]) {
                weakSelf.completeMissionApi = [[ALCompleteMissionApi alloc] initCompleteMissionApi:weakSelf.model.orderInfo.orderId];
                
                [weakSelf.completeMissionApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    
                    ALOrderFinishedView *orderFinishedV = [[ALOrderFinishedView alloc] initWithFrame:CGRectZero isLeader:([weakSelf.model.orderInfo.myPosition integerValue] == 1 ? YES : NO) icon:AL_MyAppDelegate.userModel.userInfoModel.icon length:weakSelf.model.orderInfo.securityNum money:weakSelf.completeMissionApi.data[@"orderProfit"]];
                    [orderFinishedV show];

                    orderFinishedV.removeSuperView = ^{
                        if(weakSelf.orderCompleteBlock) {
                            weakSelf.orderCompleteBlock();
                        }
                    };
                    
                    //停止定位
                    [[ALBaiduLocation shardInstance] stopUserLocationService];
                    
                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                    
                }];
            }
        }];
    }
    return _taskBtn;
}

- (ALOrderInfoView *)orderSecurityView {
    if(!_orderSecurityView) {
        _orderSecurityView = [[ALOrderInfoView alloc] initWithShowCallBtnSecurityFrame:CGRectZero model:_model.orderInfo];
        [self addSubview:_orderSecurityView];
    }
    AL_WeakSelf(self);
    _orderSecurityView.multiItemBlock = ^(NSUInteger index) {
        ALSecurityInfoViewController *securityInfoVC = [[ALSecurityInfoViewController alloc] init];
        ALSecurityModel *securityModel = weakSelf.model.orderInfo.securityList[index];
        securityInfoVC.securityId = securityModel.securityId;
        if(weakSelf.headTapAction) {
            weakSelf.headTapAction(securityInfoVC);
        }
    };
    return _orderSecurityView;
}

- (void)dealloc {
    [self.completeMissionApi stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.taskTimer invalidate];
    self.taskTimer = nil;
}
@end

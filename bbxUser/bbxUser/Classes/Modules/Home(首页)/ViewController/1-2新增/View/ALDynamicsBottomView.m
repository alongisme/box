//
//  ALDynamicsBottomView.m
//  bbxUser
//
//  Created by xlshi on 2018/1/24.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALDynamicsBottomView.h"

@interface ALDynamicsBottomView()
@property (nonatomic, strong) NSNumber *expireInterval;
@property (nonatomic, assign) NSUInteger timerValue;
@property (nonatomic, strong) NSTimer *taskTimer;
@property (nonatomic, weak) ALLabel *time;
@property (nonatomic, assign) int flag;
@property (nonatomic, weak) UIView *bottomView;
@end

@implementation ALDynamicsBottomView

- (instancetype)initWithFrame:(CGRect)frame flag:(int)flag expireInterval:(NSNumber *)expireInterval {
    if(self = [super initWithFrame:frame]) {
        self.expireInterval = expireInterval;
        self.flag = flag;
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeZero radius:1];
        if(flag == 0 || flag == 100) {
            [self waitServerFinished];
        } else if(flag == 200) {
            [self waitPayMoney];
        } else if(flag == 300) {
            [self serverFindished];
        }
    }
    return self;
}

- (void)show {
    [ALKeyWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
        }];
        [self layoutIfNeeded];
    }];
}

- (void)closeAction {
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@260);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(self.closeEvaluateBlock) {
            self.closeEvaluateBlock();
        }
        [self removeFromSuperview];
    }];
}

- (void)serverFindished {
    self.backgroundColor = [UIColor clearColor];
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:bottomView];
    self.bottomView = bottomView;
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@260);
        make.height.equalTo(@260);
    }];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"pay_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@17);
    }];
    
    ALLabel *titleLab = [[ALLabel alloc] init];
    titleLab.text = @"评价";
    titleLab.font = ALThemeFont(20);
    titleLab.textColor = [UIColor colorWithRGB:0x333333];
    [bottomView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@20);
    }];
    
    UIView *hlineView = [UIView new];
    hlineView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.99 alpha:1.00];
    [bottomView addSubview:hlineView];
    
    [hlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(titleLab.mas_bottom).offset(14);
    }];
    
    UIImageView *comIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"com"]];
    [bottomView addSubview:comIV];
    
    [comIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.equalTo(hlineView.mas_bottom).offset(20);
    }];
    
    ALLabel *label = [[ALLabel alloc] init];
    label.text = @"服务已完成";
    label.font = ALThemeFont(16);
    label.textColor = [UIColor colorWithRGB:0x333333];
    [bottomView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(comIV.mas_bottom).offset(14);
    }];
    
    ALActionButton *toEvaluate = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
    [toEvaluate setTitle:@"去评价" forState:UIControlStateNormal];
    [toEvaluate setBackgroundImage:[UIImage imageNamed:@"btn-Sign out pressed"] forState:UIControlStateDisabled];
    [toEvaluate setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [toEvaluate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    toEvaluate.layer.cornerRadius = 5;
    toEvaluate.layer.masksToBounds = YES;
    [bottomView addSubview:toEvaluate];
    self.waitFinished = toEvaluate;
    AL_WeakSelf(self);
    [toEvaluate addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if(weakSelf.toEvaluateBlock) {
            weakSelf.toEvaluateBlock();
        }
    }];
    
    [toEvaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.bottom.equalTo(@-14);
    }];
}

- (void)waitPayMoney {
    
    UIImageView *comIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"com"]];
    [self addSubview:comIV];
    
    [comIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.equalTo(@29);
    }];
    
    ALLabel *label = [[ALLabel alloc] init];
    label.text = @"服务已完成";
    label.font = ALThemeFont(16);
    label.textColor = [UIColor colorWithRGB:0x333333];
    [self addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(comIV.mas_bottom).offset(14);
    }];
    
    ALActionButton *waitFinished = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
    [waitFinished setTitle:@"余额支付" forState:UIControlStateNormal];
    [waitFinished setBackgroundImage:[UIImage imageNamed:@"btn-Sign out pressed"] forState:UIControlStateDisabled];
    [waitFinished setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [waitFinished setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    waitFinished.layer.cornerRadius = 5;
    waitFinished.layer.masksToBounds = YES;
    [self addSubview:waitFinished];
    self.waitFinished = waitFinished;
    AL_WeakSelf(self);
    [waitFinished addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if(weakSelf.payBlock) {
            weakSelf.payBlock();
        }
    }];
    
    [waitFinished mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.bottom.equalTo(@-14);
    }];
    
    UIButton *_telephoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_telephoneBtn setBackgroundImage:[UIImage imageNamed:@"dy_tel"] forState:UIControlStateNormal];
    [self addSubview:_telephoneBtn];
    [_telephoneBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [MobClick event:ALMobEventID_B1];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4001066964"]];
        });
    }];
    
    [_telephoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-14);
        make.top.equalTo(@80);
    }];
}

- (void)waitServerFinished {
    ALLabel *serverTimeLab = [[ALLabel alloc] init];
    serverTimeLab.text = @"服务时长倒计时";
    serverTimeLab.textColor = [UIColor colorWithRGB:0x333333];
    serverTimeLab.font = ALThemeFont(16);
    [self addSubview:serverTimeLab];
    
    [serverTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@20);
    }];
    
    ALLabel *time = [[ALLabel alloc] init];
    time.font = ALThemeFont(24);
    time.textColor = [UIColor colorWithRGB:0x333333];
    [self addSubview:time];
    self.time = time;
    
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(serverTimeLab.mas_bottom).offset(10);
    }];
    
    ALActionButton *waitFinished = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
    [waitFinished setTitle:@"余额支付" forState:UIControlStateNormal];
    [waitFinished setBackgroundImage:[UIImage imageNamed:@"btn-Sign out pressed"] forState:UIControlStateDisabled];
    [waitFinished setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [waitFinished setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    waitFinished.layer.cornerRadius = 5;
    waitFinished.layer.masksToBounds = YES;
    waitFinished.enabled = NO;
    [self addSubview:waitFinished];
    self.waitFinished = waitFinished;
    AL_WeakSelf(self);
    [waitFinished addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if(weakSelf.payBlock) {
            weakSelf.payBlock();
        }
    }];
    
    if([self.expireInterval isEqualToNumber:@0] || ![self.expireInterval isVaild]) {
        time.text = @"00:00:00";
    } else {
        self.timerValue = [self.expireInterval integerValue];
        NSString *currentValue = ALStringFormat(@"%02lu:%02lu:%02lu",self.timerValue / 3600,self.timerValue / 60 % 60,self.timerValue % 60);
        if(_flag == 0) {
            self.taskTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(taskTimerAction) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.taskTimer forMode:NSRunLoopCommonModes];
        }
        time.text = currentValue;
    }

    [waitFinished mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.bottom.equalTo(@-14);
    }];
    
    UIButton *_telephoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_telephoneBtn setBackgroundImage:[UIImage imageNamed:@"dy_tel"] forState:UIControlStateNormal];
    [self addSubview:_telephoneBtn];
    [_telephoneBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [MobClick event:ALMobEventID_B1];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4001066964"]];
        });
    }];
    
    [_telephoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-14);
        make.top.equalTo(@29);
    }];
}

- (void)taskTimerAction {
    self.timerValue--;
    NSString *currentValue = ALStringFormat(@"%02lu:%02lu:%02lu",self.timerValue / 3600,self.timerValue / 60 % 60,self.timerValue % 60);
    self.time.text = currentValue;
    if(self.timerValue == 0) {
        [self.taskTimer invalidate];
        self.taskTimer = nil;
    }
}

- (void)dealloc {
    [self.taskTimer invalidate];
    self.taskTimer = nil;
}

@end

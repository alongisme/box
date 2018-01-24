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
@property (nonatomic, weak) UIButton *_telephoneBtn;
@end

@implementation ALDynamicsBottomView

- (instancetype)initWithFrame:(CGRect)frame flag:(int)flag expireInterval:(NSNumber *)expireInterval {
    if(self = [super initWithFrame:frame]) {
        self.expireInterval = expireInterval;
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeZero radius:1];
        if(flag == 0) {
            [self waitServerFinished];
        }
    }
    return self;
}

- (void)waitServerFinished {
    ALLabel *serverTimeLab = [[ALLabel alloc] init];
    serverTimeLab.text = @"服务时长倒计时";
    serverTimeLab.font = ALThemeFont(16);
    [self addSubview:serverTimeLab];
    
    [serverTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@20);
    }];
    
    self.timerValue = [self.expireInterval integerValue];
    NSString *currentValue = ALStringFormat(@"%02lu:%02lu:%02lu",self.timerValue / 3600,self.timerValue / 60 % 60,self.timerValue % 60);
    self.taskTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(taskTimerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.taskTimer forMode:NSRunLoopCommonModes];
    
    ALLabel *time = [[ALLabel alloc] init];
    time.font = ALThemeFont(24);
    time.text = currentValue;
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
    AL_WeakSelf(self);
    [waitFinished addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if(weakSelf.payBlock) {
            weakSelf.payBlock();
        }
    }];
    
    if([self.expireInterval isEqualToNumber:@0]) {
        waitFinished.enabled = YES;
    }

    [waitFinished mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.bottom.equalTo(@-14);
    }];
    
    UIButton *_telephoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_telephoneBtn setBackgroundImage:[UIImage imageNamed:@"dy_tel"] forState:UIControlStateNormal];
    [self addSubview:_telephoneBtn];
    self._telephoneBtn = _telephoneBtn;
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
        self._telephoneBtn.enabled = YES;
    }
    
}

- (void)dealloc {
    [self.taskTimer invalidate];
    self.taskTimer = nil;
}

@end

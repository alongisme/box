//
//  ALAccountInfoView.m
//  AnyHelp
//
//  Created by along on 2017/7/25.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAccountInfoView.h"
#import "ALGetVerificationApi.h"

@interface ALAccountInfoView ()
@property (nonatomic, strong) ALLabel *mobileLab;
@property (nonatomic, strong) UITextField *mobileTF;
@property (nonatomic, strong) UIView *hLineView;
@property (nonatomic, strong) ALLabel *verificationLab;
@property (nonatomic, strong) UITextField *verificationTF;
@property (nonatomic, strong) UIView *vLineView;
@property (nonatomic, strong) UIButton *getCodeBtn;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ALAccountInfoView

- (instancetype)init {
    if(self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:@"UITextFieldTextDidChangeNotification" object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.height.equalTo(@1);
    }];
    
    [self.mobileLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.hLineView);
        make.top.equalTo(@0);
        make.bottom.equalTo(self.hLineView.mas_top);
    }];
    
    [self.mobileTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mobileLab);
        make.left.equalTo(self.mobileLab.mas_right).offset(25);
        make.right.equalTo(@-16);
    }];
    
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-16);
        make.top.equalTo(self.hLineView.mas_bottom).offset(15);
        make.bottom.equalTo(@-15);
    }];
    
    [self.vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.getCodeBtn.mas_left).offset(-15);
        make.width.equalTo(@1);
        make.top.equalTo(self.hLineView.mas_bottom).offset(10);
        make.bottom.equalTo(@-10);
    }];
    
    [self.verificationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mobileLab);
        make.centerY.equalTo(self.vLineView);
    }];
    
    [self.verificationTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vLineView);
        make.left.equalTo(self.verificationLab.mas_right).offset(25);
        make.right.equalTo(self.vLineView.mas_left).offset(-10);
    }];
}


#pragma mark Action
- (void)getCodeButtonAction {
    
    if(![self.mobileTF.text isVaild]) {
        [ALKeyWindow showHudError:@"请输入正确的手机号～"];
        return;
    }
    
    AL_WeakSelf(self);
    __block int countDown = 59;
    
    [[ALGetVerificationApi GetVerificationApi:self.mobileTF.text] ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MobClick event:ALMobEventID_A1];
        [ALKeyWindow showHudSuccess:@"验证码获取成功～"];

        weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
            if(countDown < 1) {
                [weakSelf.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                weakSelf.getCodeBtn.enabled = YES;
                [weakSelf.timer invalidate];
                weakSelf.timer = nil;
            } else {
                [weakSelf.getCodeBtn setTitle:ALStringFormat(@"%ds",countDown--) forState:UIControlStateNormal];
                weakSelf.getCodeBtn.enabled = NO;
            }
            
        } repeats:YES];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        weakSelf.getCodeBtn.enabled = YES;
        [weakSelf.timer invalidate];
        weakSelf.timer = nil;
    }];
}

- (void)textFieldTextDidChange:(NSNotification *)notification {
    if(self.mobileTF.text.length > 0 && self.verificationTF.text.length > 0) {
        self.loginEnable = YES;
    } else {
        self.loginEnable = NO;
    }
    
    if(self.mobileTF.text.length > 0) {
        self.getCodeBtn.enabled = YES;
    } else {
        self.getCodeBtn.enabled = NO;
    }
}

#pragma mark load
- (UIView *)hLineView {
    if(!_hLineView) {
        _hLineView = [UIView new];
        _hLineView.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.00];
        [self addSubview:_hLineView];
    }
    return _hLineView;
}

- (ALLabel *)mobileLab {
    if(!_mobileLab) {
        _mobileLab = [[ALLabel alloc] init];
        _mobileLab.text = @"手机号";
        [self addSubview:_mobileLab];
    }
    return _mobileLab;
}

- (UITextField *)mobileTF {
    if(!_mobileTF) {
        _mobileTF = [[UITextField alloc] init];
        _mobileTF.keyboardType = UIKeyboardTypePhonePad;
        _mobileTF.placeholder = @"请输入11位手机号码";
        _mobileTF.font = ALThemeFont(13);
        _mobileTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_mobileTF];
    }
    return _mobileTF;
}

- (ALLabel *)verificationLab {
    if(!_verificationLab) {
        _verificationLab = [[ALLabel alloc] init];
        _verificationLab.text = @"验证码";
        [self addSubview:_verificationLab];
    }
    return _verificationLab;
}

- (UIButton *)getCodeBtn {
    if(!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor colorWithRGBA:0xCACDCFFF] forState:UIControlStateDisabled];
        _getCodeBtn.titleLabel.font = ALThemeFont(13);
        _getCodeBtn.enabled = NO;
        [_getCodeBtn addTarget:self action:@selector(getCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_getCodeBtn];
    }
    return _getCodeBtn;
}

- (UIView *)vLineView {
    if(!_vLineView) {
        _vLineView = [[UIView alloc] init];
        _vLineView.backgroundColor = [UIColor colorWithRGBA:0xF3F4F8FF];
        [self addSubview:_vLineView];
    }
    return _vLineView;
}

- (UITextField *)verificationTF {
    if(!_verificationTF) {
        _verificationTF = [[UITextField alloc] init];
        _verificationTF.placeholder = @"请输入验证码";
        _verificationTF.font = ALThemeFont(13);
        _verificationTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _verificationTF.clearsOnBeginEditing = YES;
        [self addSubview:_verificationTF];
    }
    return _verificationTF;
}

- (NSString *)accountString {
    return _mobileTF.text;
}

- (NSString *)codeString {
    return _verificationTF.text;
}

- (void)dealloc {
    @try {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self.timer invalidate];
        self.timer = nil;
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}
@end

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
@property (nonatomic, strong) UIView *itemOne;
@property (nonatomic, strong) ALLabel *mobileLab;
@property (nonatomic, strong) UITextField *mobileTF;

@property (nonatomic, strong) UIView *itemTwo;
@property (nonatomic, strong) UIView *hLineView;
@property (nonatomic, strong) ALLabel *verificationLab;
@property (nonatomic, strong) UITextField *verificationTF;
@property (nonatomic, strong) UIView *vLineView;

@property (nonatomic, strong) UIView *itemThree;
@property (nonatomic, strong) ALLabel *passwordLab;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIView *twoHLineView;

@property (nonatomic, strong) UIButton *getCodeBtn;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIButton *eyesBtn;
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
    
    [self.itemOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@45);
    }];
    
    [self.hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.itemOne.mas_bottom);
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.height.equalTo(@1);
    }];
    
    [self.itemTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.itemOne);
        make.top.equalTo(self.hLineView);
    }];
    
    [self.twoHLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.itemTwo.mas_bottom);
        make.left.right.height.equalTo(self.hLineView);
    }];
    
    [self.itemThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.itemOne);
        make.top.equalTo(self.twoHLineView.mas_bottom);
    }];
    
    [self.mobileLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@14);
        CGFloat wid = [self.mobileLab.text widthForFont:self.mobileLab.font];
        make.width.mas_equalTo(wid);
    }];
    
    [self.mobileTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mobileLab.mas_right).offset(25);
        make.right.equalTo(@-16);
        make.centerY.equalTo(self.itemOne);
    }];
    
    [self.verificationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mobileLab);
        make.top.equalTo(self.hLineView.mas_bottom).offset(14);
    }];
    
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-16);
        make.centerY.equalTo(self.itemTwo);
        CGFloat wid = [self.getCodeBtn.titleLabel.text widthForFont:self.getCodeBtn.titleLabel.font] + 5;
        make.width.equalTo(@(wid));
    }];
    
    [self.vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.getCodeBtn.mas_left).offset(-15);
        make.width.equalTo(@1);
        make.centerY.equalTo(self.itemTwo);
        make.height.equalTo(@20);
    }];
    
    [self.verificationTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.itemTwo);
        make.left.equalTo(self.mobileTF);
        make.right.equalTo(self.vLineView.mas_left).offset(-10);
    }];
    
    [self.passwordLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twoHLineView.mas_bottom).offset(14);
        make.leading.equalTo(self.mobileLab);
    }];
    
    [self.eyesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-14);
        make.centerY.equalTo(self.itemThree);
        make.size.mas_equalTo(CGSizeMake(22, 23));
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mobileTF);
        make.right.equalTo(self.eyesBtn.mas_left).offset(-10);
        make.centerY.equalTo(self.itemThree);
    }];
}

- (void)eyesButtonClick:(UIButton *)sender {
    self.passwordTF.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
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
    UITextField *currentTF = notification.object;
    if(currentTF == self.mobileTF) {
        if(self.mobileTF.text.length > 0) {
            self.getCodeBtn.enabled = YES;
        } else {
            self.getCodeBtn.enabled = NO;
        }
        if(self.mobileTF.text.length > 0 && self.verificationTF.text.length > 0 && self.passwordTF.text.length > 0) {
            self.loginEnable = YES;
        } else {
            self.loginEnable = NO;
        }
    } else if(currentTF == self.verificationTF) {
        if(self.mobileTF.text.length > 0 && self.verificationTF.text.length > 0 && self.passwordTF.text.length > 0) {
            self.loginEnable = YES;
        } else {
            self.loginEnable = NO;
        }
    } else {
        if(self.mobileTF.text.length > 0 && self.verificationTF.text.length > 0 && self.passwordTF.text.length > 0) {
            self.loginEnable = YES;
        } else {
            self.loginEnable = NO;
        }
    }
}

- (void)setChangePwd:(BOOL)changePwd {
    _changePwd = changePwd;
    
    self.mobileTF.text = AL_MyAppDelegate.userModel.userInfoModel.phone;
    self.mobileTF.userInteractionEnabled = NO;
    self.getCodeBtn.enabled = YES;
}

- (NSString *)accountString {
    return _mobileTF.text;
}

- (NSString *)codeString {
    return _verificationTF.text;
}

- (NSString *)pwdString {
    return _passwordTF.text;
}

#pragma mark load
- (UIView *)itemOne {
    if(!_itemOne) {
        _itemOne = [[UIView alloc] init];
        [self addSubview:_itemOne];
    }
    return _itemOne;
}

- (UIView *)itemTwo {
    if(!_itemTwo) {
        _itemTwo = [[UIView alloc] init];
        [self addSubview:_itemTwo];
    }
    return _itemTwo;
}

- (UIView *)itemThree {
    if(!_itemThree) {
        _itemThree = [[UIView alloc] init];
        [self addSubview:_itemThree];
    }
    return _itemThree;
}

- (UIView *)hLineView {
    if(!_hLineView) {
        _hLineView = [UIView new];
        _hLineView.backgroundColor = [UIColor colorWithRGBA:0xF3F4F8FF];
        [self addSubview:_hLineView];
    }
    return _hLineView;
}

- (ALLabel *)mobileLab {
    if(!_mobileLab) {
        _mobileLab = [[ALLabel alloc] init];
        _mobileLab.text = @"手机号";
        [self.itemOne addSubview:_mobileLab];
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
        [self.itemOne addSubview:_mobileTF];
    }
    return _mobileTF;
}

- (ALLabel *)verificationLab {
    if(!_verificationLab) {
        _verificationLab = [[ALLabel alloc] init];
        _verificationLab.text = @"验证码";
        [self.itemTwo addSubview:_verificationLab];
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
        [self.itemTwo addSubview:_getCodeBtn];
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
        [self.itemTwo addSubview:_verificationTF];
    }
    return _verificationTF;
}

- (ALLabel *)passwordLab {
    if(!_passwordLab) {
        _passwordLab = [[ALLabel alloc] init];
        _passwordLab.text = @"密码";
        [self.itemThree addSubview:_passwordLab];
    }
    return _passwordLab;
}

- (UITextField *)passwordTF {
    if(!_passwordTF) {
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.placeholder = @"请输入密码";
        _passwordTF.font = ALThemeFont(13);
        _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTF.secureTextEntry = YES;
        [self.itemThree addSubview:_passwordTF];
    }
    return _passwordTF;
}

- (UIButton *)eyesBtn {
    if(!_eyesBtn) {
        _eyesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyesBtn setBackgroundImage:[UIImage imageNamed:@"icon-Display password"] forState:UIControlStateNormal];
        [_eyesBtn setBackgroundImage:[UIImage imageNamed:@"icon-openeye"] forState:UIControlStateSelected];
        [_eyesBtn addTarget:self action:@selector(eyesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemThree addSubview:_eyesBtn];
    }
    return _eyesBtn;
}

- (UIView *)twoHLineView {
    if(!_twoHLineView) {
        _twoHLineView = [UIView new];
        _twoHLineView.backgroundColor = [UIColor colorWithRGBA:0xF3F4F8FF];
        [self addSubview:_twoHLineView];
    }
    return _twoHLineView;
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

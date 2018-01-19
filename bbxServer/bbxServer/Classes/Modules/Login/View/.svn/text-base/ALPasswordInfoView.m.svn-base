//
//  ALPasswordInfoView.m
//  bbxServer
//
//  Created by along on 2017/8/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALPasswordInfoView.h"

@interface ALPasswordInfoView ()
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIView *hLineView;
@property (nonatomic, strong) UITextField *sePasswordTF;
@end

@implementation ALPasswordInfoView

- (instancetype)init {
    if(self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:@"UITextFieldTextDidChangeNotification" object:nil];
    }
    return self;
}

- (void)textFieldTextDidChange:(NSNotification *)notification {
    UITextField *currentTF = notification.object;
    if(currentTF == self.passwordTF) {
        if([currentTF.text isVaild] && [self.sePasswordTF.text isVaild]) {
            self.actionEnable = YES;
        } else {
            self.actionEnable = NO;
        }
    } else if (currentTF == self.sePasswordTF) {
        if([currentTF.text isVaild] && [self.passwordTF.text isVaild]) {
            self.actionEnable = YES;
        } else {
            self.actionEnable = NO;
        }
    }
    self.pwdString = currentTF.text;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.equalTo(@1);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.hLineView);
        make.bottom.equalTo(self.hLineView.mas_top).offset(-15);
    }];
    
    [self.sePasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.hLineView);
        make.top.equalTo(self.hLineView.mas_bottom).offset(15);
    }];
}

#pragma mark lazy load
- (UITextField *)passwordTF {
    if(!_passwordTF) {
        _passwordTF = [[UITextField alloc]init];
        _passwordTF.secureTextEntry = YES;
        _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTF.placeholder = @"请输入您的密码（6~20位数字或字母组合）";
        _passwordTF.font = ALThemeFont(14);
        [self addSubview:_passwordTF];
    }
    return _passwordTF;
}

- (UIView *)hLineView {
    if(!_hLineView) {
        _hLineView = [[UIView alloc] init];
        _hLineView.backgroundColor = [UIColor colorWithRGB:0xD8D8D8];
        [self addSubview:_hLineView];
    }
    return _hLineView;
}

- (UITextField *)sePasswordTF {
    if(!_sePasswordTF) {
        _sePasswordTF = [[UITextField alloc]init];
        _sePasswordTF.secureTextEntry = YES;
        _sePasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _sePasswordTF.placeholder = @"请再次输入密码";
        _sePasswordTF.font = ALThemeFont(14);
        [self addSubview:_sePasswordTF];
    }
    return _sePasswordTF;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

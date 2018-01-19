//
//  ALPasswordView.m
//  bbxServer
//
//  Created by along on 2017/8/25.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALPasswordView.h"

@interface ALPasswordView () <UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) UIButton *eyesBtn;
@property (nonatomic, strong) UIView *hLineView;
@end

@implementation ALPasswordView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.bottom.right.equalTo(@0);
    }];
    
    [self.eyesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-8);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(22, 23));
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconIV.mas_right).offset(15);
        make.centerY.equalTo(self);
        make.right.equalTo(self.eyesBtn.mas_left).offset(-6);
    }];
}

- (void)eyesButtonClick:(UIButton *)sender {
    self.passwordTF.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
}

#pragma mark lazy load
- (UIImageView *)iconIV {
    if(!_iconIV) {
        _iconIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password"]];
        [self addSubview:_iconIV];
    }
    return _iconIV;
}

- (UITextField *)passwordTF {
    if(!_passwordTF) {
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.font = ALThemeFont(14);
        _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTF.secureTextEntry = YES;
        _passwordTF.delegate = self;
        _passwordTF.placeholder = @"请输入您的登录密码";
        [self addSubview:_passwordTF];
        [_passwordTF setValue:[UIColor colorWithRGB:0xBCBCBC] forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _passwordTF;
}

- (UIButton *)eyesBtn {
    if(!_eyesBtn) {
        _eyesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyesBtn setBackgroundImage:[UIImage imageNamed:@"icon-Display password"] forState:UIControlStateNormal];
        [_eyesBtn setBackgroundImage:[UIImage imageNamed:@"icon-openeye"] forState:UIControlStateSelected];
        [_eyesBtn addTarget:self action:@selector(eyesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_eyesBtn];
    }
    return _eyesBtn;
}

- (UIView *)hLineView {
    if(!_hLineView) {
        _hLineView = [[UIView alloc] init];
        _hLineView.backgroundColor = [UIColor colorWithRGB:0x797979];
        [self addSubview:_hLineView];
    }
    return _hLineView;
}

@end

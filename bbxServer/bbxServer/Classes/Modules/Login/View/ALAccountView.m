//
//  ALAccountView.m
//  bbxServer
//
//  Created by along on 2017/8/25.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAccountView.h"

@interface ALAccountView ()
@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) UIView *hLineView;
@end

@implementation ALAccountView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconIV.mas_right).offset(15);
        make.centerY.equalTo(self);
        make.right.equalTo(@-14);
    }];
    
    [self.hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.bottom.right.equalTo(@0);
    }];
}

#pragma mark lazy load
- (UIImageView *)iconIV {
    if(!_iconIV) {
        _iconIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_accout"]];
        [self addSubview:_iconIV];
    }
    return _iconIV;
}

- (UITextField *)accountTF {
    if(!_accountTF) {
        _accountTF = [[UITextField alloc] init];
        _accountTF.keyboardType = UIKeyboardTypePhonePad;
        _accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountTF.font = ALThemeFont(14);
        _accountTF.placeholder = @"请输入您的手机号";
        [self addSubview:_accountTF];
        [_accountTF setValue:[UIColor colorWithRGB:0xBCBCBC] forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _accountTF;
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

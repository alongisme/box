//
//  ALPaySuccessView.m
//  AnyHelp
//
//  Created by along on 2017/7/26.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALPaySuccessView.h"

@interface ALPaySuccessView ()
@property (nonatomic, assign) ALPayType type;
@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) ALLabel *successLab;
@property (nonatomic, strong) ALLabel *messageLab;
@end

@implementation ALPaySuccessView

- (instancetype)initWithFrame:(CGRect)frame type:(ALPayType)type {
    if(self = [super initWithFrame:frame]) {
        self.type = type;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.messageLab.mas_top).offset(-12);
        make.centerX.equalTo(self).offset(-50);
        make.size.mas_equalTo(CGSizeMake(self.iconIV.image.size.width * 1.5, self.iconIV.image.size.height * 1.5));
    }];
    
    [self.successLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconIV);
        make.left.equalTo(self.iconIV.mas_right).offset(17);
    }];
    
    [self.orderInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
    }];
}

#pragma mark lazy load
- (UIImageView *)iconIV {
    if(!_iconIV) {
        _iconIV = [[UIImageView alloc] init];
        
        if(_type == ALPayTypeAliPay) {
            _iconIV.image = [UIImage imageNamed:@"alipay"];
        } else if(_type == ALPayTypeWeiXinPay) {
            _iconIV.image = [UIImage imageNamed:@"wxPay"];
        }
        [self addSubview:_iconIV];
    }
    return _iconIV;
}

- (ALLabel *)successLab {
    if(!_successLab) {
        _successLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _successLab.text = @"支付成功";
        _successLab.font = ALMediumTitleFont(20);
        [self addSubview:_successLab];
    }
    return _successLab;
}

- (ALLabel *)messageLab {
    if(!_messageLab) {
        _messageLab = [[ALLabel alloc] init];
        _messageLab.font = ALThemeFont(14);
        _messageLab.text = @"请保持手机畅通，领队会主动联系您";
        [self addSubview:_messageLab];
    }
    return _messageLab;
}

- (UIButton *)orderInfoBtn {
    if(!_orderInfoBtn) {
        _orderInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderInfoBtn setBackgroundImage:[UIImage imageNamed:@"btn_chakandingdan_ nor"] forState:UIControlStateNormal];
        [self addSubview:_orderInfoBtn];
    }
    return _orderInfoBtn;
}
@end

//
//  ALHudMessageView.m
//  bbxUser
//
//  Created by xlshi on 2017/11/8.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHudMessageView.h"

@interface ALHudMessageView ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) ALLabel *messageLab;
@property (nonatomic, strong) UIButton *actionBtn;
@end

@implementation ALHudMessageView

- (instancetype)initWithFrame:(CGRect)frame message:(NSString *)message {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRGBA:0x00000099];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@50);
            make.right.equalTo(@-50);
            make.centerY.equalTo(self);
            make.height.equalTo(@196);
        }];
        
        [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgView);
            make.left.equalTo(@11);
            make.right.equalTo(@-11);
        }];
        
        [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.bottom.equalTo(self.messageLab.mas_top).offset(-13);
        }];
        
        [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
        }];
        
        self.messageLab.text = message;
    }
    return self;
}

- (void)show {
    [ALKeyWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (void)actionButtonAction {
    [self removeFromSuperview];
}

#pragma mark lazy load
- (UIView *)bgView {
    if(!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 13;
    }
    return _bgView;
}

- (UIImageView *)iconIV {
    if(!_iconIV) {
        _iconIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
        [self.bgView addSubview:_iconIV];
    }
    return _iconIV;
}

- (ALLabel *)messageLab {
    if(!_messageLab) {
        _messageLab = [[ALLabel alloc] init];
        _messageLab.numberOfLines = 0;
        [self.bgView addSubview:_messageLab];
    }
    return _messageLab;
}

- (UIButton *)actionBtn {
    if(!_actionBtn) {
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionBtn setBackgroundImage:[UIImage imageNamed:@"Buttons"] forState:UIControlStateNormal];
        [_actionBtn addTarget:self action:@selector(actionButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:_actionBtn];
    }
    return _actionBtn;
}
@end

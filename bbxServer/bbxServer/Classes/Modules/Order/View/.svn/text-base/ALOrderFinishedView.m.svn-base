//
//  ALOrderFinishedView.m
//  bbxServer
//
//  Created by along on 2017/9/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALOrderFinishedView.h"

@interface ALOrderFinishedView ()
@property (nonatomic, assign) BOOL isLeader;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *serverLength;
@property (nonatomic, copy) NSString *money;

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) ALLabel *roleLab;
@property (nonatomic, strong) ALLabel *serverLengthLab;
@property (nonatomic, strong) ALLabel *moneyLab;
@property (nonatomic, strong) ALActionButton *okBtn;
@end

@implementation ALOrderFinishedView

- (instancetype)initWithFrame:(CGRect)frame isLeader:(BOOL)isLeader icon:(NSString *)icon length:(NSString *)length money:(NSString *)money {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        _isLeader = isLeader;
        _icon = icon;
        _serverLength = length;
        _money = money;
        
        [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.bottom.equalTo(@290);
            make.height.equalTo(@290);
        }];
        
        [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.baseView);
            make.top.equalTo(@30);
            make.size.mas_equalTo(CGSizeMake(90, 90));
        }];
        
        [self.roleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.baseView);
            make.top.equalTo(self.iconIV.mas_bottom).offset(10);
        }];
        
        [self.serverLengthLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.roleLab);
            make.top.equalTo(self.roleLab.mas_bottom).offset(10);
        }];
        
        [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.roleLab);
            make.top.equalTo(self.serverLengthLab.mas_bottom).offset(15);
        }];
        
        [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.right.equalTo(@-14);
            make.bottom.equalTo(@-12);
        }];
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
        [self.baseView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
        }];
        [self layoutIfNeeded];
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        [self.baseView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@290);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(self.removeSuperView) {
            self.removeSuperView();
        }
    }];
}

#pragma mark lazy load
- (UIView *)baseView {
    if(!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_baseView];
    }
    return _baseView;
}

- (UIImageView *)iconIV {
    if(!_iconIV) {
        _iconIV = [[UIImageView alloc] init];
        [self.baseView addSubview:_iconIV];
        _iconIV.layer.cornerRadius = 45;
        _iconIV.layer.masksToBounds = YES;
        
        [_iconIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,_icon)] placeholderImage:[UIImage imageNamed:@"huantouxiang_moren"]];
    }
    return _iconIV;
}

- (ALLabel *)roleLab {
    if(!_roleLab) {
        _roleLab = [[ALLabel alloc] init];
        _roleLab.font = ALMediumTitleFont(15);
        [self.baseView addSubview:_roleLab];
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"本单角色：%@",_isLeader ? @"领队" : @"队员")];
        [attString yy_setFont:ALThemeFont(15) range:NSMakeRange(5, attString.length - 5)];
        _roleLab.attributedText = attString;
    }
    return _roleLab;
}

- (ALLabel *)serverLengthLab {
    if(!_serverLengthLab) {
        _serverLengthLab = [[ALLabel alloc] init];
        _serverLengthLab.font = ALMediumTitleFont(15);
        [self.baseView addSubview:_serverLengthLab];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"服务时长：%@小时",_serverLength)];
        [attString yy_setFont:ALThemeFont(15) range:NSMakeRange(5, attString.length - 5)];
        _serverLengthLab.attributedText = attString;
    }
    return _serverLengthLab;
}

- (ALLabel *)moneyLab {
    if(!_moneyLab) {
        _moneyLab = [[ALLabel alloc] init];
        [self.baseView addSubview:_moneyLab];
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"应收金额：%@元",_money)];
        [attString setYy_font:ALMediumTitleFont(15)];
        [attString yy_setTextHighlightRange:NSMakeRange(5, attString.length - 5) color:[UIColor colorWithRGBA:ALThemeColor] backgroundColor:nil userInfo:nil];
        [attString yy_setFont:ALMediumTitleFont(20) range:NSMakeRange(5, attString.length - 5)];
        _moneyLab.attributedText = attString;
    }
    return _moneyLab;
}

- (ALActionButton *)okBtn {
    if(!_okBtn) {
        _okBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        [_okBtn setTitle:@"确认" forState:UIControlStateNormal];
        [self.baseView addSubview:_okBtn];
        AL_WeakSelf(self);
        
        [_okBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf hide];
        }];
    }
    return _okBtn;
}
@end

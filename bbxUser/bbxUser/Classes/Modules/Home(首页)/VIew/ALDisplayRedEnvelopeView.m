//
//  ALDisplayRedEnvelopeView.m
//  bbxUser
//
//  Created by xlshi on 2017/11/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALDisplayRedEnvelopeView.h"
#import "ALStepOneViewController.h"

@interface ALDisplayRedEnvelopeView ()
@property (nonatomic, strong) UIImageView *redEnvBgIV;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) ALDisplayRedEnvelopeCell *oneCell;
@property (nonatomic, strong) ALDisplayRedEnvelopeCell *twoCell;

@property (nonatomic, assign) BOOL onlyOne;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation ALDisplayRedEnvelopeView

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRGBA:0x00000099];
        self.array = [array copy];
        if(array.count == 1) {
            self.onlyOne = YES;
        }
        
        [self.redEnvBgIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            if(self.onlyOne) {
                make.centerY.equalTo(self);
            } else {
                if(ALScreenWidth == 375) {
                    make.centerY.equalTo(self).offset(-30);
                } else if (ALScreenWidth == 414) {
                    make.centerY.equalTo(self).offset(-60);
                } else {
                    make.width.mas_equalTo(self.redEnvBgIV.image.size.width * 0.85);
                    make.height.mas_equalTo(self.redEnvBgIV.image.size.height * 0.85);
                    make.centerY.equalTo(self).offset(-10);
                }
            }
        }];
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.redEnvBgIV);
            make.top.equalTo(self.redEnvBgIV.mas_bottom).offset(20);
        }];
        
        AL_WeakSelf(self);
        void (^usedButtonClickBlock)(void) = ^{
            [weakSelf closeButtonAction];
            ALStepOneViewController *stepOneVC = [[ALStepOneViewController alloc] init];
            stepOneVC.poiInfoModel = AL_MyAppDelegate.poiInfoModel;
            [ALKeyWindow.currentViewController.navigationController pushViewController:stepOneVC animated:YES];
        };
        
        [self.twoCell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.redEnvBgIV.mas_bottom).offset(-14);
            make.centerX.equalTo(self.redEnvBgIV);
            make.width.equalTo(self.redEnvBgIV).offset(-24);
            if(ALScreenWidth == 320)
                make.height.mas_equalTo(@(88 * 0.85));
            make.height.equalTo(@88);
        }];
        
        self.twoCell.usedButtonClickBlock = usedButtonClickBlock;
        
        if(!self.onlyOne) {
            [self.oneCell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.width.height.equalTo(self.twoCell);
                make.bottom.equalTo(self.twoCell.mas_top).offset(-2);
            }];
            self.oneCell.usedButtonClickBlock = usedButtonClickBlock;
        }
    }
    return self;
}

- (void)show {
    [ALKeyWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (void)closeButtonAction {
    [self removeFromSuperview];
}

- (UIImageView *)redEnvBgIV {
    if(!_redEnvBgIV) {
        _redEnvBgIV = [[UIImageView alloc] init];
        [self addSubview:_redEnvBgIV];
        
        if(self.array.count == 1) {
            self.redEnvBgIV.image = [UIImage imageNamed:@"redEnvBgViewsingle"];
        } else if (self.array.count == 2) {
            self.redEnvBgIV.image = [UIImage imageNamed:@"redEnvBgView"];
        }
    }
    return _redEnvBgIV;
}

- (UIButton *)closeBtn {
    if(!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"close38"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeBtn];
    }
    return _closeBtn;
}

- (ALDisplayRedEnvelopeCell *)oneCell {
    if(!_oneCell) {
        _oneCell = [[ALDisplayRedEnvelopeCell alloc] initWithFrame:CGRectZero model:self.array.count == 1 ? self.array.lastObject : self.array.firstObject];
        [self addSubview:_oneCell];
    }
    return _oneCell;
}

- (ALDisplayRedEnvelopeCell *)twoCell {
    if(!_twoCell) {
        _twoCell = [[ALDisplayRedEnvelopeCell alloc] initWithFrame:CGRectZero model:self.array.lastObject];
        [self addSubview:_twoCell];
    }
    return _twoCell;
}
@end

@interface ALDisplayRedEnvelopeCell ()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) ALLabel *redEnvPriceLab;
@property (nonatomic, strong) ALLabel *canUsedPriceLab;
@property (nonatomic, strong) ALLabel *nameLab;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) UIButton *useBtn;
@end

@implementation ALDisplayRedEnvelopeCell

- (instancetype)initWithFrame:(CGRect)frame model:(ALTimeCouponListModel *)model {
    if(self = [super initWithFrame:frame]) {
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
        NSMutableAttributedString *resultAttr = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"¥%@",model.discount)];
        if(ALScreenWidth == 320)
            resultAttr.yy_font = ALMediumTitleFont(28);
        else
            resultAttr.yy_font = ALMediumTitleFont(32);
        resultAttr.yy_color = [UIColor colorWithRGBA:0xFB3939FF];
        [resultAttr yy_setFont:ALThemeFont(16) range:NSMakeRange(0, 1)];
        self.redEnvPriceLab.attributedText = resultAttr;
        self.canUsedPriceLab.text = ALStringFormat(@"满%@元可用",model.limitPrice);
        self.nameLab.text = model.title;
        [self.timeBtn setTitle:ALStringFormat(@"有效期：%@",model.expireTimeDes) forState:UIControlStateNormal];
        
        [self.useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(@-14);
            if(ALScreenWidth == 320)
                make.size.mas_equalTo(CGSizeMake(self.useBtn.currentBackgroundImage.size.width * 0.85, self.useBtn.currentBackgroundImage.size.height * 0.85));
        }];
        
        [self.canUsedPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-15);
            make.left.equalTo(@14);
        }];
        
        [self.redEnvPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.canUsedPriceLab);
            make.bottom.equalTo(self.canUsedPriceLab.mas_top).offset(-3);
        }];
        
        [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.canUsedPriceLab);
            if(ALScreenWidth == 320)
                make.left.equalTo(@95);
            else
                make.left.equalTo(@120);
            CGFloat w = [self.timeBtn.titleLabel.text widthForFont:self.timeBtn.titleLabel.font];
            make.width.equalTo(@(w + 6));
            CGFloat h = [self.timeBtn.titleLabel.text heightForFont:self.timeBtn.titleLabel.font width:w];
            make.height.equalTo(@(h));
        }];
        
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.timeBtn);
            make.top.equalTo(self.redEnvPriceLab);
        }];
        
        if(ALScreenWidth == 320) {
            self.canUsedPriceLab.font =  ALThemeFont(11);
        }
    }
    return self;
}

- (void)useButtonAction {
    if(self.usedButtonClickBlock) {
        self.usedButtonClickBlock();
    }
}

- (UIImageView *)bgView {
    if(!_bgView) {
        _bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bj-youhuiquan"]];
        [self addSubview:_bgView];
    }
    return _bgView;
}

- (ALLabel *)redEnvPriceLab {
    if(!_redEnvPriceLab) {
        _redEnvPriceLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        [self addSubview:_redEnvPriceLab];
    }
    return _redEnvPriceLab;
}

- (ALLabel *)canUsedPriceLab {
    if(!_canUsedPriceLab) {
        _canUsedPriceLab = [[ALLabel alloc] init];
        _canUsedPriceLab.font = ALThemeFont(13);
        _canUsedPriceLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];;
        [self addSubview:_canUsedPriceLab];
    }
    return _canUsedPriceLab;
}

- (UIButton *)timeBtn {
    if(!_timeBtn) {
        _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeBtn setTitleColor:[UIColor colorWithRGBA:0xFF8A23FF] forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:11];
        [self addSubview:_timeBtn];
        
        _timeBtn.layer.borderColor = [UIColor colorWithRGBA:0xFF8A23FF].CGColor;
        _timeBtn.layer.borderWidth = 0.5f;
        _timeBtn.layer.cornerRadius = 2;
    }
    return _timeBtn;
}

- (ALLabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _nameLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];;
        _nameLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];;
        _nameLab.text = @"满减红包";
        [self addSubview:_nameLab];
    }
    return _nameLab;
}

- (UIButton *)useBtn {
    if(!_useBtn) {
        _useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_useBtn setBackgroundImage:[UIImage imageNamed:@"fastUse"] forState:UIControlStateNormal];
        [_useBtn addTarget:self action:@selector(useButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_useBtn];
    }
    return _useBtn;
}
@end

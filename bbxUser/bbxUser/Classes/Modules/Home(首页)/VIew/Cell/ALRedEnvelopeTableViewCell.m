//
//  ALRedEnvelopeTableViewCell.m
//  bbxUser
//
//  Created by along on 2017/8/3.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALRedEnvelopeTableViewCell.h"

@interface ALRedEnvelopeTableViewCell ()
@property (nonatomic, strong) ALShadowView *bgView;

@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UIView *vLineView;
@property (nonatomic, strong) ALLabel *enoughRedEveLab;
@property (nonatomic, strong) ALLabel *deadTimeLab;
@property (nonatomic, strong) ALLabel *canUsedMoneyLab;
@property (nonatomic, strong) UIImageView *selectedIV;

@property (nonatomic, strong) ALRedEnvelopoModel *model;

@property (nonatomic, strong) UIButton *fastBtn;
@end

@implementation ALRedEnvelopeTableViewCell

- (void)bindModel:(ALRedEnvelopoModel *)model {
    
    _model = model;
    
    NSMutableAttributedString *resultAttr = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"¥%@",model.discount)];
    resultAttr.yy_font = [UIFont fontWithName:@".PingFangSC-Semibold" size:26];
    resultAttr.yy_color = [UIColor colorWithRGB:0xF8504F];
    [resultAttr yy_setFont:ALThemeFont(14) range:NSMakeRange(0, 1)];
    [resultAttr yy_setKern:@3 range:NSMakeRange(0, 1)];
    _priceLab.attributedText = resultAttr;
    
    _selectedIV.image = [UIImage imageNamed:model.isSelected.boolValue ? @"select_sel" : @"select_nor"];
    _enoughRedEveLab.text = model.title;
    _deadTimeLab.text = ALStringFormat(@"%@到期",[model.expireTimeDes substringToIndex:10]);
    _canUsedMoneyLab.text = ALStringFormat(@"满%@元可用",model.limitPrice);
}

- (instancetype)initWithListStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
        
        [self.fastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-12);
            make.centerY.equalTo(self.bgView);
        }];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
        
        [self.selectedIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgView);
            make.right.equalTo(self.bgView.mas_right).offset(-10);
        }];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor clearColor];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.equalTo(@5);
        make.bottom.equalTo(@-5);
    }];
    
    [self.vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.height.equalTo(@52);
        make.centerY.equalTo(self.bgView);
        if([[UIDevice currentDevice].machineModelName isEqualToString:@"iPhone 5"] || [[UIDevice currentDevice].machineModelName isEqualToString:@"iPhone 5c"] || [[UIDevice currentDevice].machineModelName isEqualToString:@"iPhone 5s"]) {
            make.left.equalTo(@65);
        } else {
            make.left.equalTo(@85);
        }
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.left.equalTo(@0);
        make.right.equalTo(self.vLineView.mas_left);
    }];
    
    [self.enoughRedEveLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLineView.mas_top).offset(-2);
        make.left.equalTo(self.vLineView.mas_right).offset(16);
    }];
    
    [self.canUsedMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.enoughRedEveLab);
        make.bottom.equalTo(self.vLineView.mas_bottom).offset(5);
    }];
    
    [self.deadTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.enoughRedEveLab);
        make.bottom.equalTo(self.canUsedMoneyLab.mas_top).offset(-5);
    }];
}

#pragma mark lazy load
- (ALShadowView *)bgView {
    if(!_bgView) {
        _bgView = [[ALShadowView alloc] init];
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}

- (UIView *)vLineView {
    if(!_vLineView) {
        _vLineView = [[UIView alloc] init];
        _vLineView.backgroundColor = [UIColor colorWithRGB:0xF5F6FA ];
        [self.bgView addSubview:_vLineView];
    }
    return _vLineView;
}

- (UILabel *)priceLab {
    if(!_priceLab) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_priceLab];
    }
    return _priceLab;
}

- (ALLabel *)enoughRedEveLab {
    if(!_enoughRedEveLab) {
        _enoughRedEveLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _enoughRedEveLab.font = ALMediumTitleFont(18);
        [self.bgView addSubview:_enoughRedEveLab];
    }
    return _enoughRedEveLab;
}

- (UIImageView *)selectedIV {
    if(!_selectedIV) {
        _selectedIV = [[UIImageView alloc] init];
        _selectedIV.userInteractionEnabled = YES;
        [self addSubview:_selectedIV];
        
        AL_WeakSelf(self);
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(weakSelf.selectedBlock) {
                weakSelf.selectedBlock(weakSelf.model.index.integerValue);
            }
        }];
        
        [_selectedIV addGestureRecognizer:tapGestureRecognizer];
    }
    return _selectedIV;
}

- (ALLabel *)canUsedMoneyLab {
    if(!_canUsedMoneyLab) {
        _canUsedMoneyLab = [[ALLabel alloc] init];
        _canUsedMoneyLab.font = ALThemeFont(12);
        [self.bgView addSubview:_canUsedMoneyLab];
    }
    return _canUsedMoneyLab;
}

- (ALLabel *)deadTimeLab {
    if(!_deadTimeLab) {
        _deadTimeLab = [[ALLabel alloc] init];
        _deadTimeLab.font = ALThemeFont(12);
        [self.bgView addSubview:_deadTimeLab];
    }
    return _deadTimeLab;
}

- (UIButton *)fastBtn {
    if(!_fastBtn) {
        _fastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fastBtn setBackgroundImage:[UIImage imageNamed:@"lijishiyong"] forState:UIControlStateNormal];
        [self.bgView addSubview:_fastBtn];
        
        AL_WeakSelf(self);
        [_fastBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if(weakSelf.selectedBlock) {
                weakSelf.selectedBlock(weakSelf.model.index.integerValue);
            }
        }];
    }
    return _fastBtn;
}
@end

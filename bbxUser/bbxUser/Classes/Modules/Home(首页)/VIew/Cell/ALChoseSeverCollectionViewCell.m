//
//  ALChoseSeverCollectionViewCell.m
//  bbxUser
//
//  Created by along on 2017/10/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALChoseSeverCollectionViewCell.h"

@interface ALChoseSeverCollectionViewCell ()
@property (nonatomic, strong) UIImageView *bgIV;
@property (nonatomic, strong) ALLabel *msgLab;
@property (nonatomic, strong) ALLabel *lengthLab;
@property (nonatomic, strong) ALLabel *currentPrice;
@property (nonatomic, strong) ALLabel *oldPrice;
@end

@implementation ALChoseSeverCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self.bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
        [self.lengthLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(@10);
        }];
        
        [self.currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView).offset(15);
        }];
        
        [self.msgLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.currentPrice.mas_top).offset(-8);
        }];
        
        [self.oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.currentPrice.mas_bottom).offset(8);
        }];
    }
    return self;
}

- (void)setOptionListModel:(ALOptionListModel *)optionListModel {
    _optionListModel = optionListModel;
    
    if(optionListModel.selected) {
        self.bgIV.image = [UIImage imageNamed:@"fuwuxuanze-xuanzhong"];
    } else {
        self.bgIV.image = [UIImage imageNamed:@"fuwuxuanze-weixuanze"];
    }
    
    self.lengthLab.text = ALStringFormat(@"单人%@小时",optionListModel.serviceLength);
    
    NSMutableAttributedString *currentPriceStr = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"¥%@",optionListModel.limitPrice)];
    
    [currentPriceStr yy_setFont:ALThemeFont(16) range:NSMakeRange(0, 1)];
    [currentPriceStr yy_setFont:ALMediumTitleFont(40) range:NSMakeRange(1, currentPriceStr.length - 1)];
    self.currentPrice.attributedText = currentPriceStr;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"(原价¥%@)",optionListModel.orglPrice) attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
    self.oldPrice.attributedText = attrStr;
}

- (UIImageView *)bgIV {
    if(!_bgIV) {
        _bgIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fuwuxuanze-weixuanze"]];
        [self.contentView addSubview:_bgIV];
    }
    return _bgIV;
}

- (ALLabel *)msgLab {
    if(!_msgLab) {
        _msgLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _msgLab.font = ALMediumTitleFont(16);
        _msgLab.textColor = [UIColor colorWithRGB:0x666666];
        _msgLab.text = @"预付价";
        [self.contentView addSubview:_msgLab];
    }
    return _msgLab;
}

- (ALLabel *)lengthLab {
    if(!_lengthLab) {
        _lengthLab = [[ALLabel alloc] init];
        _lengthLab.font = ALThemeFont(16);
        _lengthLab.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_lengthLab];
    }
    return _lengthLab;
}

- (ALLabel *)currentPrice {
    if(!_currentPrice) {
        _currentPrice = [[ALLabel alloc] init];
        _currentPrice.textColor = [UIColor colorWithRGB:0xFF4E4E];
        [self.contentView addSubview:_currentPrice];
    }
    return _currentPrice;
}

- (ALLabel *)oldPrice {
    if(!_oldPrice) {
        _oldPrice = [[ALLabel alloc] init];
        _oldPrice.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
        [self.contentView addSubview:_oldPrice];
    }
    return _oldPrice;
}
@end

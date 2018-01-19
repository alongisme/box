//
//  ALBalanceRecordTableViewCell.m
//  bbxServer
//
//  Created by along on 2017/9/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBalanceRecordTableViewCell.h"
#import "ALProfitModel.h"

@interface ALBalanceRecordTableViewCell ()
@property (nonatomic, strong) ALLabel *styleLab;
@property (nonatomic, strong) ALLabel *timeLab;
@property (nonatomic, strong) ALLabel *priceLab;
@end

@implementation ALBalanceRecordTableViewCell

- (void)bindModel:(ALProfitListModel *)model {
    self.timeLab.text = model.createTime;
    self.styleLab.text = model.tradeType;
    if([model.profitType isEqualToString:@"plus"]) {
        self.priceLab.text = ALStringFormat(@"+%@",model.tradeMoney);
        self.priceLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
    } else {
        self.priceLab.text = ALStringFormat(@"-%@",model.tradeMoney);
        self.priceLab.textColor = [UIColor colorWithRGB:0x48B32F];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.styleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(@20);
        }];
        
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.styleLab);
            make.top.equalTo(self.styleLab.mas_bottom).offset(10);
        }];
        
        [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(@-14);
        }];
    }
    return self;
}

#pragma mark lazy load
- (ALLabel *)styleLab {
    if(!_styleLab) {
        _styleLab = [[ALLabel alloc] init];
        _styleLab.textColor = [UIColor colorWithRGB:0x555555];
        _styleLab.font = ALThemeFont(16);
        [self.contentView addSubview:_styleLab];
    }
    return _styleLab;
}

- (ALLabel *)timeLab {
    if(!_timeLab) {
        _timeLab = [[ALLabel alloc] init];
        _timeLab.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
        [self.contentView addSubview:_timeLab];
    }
    return _timeLab;
}

- (ALLabel *)priceLab {
    if(!_priceLab) {
        _priceLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _priceLab.font = ALThemeFont(18);
        [self.contentView addSubview:_priceLab];
    }
    return _priceLab;
}
@end

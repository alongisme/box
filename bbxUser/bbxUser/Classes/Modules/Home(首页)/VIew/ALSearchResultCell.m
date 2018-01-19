//
//  ALSearchResultView.m
//  AnyHelp
//
//  Created by along on 2017/8/1.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSearchResultCell.h"

@interface ALSearchResultCell ()
@property (nonatomic, strong) ALLabel *nameLab;
@property (nonatomic, strong) ALLabel *addressLab;
@end

@implementation ALSearchResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@12);
        }];
        
        [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.nameLab);
            make.top.equalTo(self.nameLab.mas_bottom).offset(10);
        }];
    }
    return self;
}

- (void)setIsFirst:(BOOL)isFirst {
    _isFirst = isFirst;
    if(_isFirst) {
        _nameLab.textColor = [UIColor colorWithRGBA:ALThemeColor];
    } else {
        _nameLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
    }
}

- (void)setModel:(ALSearchResultModel *)model {
    _model = model;
    _nameLab.text = model.name;
    _addressLab.text = model.address;
}

#pragma mark lazy load
- (ALLabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _nameLab.font = ALMediumTitleFont(15);
        [self.contentView addSubview:_nameLab];
    }
    return _nameLab;
}

- (ALLabel *)addressLab {
    if(!_addressLab) {
        _addressLab = [[ALLabel alloc] init];
        _addressLab.font = ALThemeFont(13);
        [self.contentView addSubview:_addressLab];
    }
    return _addressLab;
}
@end

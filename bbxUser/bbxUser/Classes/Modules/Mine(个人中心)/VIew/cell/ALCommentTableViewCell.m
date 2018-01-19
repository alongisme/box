//
//  ALCommentTableViewCell.m
//  bbxUser
//
//  Created by along on 2017/8/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCommentTableViewCell.h"
#import "WSStarRatingView.h"
#import "ALSecurityInfoModel.h"

@interface ALCommentTableViewCell ()
@property (nonatomic, strong) ALShadowView *bgView;
@property (nonatomic, strong) UIImageView *headIV;
@property (nonatomic, strong) ALLabel *nameLab;
@property (nonatomic, strong) WSStarRatingView *startLevelView;
@property (nonatomic, strong) ALLabel *timeLab;
@property (nonatomic, strong) ALLabel *contentLab;

@property (nonatomic, strong) ALCommentModel *commentModel;
@end

@implementation ALCommentTableViewCell

- (void)bindModel:(ALCommentModel *)model {
    _commentModel = model;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,model.userIcon)] placeholderImage:[UIImage imageNamed:@"touxiang_weidenglu"]];
    _nameLab.text = model.userNickName;
    _timeLab.text = model.commentTime;
    _contentLab.text = model.comment;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.top.equalTo(@10);
            make.bottom.equalTo(@0);
        }];
        
        [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(@14);
            make.size.mas_equalTo(CGSizeMake(36, 36));
        }];
        
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headIV);
            make.left.equalTo(self.headIV.mas_right).offset(12);
        }];
        
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLab);
            make.right.equalTo(@-14);
        }];
        
        [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.nameLab);
            make.trailing.equalTo(self.timeLab);
            make.bottom.equalTo(@-10);
            make.top.equalTo(self.nameLab.mas_bottom).offset(25);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(!_startLevelView) {
        [self layoutIfNeeded];
        _startLevelView = [[WSStarRatingView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameLab.frame), CGRectGetMaxY(self.nameLab.frame) + 5, 73, 12) numberOfStar:5];
        _startLevelView.userInteractionEnabled = NO;
        [_startLevelView setScore:[_commentModel.rank floatValue] withAnimation:NO];
        [self.bgView addSubview:_startLevelView];
    }
}

#pragma mark lazy load
- (ALShadowView *)bgView {
    if(!_bgView) {
        _bgView = [[ALShadowView alloc] init];
        [self addSubview:_bgView];
    }
    return _bgView;
}

- (UIImageView *)headIV {
    if(!_headIV) {
        _headIV = [[UIImageView alloc] init];
        _headIV.contentMode = UIViewContentModeScaleAspectFill;
        _headIV.layer.masksToBounds = YES;
        _headIV.layer.cornerRadius = 18;
        [self.bgView addSubview:_headIV];
    }
    return _headIV;
}

- (ALLabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [[ALLabel alloc] init];
        _nameLab.text = @"张小猪同学";
        _nameLab.textColor = [UIColor colorWithRGB:0x424242];
        [self.bgView addSubview:_nameLab];
    }
    return _nameLab;
}

- (ALLabel *)timeLab {
    if(!_timeLab) {
        _timeLab = [[ALLabel alloc] init];
        _timeLab.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
        _timeLab.font = ALThemeFont(12);
        _timeLab.text = @"2018-08-10 12:00:00";
        [self.bgView addSubview:_timeLab];
    }
    return _timeLab;
}

- (ALLabel *)contentLab {
    if(!_contentLab) {
        _contentLab = [[ALLabel alloc] init];
        _contentLab.textAlignment = NSTextAlignmentLeft;
        _contentLab.numberOfLines = 0;
        _contentLab.text = @"大侠身手不错，腿部肌肉需要加强锻炼，没事多练练深蹲硬拉啊。腿部肌肉需要加强锻炼，没事多练练深蹲硬拉啊";
        _contentLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
        [self.bgView addSubview:_contentLab];
        
//        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"大侠身手不错，腿部肌肉需要加强锻炼，没事多练练深蹲硬拉啊。腿部肌肉需要加强锻炼，没事多练练深蹲硬拉啊"];
//        attString.yy_lineSpacing = 4;
//        _contentLab.attributedText = attString;
        
    }
    return _contentLab;
}
@end

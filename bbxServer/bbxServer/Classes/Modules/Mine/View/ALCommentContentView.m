//
//  ALCommentContentView.m
//  bbxUser
//
//  Created by along on 2017/8/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCommentContentView.h"
#import "WSStarRatingView.h"

@interface ALCommentContentView ()
@property (nonatomic, strong) UIImageView *headIV;
@property (nonatomic, strong) ALLabel *nameLab;
@property (nonatomic, strong) WSStarRatingView *startLevelView;
@property (nonatomic, strong) ALLabel *timeLab;
@property (nonatomic, strong) ALLabel *contentLab;
@end

@implementation ALCommentContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
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
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(!_startLevelView) {
        _startLevelView = [[WSStarRatingView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameLab.frame), CGRectGetMaxY(self.nameLab.frame) + 5, 78, 14) numberOfStar:5];
        _startLevelView.userInteractionEnabled = NO;
        [_startLevelView setScore:[_commentModel.rank floatValue] withAnimation:NO];
        [self addSubview:_startLevelView];
    }
    
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.nameLab);
        make.trailing.equalTo(self.timeLab);
        make.bottom.equalTo(@-10);
        make.top.mas_equalTo(CGRectGetMaxY(_startLevelView.frame) + 5);
    }];
}

- (void)setCommentModel:(ALCommentModel *)commentModel {
    _commentModel = commentModel;
    
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,commentModel.userIcon)]placeholderImage:[UIImage imageNamed:@"huantouxiang_moren"]];
    self.nameLab.text = commentModel.userNickName;
    self.contentLab.text = commentModel.comment;
    self.timeLab.text = commentModel.commentTime;
}

#pragma mark lazy load
- (UIImageView *)headIV {
    if(!_headIV) {
        _headIV = [[UIImageView alloc] init];
        _headIV.contentMode = UIViewContentModeScaleAspectFill;
        _headIV.backgroundColor = AL_RandomColor;
        _headIV.layer.masksToBounds = YES;
        _headIV.layer.cornerRadius = 18;
        [self addSubview:_headIV];
    }
    return _headIV;
}

- (ALLabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [[ALLabel alloc] init];
        _nameLab.textColor = [UIColor colorWithRGB:0x424242];
        [self addSubview:_nameLab];
    }
    return _nameLab;
}

- (ALLabel *)timeLab {
    if(!_timeLab) {
        _timeLab = [[ALLabel alloc] init];
        _timeLab.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
        _timeLab.font = ALThemeFont(12);
        [self addSubview:_timeLab];
    }
    return _timeLab;
}

- (ALLabel *)contentLab {
    if(!_contentLab) {
        _contentLab = [[ALLabel alloc] init];
        _contentLab.textAlignment = NSTextAlignmentLeft;
        _contentLab.numberOfLines = 0;
        _contentLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
        [self addSubview:_contentLab];
        
    }
    return _contentLab;
}

@end

//
//  ALSecurityView.m
//  bbxUser
//
//  Created by along on 2017/8/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSecurityView.h"
#import "WSStarRatingView.h"

@interface ALSecurityView ()
@property (nonatomic, strong) UIImageView *headIV;
@property (nonatomic, strong) UIImageView *approveIV;
@property (nonatomic, strong) ALLabel *nameLabl;
@property (nonatomic, strong) ALLabel *orderNumLab;
@property (nonatomic, strong) ALLabel *levelLab;
@property (nonatomic, strong) WSStarRatingView *startLevelView;
@property (nonatomic, strong) ALSecurityInfoModel *model;
@end

@implementation ALSecurityView

- (instancetype)initWithFrame:(CGRect)frame model:(ALSecurityInfoModel *)model {
    if(self = [super initWithFrame:frame]) {
        _model = model;
        self.backgroundColor = [UIColor colorWithRGBA:ALThemeColor];
        
        [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.mas_equalTo(ALNavigationBarHeight + 10);
            make.size.mas_equalTo(CGSizeMake(84, 84));
        }];
        
        [self.approveIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self.headIV);
            make.size.mas_equalTo(CGSizeMake(42, 18));
        }];
        
        [self.nameLabl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.headIV.mas_bottom).offset(8);
        }];
        
        [self.orderNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.nameLabl.mas_left).offset(10);
            make.top.equalTo(self.nameLabl.mas_bottom).offset(10);
        }];
        
        [self.levelLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.orderNumLab);
            make.left.equalTo(self.nameLabl.mas_right).offset(-10);
        }];
        
        [self.headIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,model.icon)] placeholderImage:[UIImage imageNamed:@"touxiang_weidenglu"]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if(!_startLevelView) {
        _startLevelView = [[WSStarRatingView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.levelLab.frame), CGRectGetMinY(self.levelLab.frame) + (CGRectGetHeight(self.levelLab.frame) - 13) / 2.0f, 68, 13) numberOfStar:789];
        _startLevelView.userInteractionEnabled = NO;
        [self addSubview:_startLevelView];
        
        [_startLevelView setScore:[_model.avgRank floatValue] withAnimation:NO];
    }
}

#pragma mark lazy load

- (UIImageView *)headIV {
    if(!_headIV) {
        _headIV = [[UIImageView alloc] init];
        _headIV.contentMode = UIViewContentModeScaleAspectFill;
        _headIV.layer.masksToBounds = YES;
        _headIV.layer.cornerRadius = 42;
        [self addSubview:_headIV];
    }
    return _headIV;
}

- (UIImageView *)approveIV {
    if(!_approveIV) {
        _approveIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-Authenticated"]];
        [self addSubview:_approveIV];
    }
    return _approveIV;
}

- (ALLabel *)nameLabl {
    if(!_nameLabl) {
        _nameLabl = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _nameLabl.font = ALMediumTitleFont(16);
        _nameLabl.text = _model.realName;
        _nameLabl.textColor = [UIColor whiteColor];
        [self addSubview:_nameLabl];
    }
    return _nameLabl;
}

- (ALLabel *)orderNumLab {
    if(!_orderNumLab) {
        _orderNumLab = [[ALLabel alloc] init];
        _orderNumLab.text = ALStringFormat(@"接单数：%@",_model.doOrderNum);
        _orderNumLab.textColor = [UIColor whiteColor];
        [self addSubview:_orderNumLab];
    }
    return _orderNumLab;
}

- (ALLabel *)levelLab {
    if(!_levelLab) {
        _levelLab = [[ALLabel alloc] init];
        _levelLab.text = @"评级：";
        _levelLab.textColor = [UIColor whiteColor];
        [self addSubview:_levelLab];
    }
    return _levelLab;
}
@end

//
//  ALEvaluateView.m
//  bbxUser
//
//  Created by along on 2017/8/8.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALEvaluateView.h"
//#import "ClickedLabelView.h"
#import "ALCustomTagView.h"

@interface ALEvaluateView () <StarRatingViewDelegate>
@property (nonatomic, strong) WSStarRatingView *startLevelView;
//@property (nonatomic, weak) ClickedLabelView *labelView;
@property (nonatomic, weak) ALCustomTagView *customTagView;
@property (nonatomic, strong) UIImageView *headIV;
@property (nonatomic, strong) ALLabel *nameLab;
@property (nonatomic, strong) UIImageView *rankIV;
@end

@implementation ALEvaluateView

- (instancetype)initWithFrame:(CGRect)frame securityModel:(ALSecurityModel *)securityModel titleDataArray:(NSArray *)titleDataArray index:(unsigned int)index {
    if(self = [super initWithFrame:frame]) {
        [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(@14);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headIV.mas_centerX).offset(-5);
            make.top.equalTo(self.headIV.mas_bottom).offset(10);
        }];
        
        [self.rankIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLab);
            make.left.equalTo(self.nameLab.mas_right).offset(5);
        }];
        
        [self layoutIfNeeded];
        self.score = 0;
        [self.startLevelView setScore:0 withAnimation:NO];
        
        ALCustomTagView *customTagView = [[ALCustomTagView alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(self.startLevelView.frame) + 13, frame.size.width - 28, 3 * (24 + 10)) tagArray:titleDataArray startOffsetX:0 space:10 expandHeight:10 selected:YES];
        customTagView.securityEva = YES;
        [self addSubview:customTagView];
        self.customTagView = customTagView;
//        ClickedLabelView *labelView = [[ClickedLabelView alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(self.startLevelView.frame) + 13, frame.size.width - 28, 105) dataArray:titleDataArray startMargin:0];
//        labelView.securityEva = YES;
//        [self addSubview:labelView];
//        self.labelView = labelView;
        
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.right.equalTo(@-14);
            make.top.mas_equalTo(CGRectGetMaxY(customTagView.frame) + 15);
            make.bottom.equalTo(@-10);
        }];
        
        [_headIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,securityModel.icon)] placeholderImage:[UIImage imageNamed:@"touxiang_weidenglu"]];
        _nameLab.text = securityModel.realName;
        _rankIV.image = [UIImage imageNamed:securityModel.isLeader.boolValue ? @"icon_leader" : @"icon_member"];
    }
    return self;
}

- (NSString *)tagString {
    NSString *string = [self.customTagView getSelectedTagString];
    if(string.length == 0) return @"";
    return string;
}

#pragma mark StarRatingViewDelegate
- (void)starRatingView:(WSStarRatingView *)view score:(int)score {
//    if(score == 0.1 || score == 0.2) {
//        self.score = 1;
//    } else if(score == 0.3 || score == 0.4) {
//        self.score = 2;
//    } else if(score == 0.5 || score == 0.6) {
//        self.score = 3;
//    } else if(score == 0.7 || score == 0.8) {
//        self.score = 4;
//    } else if(score == 0.9 || score == 1.0){
//        self.score = 5;
//    } else {
//        self.score = 0;
//    }
    self.score = score;
}

#pragma mark lazy load
- (UIImageView *)headIV {
    if(!_headIV) {
        _headIV = [[UIImageView alloc] init];
        _headIV.contentMode = UIViewContentModeScaleAspectFill;
        _headIV.layer.masksToBounds = YES;
        _headIV.layer.cornerRadius = 30;
        [self addSubview:_headIV];
    }
    return _headIV;
}

- (ALLabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [[ALLabel alloc] init];
        _nameLab.font = ALThemeFont(16);
        [self addSubview:_nameLab];
    }
    return _nameLab;
}

- (UIImageView *)rankIV {
    if(!_rankIV) {
        _rankIV = [[UIImageView alloc] init];
        [self addSubview:_rankIV];
    }
    return _rankIV;
}
- (WSStarRatingView *)startLevelView {
    if(!_startLevelView) {
        _startLevelView = [[WSStarRatingView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 155 / 2, CGRectGetMaxY(self.nameLab.frame) + 22 + 16, 156, 22) numberOfStar:456];
        _startLevelView.delegate = self;
        [self addSubview:_startLevelView];
    }
    return _startLevelView;
}

- (IQTextView *)textView {
    if(!_textView) {
        _textView = [[IQTextView alloc] init];
        _textView.placeholder = @"这个保镖非常好～";
        _textView.font = ALThemeFont(14);
        _textView.layer.masksToBounds = YES;
        _textView.layer.cornerRadius = 6;
        _textView.layer.borderColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00].CGColor;
        _textView.layer.borderWidth = 1;
        _textView.textContainerInset = UIEdgeInsetsMake(10, 5, 0, 0);
        [_textView setValue:[UIColor colorWithRGBA:ALMsgTitleColor] forKeyPath:@"_placeholderLabel.textColor"];
        [self addSubview:_textView];
    }
    return _textView;
}
@end

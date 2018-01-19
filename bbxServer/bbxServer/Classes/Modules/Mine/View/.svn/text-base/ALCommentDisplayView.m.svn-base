//
//  ALCommentDisplayView.m
//  bbxUser
//
//  Created by along on 2017/8/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCommentDisplayView.h"
#import "ALCommentContentView.h"

@interface ALCommentDisplayView ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) ALLabel *commentLab;
@property (nonatomic, strong) UIImageView *rightIV;
@property (nonatomic, strong) UIView *hLineView;
@property (nonatomic, strong) ALCommentContentView *commentOneContentView;
@property (nonatomic, strong) ALCommentContentView *commentTwoContentView;

@property (nonatomic, strong) ALSecurityInfoModel *securityInfoModel;
@end

@implementation ALCommentDisplayView

- (instancetype)initWithFrame:(CGRect)frame model:(ALSecurityInfoModel *)model {
    if(self = [super initWithFrame:frame]) {
        _securityInfoModel = model;
        
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(@0);
            make.height.equalTo(@33);
        }];
        
        [self.commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.centerY.equalTo(self.topView);
        }];
        
        [self.rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.commentLab);
            make.right.equalTo(@-14);
        }];
        
        [self.hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topView.mas_bottom);
            make.left.right.equalTo(@0);
            make.height.equalTo(@1);
        }];
        
        [self.commentOneContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.hLineView.mas_bottom);
            make.height.equalTo(@95);
            make.left.right.equalTo(@0);
        }];
        
        if(model.commentList.count != 1) {
            [self.commentTwoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.commentOneContentView.mas_bottom);
                make.height.equalTo(self.commentOneContentView);
                make.left.right.equalTo(@0);
            }];
        }
    }
    return self;
}

#pragma mark lazy load
- (UIView *)topView {
    if(!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor clearColor];
        [self addSubview:_topView];
        
        AL_WeakSelf(self);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(weakSelf.moreCommentClick) {
                weakSelf.moreCommentClick();
            }
        }];
        
        [_topView addGestureRecognizer:tapGesture];
    }
    return _topView;
}

- (ALLabel *)commentLab {
    if(!_commentLab) {
        _commentLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _commentLab.text = ALStringFormat(@"评论（%@）",_securityInfoModel.commentNum);
        _commentLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
        _commentLab.font = ALMediumTitleFont(12);
        [self.topView addSubview:_commentLab];
    }
    return _commentLab;
}

- (UIImageView *)rightIV {
    if(!_rightIV) {
        _rightIV = [[UIImageView alloc] init];
        _rightIV.image = [UIImage imageNamed:@"Right"];
        [self addSubview:_rightIV];
    }
    return _rightIV;
}

- (UIView *)hLineView {
    if(!_hLineView) {
        _hLineView = [[UIView alloc] init];
        _hLineView.backgroundColor = [UIColor colorWithRGBA:0xF5F6FAFF];
        [self addSubview:_hLineView];
    }
    return _hLineView;
}

- (ALCommentContentView *)commentOneContentView {
    if(!_commentOneContentView) {
        _commentOneContentView = [[ALCommentContentView alloc] initWithFrame:CGRectZero];
        _commentOneContentView.commentModel = [_securityInfoModel.commentList firstObject];
        [self addSubview:_commentOneContentView];
    }
    return _commentOneContentView;
}

- (ALCommentContentView *)commentTwoContentView {
    if(!_commentTwoContentView) {
        _commentTwoContentView = [[ALCommentContentView alloc] initWithFrame:CGRectZero];
        _commentTwoContentView.commentModel = [_securityInfoModel.commentList lastObject];
        [self addSubview:_commentTwoContentView];
    }
    return _commentTwoContentView;
}

@end

//
//  ALWXShareView.m
//  bbxUser
//
//  Created by xlshi on 2017/11/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALWXShareView.h"

@interface ALWXShareView ()
@property (nonatomic, strong) ALLabel *titleLab;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *wxFriendIV;
@property (nonatomic, strong) UIImageView *wxFriendCircleIV;
@property (nonatomic, strong) UIButton *cancelBtn;
@end

@implementation ALWXShareView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRGBA:0x00000099];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(@155);
        }];
        
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(@50);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.bottom.equalTo(self.cancelBtn.mas_top);
            make.height.equalTo(@0.5);
        }];
        
        //54
        [self.wxFriendIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(54, 54));
            make.left.mas_equalTo((ALScreenWidth - 54 * 2) / 3.0f);
            make.top.mas_equalTo((104.5 - 54) / 2.0);
        }];
        
        [self.wxFriendCircleIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.wxFriendIV);
            make.top.equalTo(self.wxFriendIV);
            make.right.mas_equalTo(-(ALScreenWidth - 54 * 2) / 3.0f);
        }];
    }
    return self;
}

- (void)show {
    [ALKeyWindow addSubview:self];

    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (void)cancelAction {
    [self removeFromSuperview];
}

#pragma mark lazy load
- (UIView *)bgView {
    if(!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
    }
    return _bgView;
}

- (UIImageView *)wxFriendIV {
    if(!_wxFriendIV) {
        _wxFriendIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"piaoquan"]];
        _wxFriendIV.userInteractionEnabled = YES;
        [self.bgView addSubview:_wxFriendIV];
        
        AL_WeakSelf(self);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(weakSelf.didSelectedIndex) {
                weakSelf.didSelectedIndex(0);
            }
        }];
        [_wxFriendIV addGestureRecognizer:tap];
    }
    return _wxFriendIV;
}

- (UIImageView *)wxFriendCircleIV {
    if(!_wxFriendCircleIV) {
        _wxFriendCircleIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weixin"]];
        _wxFriendCircleIV.userInteractionEnabled = YES;
        [self.bgView addSubview:_wxFriendCircleIV];
        AL_WeakSelf(self);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(weakSelf.didSelectedIndex) {
                weakSelf.didSelectedIndex(1);
            }
        }];
        [_wxFriendCircleIV addGestureRecognizer:tap];
    }
    return _wxFriendCircleIV;
}

- (UIView *)lineView {
    if(!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRGB:0xD8D8D8];
        [self.bgView addSubview:_lineView];
    }
    return _lineView;
}

- (UIButton *)cancelBtn {
    if(!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.titleLabel.font = ALThemeFont(16);
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithRGBA:0x666666ff] forState:UIControlStateNormal];
        [self.bgView addSubview:_cancelBtn];
    }
    return _cancelBtn;
}
@end

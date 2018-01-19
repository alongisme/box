//
//  ALSegmentedView.m
//  bbxUser
//
//  Created by along on 2017/8/8.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSegmentedView.h"

@interface ALSegmentedView ()
@property (nonatomic, assign) ALSegmentedStyle style;

@property (nonatomic, strong) UIButton *finishedBtn;
@property (nonatomic, strong) UIButton *unfinishedBtn;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ALSegmentedView

- (instancetype)initWithFrame:(CGRect)frame style:(ALSegmentedStyle)style {
    if(self = [super initWithFrame:frame]) {
        self.style = style;
        switch (style) {
            case ALSegmentedStyleOrderList:
                [self initOrderListSegmented];
                break;
            case ALSegmentedStyleMainPage:
                [self initMainPageSegmented];
                break;
            default:
                break;
        }
    }
    return self;
}

#pragma mark initOrderListSegmented
- (void)initOrderListSegmented {
    [self.finishedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.top.bottom.equalTo(@0);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    
    [self.unfinishedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.top.bottom.width.equalTo(self.finishedBtn);
        make.right.equalTo(@0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.width.equalTo(self.unfinishedBtn);
        make.right.mas_equalTo(-ALScreenWidth/2.0);
        make.height.equalTo(@2);
    }];
}

#pragma mark initMainPageSegmented
- (void)initMainPageSegmented {
    [self.finishedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.top.bottom.equalTo(@0);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    
    [self.unfinishedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.top.bottom.width.equalTo(self.finishedBtn);
        make.right.equalTo(@0);
    }];
}

#pragma mark Action
- (void)finishedButtonAction:(UIButton *)sender {
    if(!sender.selected) {
        sender.selected = YES;
        switch (_style) {
            case ALSegmentedStyleOrderList: {
                sender.titleLabel.font = ALMediumTitleFont(14);
                
                self.unfinishedBtn.titleLabel.font = ALThemeFont(14);
                self.unfinishedBtn.selected = NO;
                
                [UIView animateWithDuration:0.3 animations:^{
                    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(-ALScreenWidth/2.0);
                    }];
                    [self layoutIfNeeded];
                }];
            }
                break;
            case ALSegmentedStyleMainPage: {
                self.unfinishedBtn.selected = NO;
            }
                break;
            default:
                break;
        }
    
        if(self.segemtedDidValueChanged) {
            self.segemtedDidValueChanged(0);
        }
    }
}

- (void)unfinishedButtonAction:(UIButton *)sender {
    if(!sender.selected) {
        sender.selected = YES;
        switch (_style) {
            case ALSegmentedStyleOrderList: {
                sender.titleLabel.font = ALMediumTitleFont(14);
                
                self.finishedBtn.titleLabel.font = ALThemeFont(14);
                self.finishedBtn.selected = NO;
                
                [UIView animateWithDuration:0.3 animations:^{
                    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(@0);
                    }];
                    [self layoutIfNeeded];
                }];
            }
                break;
            case ALSegmentedStyleMainPage: {
                self.finishedBtn.selected = NO;
            }
                break;
            default:
                break;
        }
        
        if(self.segemtedDidValueChanged) {
            self.segemtedDidValueChanged(1);
        }
    }
}

#pragma mark lazy load
- (UIButton *)finishedBtn {
    if(!_finishedBtn) {
        _finishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        switch (_style) {
            case ALSegmentedStyleOrderList: {
                [_finishedBtn setTitle:@"未完成" forState:UIControlStateNormal];
                [_finishedBtn setTitleColor:[UIColor colorWithRGBA:ALLabelTextColor] forState:UIControlStateNormal];
                [_finishedBtn setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateSelected];
                _finishedBtn.titleLabel.font = ALMediumTitleFont(14);
                _finishedBtn.selected = YES;
            }
                break;
            case ALSegmentedStyleMainPage: {
                [_finishedBtn setBackgroundImage:[UIImage imageNamed:@"hujiao-weixuanzhong"] forState:UIControlStateNormal];
                [_finishedBtn setBackgroundImage:[UIImage imageNamed:@"hujiao-selected"] forState:UIControlStateSelected];
                _finishedBtn.selected = YES;
                _finishedBtn.adjustsImageWhenHighlighted = NO;
            }
                break;
            default:
                break;
        }
        
        
        [_finishedBtn addTarget:self action:@selector(finishedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_finishedBtn];
    }
    return _finishedBtn;
}

- (UIButton *)unfinishedBtn {
    if(!_unfinishedBtn) {
        _unfinishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        switch (_style) {
            case ALSegmentedStyleOrderList: {
                [_unfinishedBtn setTitle:@"已完成" forState:UIControlStateNormal];
                [_unfinishedBtn setTitleColor:[UIColor colorWithRGBA:ALLabelTextColor] forState:UIControlStateNormal];
                [_unfinishedBtn setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateSelected];
                _unfinishedBtn.titleLabel.font = ALThemeFont(14);
            }
                break;
            case ALSegmentedStyleMainPage: {
                [_unfinishedBtn setBackgroundImage:[UIImage imageNamed:@"dingzhi-weixuanzhong"] forState:UIControlStateNormal];
                [_unfinishedBtn setBackgroundImage:[UIImage imageNamed:@"dingzhi-selected"] forState:UIControlStateSelected];
                _unfinishedBtn.adjustsImageWhenHighlighted = NO;
            }
                break;
            default:
                break;
        }
        
        
        [_unfinishedBtn addTarget:self action:@selector(unfinishedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_unfinishedBtn];
    }
    return _unfinishedBtn;
}

- (UIView *)lineView {
    if(!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRGBA:ALThemeColor];
        [self addSubview:_lineView];
    }
    return _lineView;
}
@end

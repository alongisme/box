//
//  ALInstructionsView.m
//  bbxUser
//
//  Created by along on 2017/9/18.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALInstructionsView.h"

@interface ALInstructionsView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@end

@implementation ALInstructionsView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark lazy load
- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if(!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 3;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (UIButton *)leftBtn {
    if(!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self addSubview:_leftBtn];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if(!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}

- (UIButton *)closeBtn {
    if(!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self addSubview:_closeBtn];
    }
    return _closeBtn;
}
@end

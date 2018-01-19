//
//  ALNoResultView.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALNoResultView.h"

@interface ALNoResultView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) ALLabel *messageLab;
@property (nonatomic, assign) NSUInteger style;
@end

@implementation ALNoResultView

- (instancetype)initWithFrame:(CGRect)frame style:(NSUInteger)style {
    if(self = [super initWithFrame:frame]) {
        _style = style;
    }
    return self;
}

- (instancetype)init {
    if(self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).multipliedBy(0.8);
    }];
    
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(18);
    }];
}

#pragma mark lazy load
- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_style == 0 ? @"No address" : @"meiyoudingdan"]];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (ALLabel *)messageLab {
    if(!_messageLab) {
        _messageLab = [[ALLabel alloc] init];
        _messageLab.font = ALThemeFont(13);
        _messageLab.text = _style == 0 ? @"暂未找到该地址，请核查后输入" : @"您还没有相关订单哦～";
        [self addSubview:_messageLab];
    }
    return _messageLab;
}
@end

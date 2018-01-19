//
//  ALStepView.m
//  AnyHelp
//
//  Created by along on 2017/7/26.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALStepView.h"

@interface ALStepView ()
@property (nonatomic, strong) ALLabel *stepLab;
@property (nonatomic, strong) ALLabel *contentLab;
@end

@implementation ALStepView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.stepLab.text = title;
        self.contentLab.text = subTitle;
        [self.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeZero radius:1];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.stepLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@15);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.stepLab.mas_bottom).offset(9);
    }];
}

#pragma mark lazy load
- (ALLabel *)stepLab {
    if(!_stepLab) {
        _stepLab = [[ALLabel alloc] init];
        _stepLab.font = ALThemeFont(18);
        [self addSubview:_stepLab];
    }
    return _stepLab;
}

- (ALLabel *)contentLab {
    if(!_contentLab) {
        _contentLab = [[ALLabel alloc] init];
        _contentLab.font = ALThemeFont(16);
        [self addSubview:_contentLab];
    }
    return _contentLab;
}
@end

//
//  ALStepView.m
//  bbxServer
//
//  Created by along on 2017/8/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALStepView.h"

@interface ALStepView ()
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) UIView *hLineView;
@end

@implementation ALStepView

- (instancetype)initWithFrame:(CGRect)frame index:(NSUInteger)index {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeZero radius:1];
        
        _index = index;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    _hLineView = [[UIView alloc] init];
    _hLineView.backgroundColor = [UIColor colorWithRGBA:ALThemeColor];
    [self addSubview:_hLineView];
    
    NSArray *titleArray = @[@"第一步",@"第二步",@"第三步"];
    NSArray *contentArray = @[@"身份信息",@"账户信息",@"从业信息"];
    
    NSMutableArray *bgArr = [NSMutableArray array];
    for (unsigned int i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        NSString *content = contentArray[i];
        
        UIView *bgView = [[UIView alloc] init];
        [self addSubview:bgView];
        [bgArr addObject:bgView];
        
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stepClickGestureRecognizer:)];
//        [bgView addGestureRecognizer:tapGesture];
//        bgView.tag = i + 10;
        
        ALLabel *titleLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        titleLab.text = title;
        [bgView addSubview:titleLab];
        titleLab.tag = i + 20;
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView).offset(-10);
            make.centerX.equalTo(bgView);
        }];
        
        ALLabel *contentLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        contentLab.text = content;
        [bgView addSubview:contentLab];
        contentLab.tag = i + 30;
        
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView).offset(10);
            make.centerX.equalTo(bgView);
        }];
        
        if(i == _index) {
            titleLab.textColor = [UIColor colorWithRGBA:ALThemeColor];
            contentLab.textColor = [UIColor colorWithRGBA:ALThemeColor];
        } else {
            titleLab.textColor = [UIColor colorWithRGB:0xD6D5D5];
            contentLab.textColor = [UIColor colorWithRGB:0xCDCBCB];
        }
    }
    
    [bgArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [bgArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.height.equalTo(self);
    }];
    
    [_hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *view = bgArr[_index];
        make.width.equalTo(view);
        make.bottom.equalTo(@0);
        make.height.equalTo(@2);
        make.centerX.equalTo(view);
    }];
}

- (void)didSelectedIndex:(NSUInteger)index {
    
    NSUInteger tag = index + 10;
    
    for (unsigned int i = 0; i < 3; i++) {
        ALLabel *titleLab = [self viewWithTag:i + 20];
        ALLabel *contentLab = [self viewWithTag:i + 30];
        if(tag - 10 == i) {
            titleLab.textColor = [UIColor colorWithRGBA:ALThemeColor];
            contentLab.textColor = [UIColor colorWithRGBA:ALThemeColor];
        } else {
            titleLab.textColor = [UIColor colorWithRGB:0xD6D5D5];
            contentLab.textColor = [UIColor colorWithRGB:0xCDCBCB];
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.hLineView mas_updateConstraints:^(MASConstraintMaker *make) {
                if(tag - 10 == 0) {
                    make.left.equalTo(@0);
                } else if(tag - 10 == 1) {
                    make.left.equalTo(@(ALScreenWidth / 3.0));
                } else {
                    make.left.equalTo(@(ALScreenWidth / 3.0 * 2));
                }
            }];
            
            [self layoutIfNeeded];
        }];
    }
}

//- (void)stepClickGestureRecognizer:(UITapGestureRecognizer *)recognizer {
//    NSUInteger tag = recognizer.view.tag;
//    
//    for (unsigned int i = 0; i < 3; i++) {
//        ALLabel *titleLab = [self viewWithTag:i + 20];
//        ALLabel *contentLab = [self viewWithTag:i + 30];
//        if(tag - 10 == i) {
//            titleLab.textColor = [UIColor colorWithRGBA:ALThemeColor];
//            contentLab.textColor = [UIColor colorWithRGBA:ALThemeColor];
//        } else {
//            titleLab.textColor = [UIColor colorWithRGB:0xD6D5D5];
//            contentLab.textColor = [UIColor colorWithRGB:0xCDCBCB];
//        }
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            [self.hLineView mas_updateConstraints:^(MASConstraintMaker *make) {
//                if(tag - 10 == 0) {
//                    make.left.equalTo(@0);
//                } else if(tag - 10 == 1) {
//                    make.left.equalTo(@(ALScreenWidth / 3.0));
//                } else {
//                    make.left.equalTo(@(ALScreenWidth / 3.0 * 2));
//                }
//            }];
//            
//            [self layoutIfNeeded];
//        }];
//    }
//    
//    if(self.stepClickBlock) {
//        self.stepClickBlock(tag - 10);
//    }
//}

@end

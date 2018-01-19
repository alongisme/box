//
//  ALAdditionalDemandView.m
//  bbxUser
//
//  Created by xlshi on 2017/10/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAdditionalDemandView.h"

@implementation ALAdditionalDemandView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray {
    if(self = [super initWithFrame:frame]) {
        ALLabel *choseSeverLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        choseSeverLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
        choseSeverLab.text = @"额外需求";
        [self addSubview:choseSeverLab];
        
        [choseSeverLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(@0);
        }];
        
        [self layoutIfNeeded];
        
        _clickedLabelView = [[ClickedLabelView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(choseSeverLab.frame), frame.size.width, 0) dataArray:dataArray startMargin:0];
        _clickedLabelView.backgroundColor = [UIColor clearColor];
        [self addSubview:_clickedLabelView];
        
        _clickedLabelView.frame = CGRectMake(0, CGRectGetMaxY(choseSeverLab.frame), frame.size.width, _clickedLabelView.maxY);
    }
    return self;
}

- (NSString *)getAllAdditionalDemand {
    return [_clickedLabelView getSelectedTagString];
}
@end

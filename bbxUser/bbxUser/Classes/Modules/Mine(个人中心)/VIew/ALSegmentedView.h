//
//  ALSegmentedView.h
//  bbxUser
//
//  Created by along on 2017/8/8.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALShadowView.h"

typedef NS_ENUM(NSUInteger,ALSegmentedStyle) {
    ALSegmentedStyleOrderList = 0,
    ALSegmentedStyleMainPage = 1,
};

@interface ALSegmentedView : ALShadowView
@property (nonatomic, copy) void (^segemtedDidValueChanged)(NSUInteger index);
- (instancetype)initWithFrame:(CGRect)frame style:(ALSegmentedStyle)style;
@end

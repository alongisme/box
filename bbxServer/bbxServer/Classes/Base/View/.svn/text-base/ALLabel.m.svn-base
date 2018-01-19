//
//  ALLabel.m
//  AnyHelp
//
//  Created by along on 2017/7/26.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALLabel.h"

@implementation ALLabel

- (instancetype)init {
    if(self = [super init]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrameAndMedium:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        self.font = ALMediumTitleFont(14);
    }
    return self;
}

- (void)setUp {
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
    self.font = ALThemeFont(14);
}

@end

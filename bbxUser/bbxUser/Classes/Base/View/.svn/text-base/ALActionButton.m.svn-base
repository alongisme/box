//
//  ALActionButton.m
//  AnyHelp
//
//  Created by along on 2017/7/25.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALActionButton.h"

@implementation ALActionButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType arc:(BOOL)arc {
    ALActionButton *actionButton = [super buttonWithType:buttonType];
    [actionButton setBackgroundImage:[UIImage imageNamed:arc?@"btn_next-nor":@"btn-nor"] forState:UIControlStateNormal];
    [actionButton setBackgroundImage:[UIImage imageNamed:arc?@"btn-next-pressed":@"btn-pressed"] forState:UIControlStateHighlighted];
    [actionButton setTitleColor:[UIColor colorWithRGBA:ALButtonColor] forState:UIControlStateNormal];
    actionButton.titleLabel.font = ALThemeFont(18);
    actionButton.titleEdgeInsets = UIEdgeInsetsMake(-2, 0, 0, 0);
    return actionButton;
}

@end

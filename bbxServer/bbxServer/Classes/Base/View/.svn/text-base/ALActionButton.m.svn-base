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
    [actionButton setBackgroundImage:[UIImage imageNamed:arc ? @"btn-Sign in-activate" : @"btn-nor"] forState:UIControlStateNormal];
    [actionButton setBackgroundImage:[UIImage imageNamed:arc ? @"btn-Sign in-disabled" : @"btn-disabled"] forState:UIControlStateDisabled];
    [actionButton setBackgroundImage:[UIImage imageNamed:arc ? @"btn-Sign in-Pressed" : @"btn-pressed"] forState:UIControlStateHighlighted];
    [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [actionButton setTitleColor:[UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00] forState:UIControlStateDisabled];
    actionButton.titleLabel.font = ALThemeFont(17);
    actionButton.titleEdgeInsets = UIEdgeInsetsMake(-2, 0, 0, 0);
    return actionButton;
}

+ (instancetype)buttonWithArcType:(UIButtonType)buttonType {
    ALActionButton *actionButton = [super buttonWithType:buttonType];
    [actionButton setBackgroundImage:[UIImage imageNamed:@"btn_next-nor"] forState:UIControlStateNormal];
    [actionButton setBackgroundImage:[UIImage imageNamed:@"btn-next-pressed"] forState:UIControlStateHighlighted];
    [actionButton setBackgroundImage:[UIImage imageNamed:@"btn-next-disabled"] forState:UIControlStateDisabled];
    [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    actionButton.titleLabel.font = ALThemeFont(17);
    actionButton.titleEdgeInsets = UIEdgeInsetsMake(-2, 0, 0, 0);
    return actionButton;
}

@end

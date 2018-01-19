//
//  UIFont+ALFontSize.m
//  bbxUser
//
//  Created by along on 2017/8/22.
//  Copyright © 2017年 along. All rights reserved.
//

#import "UIFont+ALFontSize.h"
#import <objc/runtime.h>

@implementation UIFont (ALFontSize)
+ (void)load {
    [self swizzleClassMethod:@selector(fontWithName:size:) with:@selector(al_fontWithName:size:)];
}

+ (UIFont *)al_fontWithName:(NSString *)fontName size:(CGFloat)fontSize {
    NSString *currentDeviceName = [UIDevice currentDevice].machineModelName;
    
    if([currentDeviceName isEqualToString:@"iPhone 5"] || [currentDeviceName isEqualToString:@"iPhone 5s"] || [currentDeviceName isEqualToString:@"iPhone 5c"]) {
        return [self al_fontWithName:fontName size:fontSize - 1];
    } else if ([currentDeviceName isEqualToString:@"iPhone 7"] || [currentDeviceName isEqualToString:@"iPhone 7s"]) {
        return [self al_fontWithName:fontName size:fontSize];
    } else if ([currentDeviceName isEqualToString:@"iPhone 7 Plus"] || [currentDeviceName isEqualToString:@"iPhone 6 Plus"] || [currentDeviceName isEqualToString:@"iPhone 6s Plus"]){
        return [self al_fontWithName:fontName size:fontSize + 1];
    } else {
        return [self al_fontWithName:fontName size:fontSize];
    }
}
@end

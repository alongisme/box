//
//  ALAlertViewController.m
//  bbxUser
//
//  Created by along on 2017/8/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAlertViewController.h"

@implementation ALAlertViewController

+ (void)showAlertOnlyCancelButton:(UIViewController *)delegate title:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style alertArray:(NSArray *)alertArray clickBlock:(void (^)(int index))clickBlock {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    for (unsigned int i = 0; i < alertArray.count; i++) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:alertArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(clickBlock) {
                clickBlock(i);
            }
        }];
        
        [alertController addAction:alertAction];
    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [delegate presentViewController:alertController animated:YES completion:nil];
    });
}

+ (void)showAlertOnlyCancelButton:(UIViewController *)delegate title:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style Destructive:(NSString *)destructive clickBlock:(void (^)())clickBlock {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:destructive style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if(clickBlock) {
            clickBlock();
        }
    }];
    
    if([destructive isEqualToString:@"确认放弃"]) {
        [alertAction setValue:[UIColor colorWithRGB:0x999999] forKey:@"titleTextColor"];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"再考虑下" style:UIAlertActionStyleDefault handler:nil];
        [cancelAction setValue:[UIColor colorWithRGBA:ALThemeColor] forKey:@"titleTextColor"];
        [alertController addAction:alertAction];
        [alertController addAction:cancelAction];
    } else if([destructive isEqualToString:@"查看镖师动态"] || [destructive isEqualToString:@"前往"] || [destructive isEqualToString:@"去支付"]){
        [alertAction setValue:[UIColor colorWithRGBA:ALThemeColor] forKey:@"titleTextColor"];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [cancelAction setValue:[UIColor colorWithRGB:0x999999] forKey:@"titleTextColor"];
        [alertController addAction:cancelAction];
        [alertController addAction:alertAction];
    } else if([destructive isEqualToString:@"取消订单"]){
        [alertAction setValue:[UIColor colorWithRGB:0x999999] forKey:@"titleTextColor"];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续等待" style:UIAlertActionStyleDefault handler:nil];
        [cancelAction setValue:[UIColor colorWithRGBA:ALThemeColor] forKey:@"titleTextColor"];
        [alertController addAction:alertAction];
        [alertController addAction:cancelAction];
    } else {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        
        if(![destructive isEqualToString:@"退出"]) {
            [alertAction setValue:[UIColor colorWithRGB:0x999999] forKey:@"titleTextColor"];
        }
        
        [alertController addAction:alertAction];
        [alertController addAction:cancelAction];
    }
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [delegate presentViewController:alertController animated:YES completion:nil];
    });
}

+ (void)showAlertCustomCancelButton:(UIViewController *)delegate title:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancelTitle:(NSString *)cancelTitle clickBlock:(void (^)())clickBlock {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(clickBlock) {
            clickBlock();
        }
    }];
    [alertController addAction:cancelAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [delegate presentViewController:alertController animated:YES completion:nil];
    });
}
@end

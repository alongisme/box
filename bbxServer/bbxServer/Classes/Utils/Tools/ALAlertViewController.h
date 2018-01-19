//
//  ALAlertViewController.h
//  bbxUser
//
//  Created by along on 2017/8/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALAlertViewController : NSObject
+ (void)showAlertOnlyCancelButton:(UIViewController *)delegate title:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style alertArray:(NSArray *)alertArray clickBlock:(void (^)(int index))clickBlock;

+ (void)showAlertOnlyCancelButton:(UIViewController *)delegate title:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style Destructive:(NSString *)destructive clickBlock:(void (^)())clickBlock;

+ (void)showAlertCustomCancelButton:(UIViewController *)delegate title:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancelTitle:(NSString *)cancelTitle clickBlock:(void (^)())clickBlock;
@end

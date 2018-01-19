//
//  ALMobilePayService.h
//  MobilePayDemo-master
//
//  Created by along on 2017/7/24.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>

typedef NS_ENUM(NSUInteger, ALPayHandle) {
    ALPayHandleSuceess = 0,//成功
    ALPayHandleFailed = 1,//失败
    ALPayHandleCancel = 2,//取消支付
};

@interface ALMobilePayService : NSObject 
//支付回调
@property(nonatomic,copy)void (^PayCompltedHandleBlock)(ALPayHandle handel);

+ (ALMobilePayService *)sharedInstance;
//支付状态判断
- (void)aliPayOrderStatus:(NSUInteger)stauts;
//微信支付
- (void)wechatOayOrderString:(NSString *)orderString;
//支付宝支付
- (void)alipayWithOrderString:(NSString *)orderString;
@end

//
//  ALCreateAppPayApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALCreateAppPayApi : ALHttpRequest

//1.2修改


/**
 创建订单支付接口

 @param orderId 订单id
 @param payType 支付类型
 @param couponId 优惠券id
 @param payChannel 支付方式
 @return self
 */
- (instancetype)initWithCreateAppPayApi:(NSString *)orderId PayType:(NSString *)payType couponId:(NSString *)couponId payChannel:(NSString *)payChannel;

@end

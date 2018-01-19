//
//  ALAvailableCouponListApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALRedEnvelopoModel.h"

@interface ALAvailableCouponListApi : ALHttpRequest

@property (nonatomic, strong) NSArray<ALRedEnvelopoModel *> *couponList;

/**
 获取订单可用优惠券列表

 @param orderId 订单id
 @return self
 */
- (instancetype)initWithAvailableCouponListApi:(NSString *)orderId;
+ (instancetype)AvailableCouponListApi:(NSString *)orderId;
@end

//
//  ALExChangeCouponApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALExChangeCouponApi : ALHttpRequest


/**
 兑换优惠券

 @param cdKey 兑换码
 @return self
 */
- (instancetype)initWithExChangeCouponApi:(NSString *)cdKey;

+ (instancetype)ExChangeCouponApi:(NSString *)cdKey;
@end

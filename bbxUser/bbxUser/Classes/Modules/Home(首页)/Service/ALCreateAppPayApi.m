//
//  ALCreateAppPayApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCreateAppPayApi.h"

@implementation ALCreateAppPayApi {
    NSString *_orderId;
    NSString *_payType;
    NSString *_couponId;
}

- (instancetype)initWithCreateAppPayApi:(NSString *)orderId PayType:(NSString *)payType couponId:(NSString *)couponId {
    if(self = [super init]) {
        _orderId = orderId;
        _payType = payType;
        _couponId = couponId;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_CreateAppPay;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"orderId" : _orderId,
             @"payType" : _payType,
             @"couponId" : _couponId,
             };
}

@end

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
    NSString *_payChannel;
}

- (instancetype)initWithCreateAppPayApi:(NSString *)orderId PayType:(NSString *)payType couponId:(NSString *)couponId payChannel:(NSString *)payChannel {
    if(self = [super init]) {
        _orderId = orderId;
        _payType = payType;
        _couponId = couponId;
        _payChannel = payChannel;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_CreateAppPay;
}

- (id)requestArgument {
    if([_couponId isVaild]) {
        return @{
                 UserID_CommonParams
                 @"orderId" : _orderId,
                 @"payType" : _payType,
                 @"couponId" : _couponId,
                 @"payChannel" : _payChannel,
                 };
    } else {
        return @{
                 UserID_CommonParams
                 @"orderId" : _orderId,
                 @"payType" : _payType,
                 @"payChannel" : _payChannel,
                 };
    }
}

@end

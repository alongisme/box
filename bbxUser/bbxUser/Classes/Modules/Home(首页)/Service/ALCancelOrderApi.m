//
//  ALCancelOrderApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCancelOrderApi.h"

@implementation ALCancelOrderApi {
    NSString *_orderId;
}

- (instancetype)initWithCancelOrderApi:(NSString *)orderId {
    if(self = [super init]) {
        _orderId = orderId;
    }
    return self;
}

+ (instancetype)CancelOrderApi:(NSString *)orderId {
    return [[self alloc] initWithCancelOrderApi:orderId];
}

- (NSString *)requestUrl {
    return URL_CancelOrder;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"orderId" : _orderId,
             };
}

@end

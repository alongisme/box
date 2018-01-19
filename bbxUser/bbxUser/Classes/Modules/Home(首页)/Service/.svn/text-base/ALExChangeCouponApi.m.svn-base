//
//  ALExChangeCouponApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALExChangeCouponApi.h"

@implementation ALExChangeCouponApi {
    NSString *_cdKey;
}

- (instancetype)initWithExChangeCouponApi:(NSString *)cdKey {
    if(self = [super init]) {
        _cdKey = cdKey;
    }
    return self;
}

+ (instancetype)ExChangeCouponApi:(NSString *)cdKey {
    return [[self alloc] initWithExChangeCouponApi:cdKey];
}

- (NSString *)requestUrl {
    return URL_ExchangeCoupon;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"cdKey" : _cdKey,
             };
}

@end

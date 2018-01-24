//
//  ALOrderEstimatedPriceApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALOrderEstimatedPriceApi.h"

@implementation ALOrderEstimatedPriceApi {
    NSString *_securityNum;
    NSString *_serviceLength;
}

- (instancetype)initWithOrderEstimatedPriceApi:(NSString *)securityNum serviceLength:(NSString *)serviceLength {
    if(self = [super init]) {
        _securityNum = securityNum;
        _serviceLength = serviceLength;
    }
    return self;
}

+ (instancetype)OrderEstimatedPriceApi:(NSString *)securityNum serviceLength:(NSString *)serviceLength {
    return [[self alloc] initWithOrderEstimatedPriceApi:securityNum serviceLength:serviceLength];
}

- (NSString *)requestUrl {
    //1.2更改
    return URL_QueryOrderFirstPrice;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"securityNum" : _securityNum,
             @"serviceLength" : _serviceLength,
             };
}
@end

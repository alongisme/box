//
//  ALSubmitOrderApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSubmitOrderApi.h"

@implementation ALSubmitOrderApi {
    NSString *_orderId;
    NSArray *_securityList;
}

- (instancetype)initWithSubmitOrderApi:(NSString *)orderId securityList:(NSArray *)securityList {
    if(self = [super init]) {
        _orderId = orderId;
        _securityList = securityList;
    }
    return self;
}

+ (instancetype)SubmitOrderApi:(NSString *)orderId securityList:(NSArray *)securityList {
    return [[self alloc] initWithSubmitOrderApi:orderId securityList:securityList];
}

- (NSString *)requestUrl {
    return URL_SubmitOrderComment;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"orderId" : _orderId,
             @"securityList" : _securityList,
             };
}

@end

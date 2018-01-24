//
//  ALSencondPayInitApi.m
//  bbxUser
//
//  Created by xlshi on 2018/1/24.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALSencondPayInitApi.h"

@implementation ALSencondPayInitApi {
    NSString *_orderId;
}
- (instancetype)initSencondPayInitApi:(NSString *)orderId {
    if(self = [super init]) {
        _orderId = orderId;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_SencondPayInit;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"orderId" : _orderId,
             };
}

@end

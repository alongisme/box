//
//  ALCompleteMissionApi.m
//  bbxServer
//
//  Created by along on 2017/9/4.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCompleteMissionApi.h"

@implementation ALCompleteMissionApi {
    NSString *_orderId;
}
- (instancetype)initCompleteMissionApi:(NSString *)orderId {
    if(self = [super init]) {
        _orderId = orderId;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_CompleteMission;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"orderId" : _orderId
             };
}

@end

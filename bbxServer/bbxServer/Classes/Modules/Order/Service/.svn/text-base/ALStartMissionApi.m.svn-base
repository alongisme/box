//
//  ALStartMissionApi.m
//  bbxServer
//
//  Created by along on 2017/9/4.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALStartMissionApi.h"

@implementation ALStartMissionApi {
    NSString *_orderId;
}
- (instancetype)initStartMissionApi:(NSString *)orderId {
    if(self = [super init]) {
        _orderId = orderId;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_StartMission;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"orderId" : _orderId
             };
}
@end

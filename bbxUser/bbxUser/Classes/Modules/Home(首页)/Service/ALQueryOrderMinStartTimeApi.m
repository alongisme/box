//
//  ALQueryOrderMinStartTimeApi.m
//  bbxUser
//
//  Created by xlshi on 2017/10/13.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALQueryOrderMinStartTimeApi.h"

@implementation ALQueryOrderMinStartTimeApi {
    NSString *_serviceLength;
}
- (instancetype)initQueryOrderMinStartTimeApi:(NSString *)serviceLength {
    if(self = [super init]) {
        _serviceLength = serviceLength;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_Two_OrderMinStartTime;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"serviceLength" : _serviceLength,
             };
}
@end

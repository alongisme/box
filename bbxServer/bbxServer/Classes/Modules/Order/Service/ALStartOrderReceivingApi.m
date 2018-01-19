//
//  ALStartOrderReceivingApi.m
//  bbxServer
//
//  Created by along on 2017/9/1.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALStartOrderReceivingApi.h"

@implementation ALStartOrderReceivingApi {
    NSString *_isOnline;
}
- (instancetype)initStartOrderReceiving:(NSString *)isOnline {
    if(self = [super init]) {
        _isOnline = isOnline;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_StartOrderReceiving;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"isOnline" : _isOnline,
             };
}
@end

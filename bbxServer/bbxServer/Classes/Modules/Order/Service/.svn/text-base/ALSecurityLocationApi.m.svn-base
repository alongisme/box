//
//  ALSecurityLocationApi.m
//  bbxServer
//
//  Created by along on 2017/9/5.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSecurityLocationApi.h"

@implementation ALSecurityLocationApi {
    NSString *_point;
    NSString *_address;
}

- (instancetype)initSecurityLocation:(NSString *)point address:(NSString *)address {
    if(self = [super init]) {
        _point = point;
        _address = address;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_SecurityLocation;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"point" : _point,
             @"address" : _address,
             };
}
@end

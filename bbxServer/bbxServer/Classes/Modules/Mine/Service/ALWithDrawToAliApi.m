//
//  ALWithDrawToAliApi.m
//  bbxServer
//
//  Created by along on 2017/9/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALWithDrawToAliApi.h"

@implementation ALWithDrawToAliApi
- (instancetype)initWithDrawToAliApi {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_WithdrawToAli;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             };
}
@end

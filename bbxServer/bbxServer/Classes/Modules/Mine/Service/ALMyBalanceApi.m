//
//  ALMyBalanceApi.m
//  bbxServer
//
//  Created by along on 2017/9/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMyBalanceApi.h"

@implementation ALMyBalanceApi
- (instancetype)initMyBalanceApi {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_QueryMyBalance;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             };
}

- (NSString *)balance {
    return self.data[@"balance"];
}
@end

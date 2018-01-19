//
//  ALMyDoingOrderApi.m
//  bbxServer
//
//  Created by along on 2017/8/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMyDoingOrderApi.h"

@implementation ALMyDoingOrderApi
- (instancetype)initMyDoingOrderApi {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_InitMyDoingOrder;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             };
}

- (ALMyDoingOrderModel *)myDoingOrderModel {
    return [[ALMyDoingOrderModel alloc] initWithDictionary:self.data error:nil];
}
@end

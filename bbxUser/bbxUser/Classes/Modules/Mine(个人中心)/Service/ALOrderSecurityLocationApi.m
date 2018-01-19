//
//  ALOrderSecurityLocationApi.m
//  bbxUser
//
//  Created by along on 2017/9/5.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALOrderSecurityLocationApi.h"

@implementation ALOrderSecurityLocationApi {
    NSString *_orderId;
}

- (instancetype)initOrderSecurityLocation:(NSString *)orderId {
    if(self = [super init]) {
        _orderId = orderId;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_OrderSecurityLocation;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"orderId" : _orderId,
             };
}

- (NSArray<ALSecurityLocationModel *> *)poiListArray {
    if(!_poiListArray) {
        NSMutableArray *arr = [NSMutableArray array];
        
        for (NSDictionary *dic in self.data[@"poiList"]) {
            ALSecurityLocationModel *model = [[ALSecurityLocationModel alloc] initWithDictionary:dic error:nil];
            [arr addObject:model];
        }
        _poiListArray = arr;
    }
    return _poiListArray;
}
@end

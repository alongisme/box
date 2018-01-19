//
//  ALAvailableCouponListApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAvailableCouponListApi.h"

@implementation ALAvailableCouponListApi {
    NSString *_orderId;
}

- (instancetype)initWithAvailableCouponListApi:(NSString *)orderId {
    if(self = [super init]) {
        _orderId = orderId;
    }
    return self;
}

+ (instancetype)AvailableCouponListApi:(NSString *)orderId {
    return [[self alloc] initWithAvailableCouponListApi:orderId];
}

- (NSString *)requestUrl {
    return URL_QueryAvailableCouponList;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"orderId" : _orderId,
             };
}

- (NSArray<ALRedEnvelopoModel *> *)couponList {
    if(!_couponList) {
        NSMutableArray<ALRedEnvelopoModel *> *array = [NSMutableArray array];
        
        for (NSDictionary *dic in self.data[@"couponList"]) {
            ALRedEnvelopoModel *model = [[ALRedEnvelopoModel alloc] initWithDictionary:dic error:nil];
            [array addObject:model];
        }
        
        _couponList = array;
    }
    return _couponList;
}
@end

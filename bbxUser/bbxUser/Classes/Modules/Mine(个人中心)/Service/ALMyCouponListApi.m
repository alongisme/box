//
//  ALMyCouponListApi.m
//  bbxUser
//
//  Created by along on 2017/8/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMyCouponListApi.h"

@implementation ALMyCouponListApi

- (instancetype)initWithMyCouponList {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_MyCouponList;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
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

//
//  ALRefreshOrderDetailApi.m
//  bbxUser
//
//  Created by xlshi on 2018/1/23.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALRefreshOrderDetailApi.h"

@implementation ALRefreshOrderDetailApi {
    NSString *_orderId;
}

- (instancetype)initWithRefreshOrderDetailApi:(NSString *)orderId {
    if(self = [super init]) {
        _orderId = orderId;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_RefreshOrderDetail;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"orderId" : _orderId,
             };
}

- (ALOrderModel *)orderModel {
    if(!_orderModel) {
        _orderModel = [[ALOrderModel alloc] initWithDictionary:self.data error:nil];
    }
    return _orderModel;
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

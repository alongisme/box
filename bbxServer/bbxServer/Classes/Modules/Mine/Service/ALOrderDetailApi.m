//
//  ALOrderDetailApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALOrderDetailApi.h"

@implementation ALOrderDetailApi {
    NSString *_orderId;
}

- (instancetype)initWithOrderDetailApi:(NSString *)orderId {
    if(self = [super init]) {
        _orderId = orderId;
    }
    return self;
}

+ (instancetype)OrderDetailApi:(NSString *)orderId {
    return [[self alloc] initWithOrderDetailApi:orderId];
}

- (NSString *)requestUrl {
    return URL_QueryOrderDetail;
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
@end

//
//  ALOrderDetailApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALOrderModel.h"

@interface ALOrderDetailApi : ALHttpRequest

@property (nonatomic, strong) ALOrderModel *orderModel;
/**
 查询订单详情接口

 @param orderId 订单编号
 @return self
 */
- (instancetype)initWithOrderDetailApi:(NSString *)orderId;

+ (instancetype)OrderDetailApi:(NSString *)orderId;
@end

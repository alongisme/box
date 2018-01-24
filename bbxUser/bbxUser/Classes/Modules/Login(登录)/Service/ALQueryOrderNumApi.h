//
//  ALQueryOrderNumApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALQueryOrderNumApi : ALHttpRequest

/**
 查询用户正在进行中的订单数量接口

 @return self
 */
- (instancetype)initWithOrderNumApi;

+ (instancetype)OrderNumApi;
@end

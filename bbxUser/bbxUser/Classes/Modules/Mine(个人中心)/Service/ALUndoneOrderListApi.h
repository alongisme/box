//
//  ALUndoneOrderListApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALUndoneOrderListApi : ALHttpRequest

/**
 查询未完成订单列表接口（分页）
 
 @param nextPage 页数
 @param pageSize 页数大小
 @return self
 */
- (instancetype)initWithUndoneOrderListApi:(NSString *)nextPage pageSize:(NSString *)pageSize;

+ (instancetype)UndoneOrderListApi:(NSString *)nextPage pageSize:(NSString *)pageSize;

@end

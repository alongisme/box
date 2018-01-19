//
//  ALDoneOrderListApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALDoneOrderListApi : ALHttpRequest

/**
 查询已完成订单列表接口（分页）
 
 @param nextPage 页数
 @param pageSize 页数大小
 @return self
 */
- (instancetype)initWithDoneOrderListApi:(NSString *)nextPage pageSize:(NSString *)pageSize;

+ (instancetype)DoneOrderListApi:(NSString *)nextPage pageSize:(NSString *)pageSize;


@end

//
//  ALMyMessageListApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALMyMessageModel.h"

@interface ALMyMessageListApi : ALHttpRequest

@property (nonatomic, strong) ALMyMessageModel *myMessageModel;
/**
 我的消息列表接口（分页）

 @param nextPage 当前页数
 @return self
 */
- (instancetype)initWithMyMessageListApi:(NSString *)nowPage;

+ (instancetype)MyMessageListApi:(NSString *)nowPage;
@end

//
//  ALSecurityCommentListApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALSecurityEvaluateModel.h"

@interface ALSecurityCommentListApi : ALHttpRequest

@property (nonatomic, strong) ALSecurityEvaluateModel *securityEvaluateModel;

/**
 查询保安评价列表

 @param securityId 保安id
 @param nextPage 页数
 @param pageSize 页数大小
 @return self
 */
- (instancetype)initWithSecurityCommentListApi:(NSString *)securityId nowPage:(NSString *)nowPage;

@end

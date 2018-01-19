//
//  ALSecurityInfoApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALSecurityInfoModel.h"

@interface ALSecurityInfoApi : ALHttpRequest

@property (nonatomic, strong) ALSecurityInfoModel *securityInfoModel;

/**
 查询保安详情

 @param securityId 保安id
 @return self
 */
- (instancetype)initWithSecurityInfoApi:(NSString *)securityId;

+ (instancetype)SecurityInfoApi:(NSString *)securityId;

@end

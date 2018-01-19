//
//  ALUpdateMyInfoApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALUpdateMyInfoApi : ALHttpRequest

/**
 修改个人信息

 @param icon 头像
 @param nickName 昵称
 @return self
 */
- (instancetype)initWithUpdateMyInfoApi:(NSString *)icon nickName:(NSString *)nickName;

+ (instancetype)UpdateMyInfoApi:(NSString *)icon nickName:(NSString *)nickName;
@end

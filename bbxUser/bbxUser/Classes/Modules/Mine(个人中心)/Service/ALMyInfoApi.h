//
//  ALMyInfoApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALUserModel.h"

@interface ALMyInfoApi : ALHttpRequest

@property (nonatomic, strong) ALUserInfoModel *userInfoModel;
/**
 初始化我的界面接口

 @return self
 */
- (instancetype)initWithMyInfoApi;

+ (instancetype)MyInfoApi;
@end

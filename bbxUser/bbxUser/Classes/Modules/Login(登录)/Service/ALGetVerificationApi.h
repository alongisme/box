//
//  ALGetVerificationApi.h
//  AnyHelp
//
//  Created by along on 2017/7/26.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALGetVerificationApi : ALHttpRequest
//获取验证码
- (instancetype)initWithGetVerificationApi:(NSString *)mobile;
+ (instancetype)GetVerificationApi:(NSString *)mobile;
@end

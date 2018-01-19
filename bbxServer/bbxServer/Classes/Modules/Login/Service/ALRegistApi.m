//
//  ALRegistApi.m
//  bbxServer
//
//  Created by along on 2017/8/29.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALRegistApi.h"

@implementation ALRegistApi {
    NSString *_phone;
    NSString *_password;
    NSString *_code;
}

- (instancetype)initRegistApi:(NSString *)phone password:(NSString *)password code:(NSString *)code {
    if(self = [super init]) {
        _phone = phone;
        _password = password;
        _code = code;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_Regist;
}

- (id)requestArgument {
    return @{
             @"phone" : _phone,
             @"password" : _password,
             @"messageCode" : _code,
             };
}
@end

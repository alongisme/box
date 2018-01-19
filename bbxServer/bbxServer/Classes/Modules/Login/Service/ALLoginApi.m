//
//  ALLoginApi.m
//  bbxServer
//
//  Created by along on 2017/8/25.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALLoginApi.h"

@implementation ALLoginApi  {
    NSString *_phone;
    NSString *_password;
}
- (instancetype)initLoginApi:(NSString *)phone password:(NSString *)password {
    if(self = [super init]) {
        _phone = phone;
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_UserLogin;
}

- (id)requestArgument {
    return @{
             @"phone" : _phone,
             @"password" : _password,
             };
}

- (ALUserIDModel *)idModel {
    if(!_idModel) {
        _idModel = [[ALUserIDModel alloc] initWithDictionary:self.data error:nil];
    }
    return _idModel;
}

@end

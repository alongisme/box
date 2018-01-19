//
//  ALRestPasswordApi.m
//  bbxServer
//
//  Created by along on 2017/8/30.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALRestPasswordApi.h"

@implementation ALRestPasswordApi {
    NSString *_phone;
    NSString *_newPassword;
    NSString *_code;
}
- (instancetype)initRestPasswordApi:(NSString *)phone newPassword:(NSString *)newPassword code:(NSString *)code {
    if(self = [super init]) {
        _phone = phone;
        _newPassword = newPassword;
        _code = code;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_RestPassword;
}

- (id)requestArgument {
    if([AL_MyAppDelegate.userModel.idModel.userId isVaild]) {
        return @{
                 UserID_CommonParams
                 @"phone" : _phone,
                 @"newPassword" : _newPassword,
                 @"messageCode" : _code,
                 };
    } else {
        return @{
                 @"phone" : _phone,
                 @"newPassword" : _newPassword,
                 @"messageCode" : _code,
                 };
    }
}
@end

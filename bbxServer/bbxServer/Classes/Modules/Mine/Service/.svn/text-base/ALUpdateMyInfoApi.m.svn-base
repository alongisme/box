//
//  ALUpdateMyInfoApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALUpdateMyInfoApi.h"

@implementation ALUpdateMyInfoApi {
    NSString *_icon;
    NSString *_nickName;
    NSDictionary *_argument;
}

- (instancetype)initWithUpdateMyInfoApi:(NSString *)icon nickName:(NSString *)nickName {
    if(self = [super init]) {
        if(icon && nickName) {
            _icon = icon;
            _nickName = nickName;
            
            _argument = @{
                          UserID_CommonParams
                          @"icon" : _icon,
                          @"nickName" : _nickName,
                          };
        } else if(icon == nil && nickName) {
            _nickName = nickName;
            _argument = @{
                          UserID_CommonParams
                          @"nickName" : _nickName,
                          };
        } else if(icon && nickName == nil) {
            _icon = icon;
            
            _argument = @{
                          UserID_CommonParams
                          @"icon" : _icon,
                          };
        }
    }
    return self;
}

+ (instancetype)UpdateMyInfoApi:(NSString *)icon nickName:(NSString *)nickName {
    return [[self alloc] initWithUpdateMyInfoApi:icon nickName:nickName];
}

- (NSString *)requestUrl {
    return URL_UpdateMyInfo;
}

- (id)requestArgument {
    return _argument;
}
@end

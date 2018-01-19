//
//  ALMyInfoApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMyInfoApi.h"

@implementation ALMyInfoApi

- (instancetype)initWithMyInfoApi {
    if(self = [super init]) {

    }
    return self;
}

+ (instancetype)MyInfoApi {
    return [[self alloc] initWithMyInfoApi];
}

- (NSString *)requestUrl {
    return URL_InitMyInfo;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             };
}

- (ALUserInfoModel *)userInfoModel {
    _userInfoModel = [[ALUserInfoModel alloc] initWithDictionary:self.data error:nil];
    return _userInfoModel;
}
@end

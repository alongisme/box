//
//  ALGetVerificationApi.m
//  AnyHelp
//
//  Created by along on 2017/7/26.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALGetVerificationApi.h"

@implementation ALGetVerificationApi {
    NSString *_mobile;
}

- (NSString *)requestUrl {
    return URL_SendMessageCode;
}

- (instancetype)initWithGetVerificationApi:(NSString *)mobile {
    if(self = [super init]) {
        _mobile = mobile;
    }
    return self;
}

+ (instancetype)GetVerificationApi:(NSString *)mobile {
    return [[self alloc] initWithGetVerificationApi:mobile];
}

- (id)requestArgument {
    return @{
             @"phone" : _mobile,
             };
}

@end

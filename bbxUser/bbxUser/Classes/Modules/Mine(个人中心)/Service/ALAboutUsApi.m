//
//  ALAboutUsApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAboutUsApi.h"

@implementation ALAboutUsApi

- (instancetype)initWithAboutUsApi {
    if(self = [super init]) {

    }
    return self;
}

+ (instancetype)AboutUsApi {
    return [[self alloc] initWithAboutUsApi];
}

- (NSString *)requestUrl {
    return URL_InitAboutUsInfo;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             };
}
@end

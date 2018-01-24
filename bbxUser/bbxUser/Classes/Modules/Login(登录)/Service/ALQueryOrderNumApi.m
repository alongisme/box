//
//  ALQueryOrderNumApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALQueryOrderNumApi.h"

@implementation ALQueryOrderNumApi

- (instancetype)initWithOrderNumApi {
    if(self = [super init]) {

    }
    return self;
}

+ (instancetype)OrderNumApi {
    return [[self alloc] initWithOrderNumApi];
}

- (NSString *)requestUrl {
    return URL_QueryLastOrder;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             };
}

@end

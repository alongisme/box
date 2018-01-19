//
//  ALUndoneOrderListApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALUndoneOrderListApi.h"

@implementation ALUndoneOrderListApi {
    NSString *_nextPage;
    NSString *_pageSize;
}

- (instancetype)initWithUndoneOrderListApi:(NSString *)nextPage pageSize:(NSString *)pageSize {
    if(self = [super init]) {
        _nextPage = nextPage;
        _pageSize = pageSize;
    }
    return self;
}

+ (instancetype)UndoneOrderListApi:(NSString *)nextPage pageSize:(NSString *)pageSize {
    return [[self alloc] initWithUndoneOrderListApi:nextPage pageSize:pageSize];
}

- (NSString *)requestUrl {
    return URL_QueryMyUndoneOrderList;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"nextPage" : _nextPage,
             @"pageSize" : _pageSize,
             };
}
@end

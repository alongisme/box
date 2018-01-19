//
//  ALDoneOrderList.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALDoneOrderListApi.h"

@implementation ALDoneOrderListApi {
    NSString *_nextPage;
    NSString *_pageSize;
}

- (instancetype)initWithDoneOrderListApi:(NSString *)nextPage pageSize:(NSString *)pageSize {
    if(self = [super init]) {
        _nextPage = nextPage;
        _pageSize = pageSize;
    }
    return self;
}

+ (instancetype)DoneOrderListApi:(NSString *)nextPage pageSize:(NSString *)pageSize {
    return [[self alloc] initWithDoneOrderListApi:nextPage pageSize:pageSize];
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

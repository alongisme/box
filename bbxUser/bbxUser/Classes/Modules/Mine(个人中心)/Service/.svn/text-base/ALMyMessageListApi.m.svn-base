//
//  ALMyMessageListApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMyMessageListApi.h"

@implementation ALMyMessageListApi {
    NSString *_nowPage;
    NSString *_pageSize;
}

- (instancetype)initWithMyMessageListApi:(NSString *)nowPage {
    if(self = [super init]) {
        _nowPage = nowPage;
    }
    return self;
}

+ (instancetype)MyMessageListApi:(NSString *)nowPage {
    return [[self alloc] initWithMyMessageListApi:nowPage];
}

- (NSString *)requestUrl {
    return URL_QueryMyMessageList;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"nowPage" : _nowPage,
             };
}

- (ALMyMessageModel *)myMessageModel {
    return [[ALMyMessageModel alloc] initWithDictionary:self.data error:nil];
}
@end

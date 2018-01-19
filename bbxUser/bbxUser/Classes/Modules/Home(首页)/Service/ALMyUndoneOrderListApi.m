//
//  ALMyUndoneOrderListApi.m
//  bbxUser
//
//  Created by along on 2017/8/15.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMyUndoneOrderListApi.h"

@implementation ALMyUndoneOrderListApi {
    NSString *_nowPage;
}

- (instancetype)initWithUndoneOrderListApi:(NSString *)nowPage {
    if(self = [super init]) {
        _nowPage = nowPage;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_QueryMyUndoneOrderList;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"nowPage" : _nowPage,
             };
}

- (ALOrderListModel *)orderListModel {
    return [[ALOrderListModel alloc] initWithDictionary:self.data error:nil];
}

@end

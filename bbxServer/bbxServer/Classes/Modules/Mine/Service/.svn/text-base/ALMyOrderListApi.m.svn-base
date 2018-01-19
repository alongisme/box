//
//  ALMyOrderListApi.m
//  bbxServer
//
//  Created by along on 2017/8/29.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMyOrderListApi.h"

@implementation ALMyOrderListApi {
    NSString *_nowPage;
}

- (instancetype)initMyOrderListApi:(NSString *)nowPage {
    if(self = [super init]) {
        _nowPage = nowPage;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_MyOrderList;
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

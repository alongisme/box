//
//  ALMyDoneOrderList.m
//  bbxUser
//
//  Created by along on 2017/8/15.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMyDoneOrderList.h"

@implementation ALMyDoneOrderList {
    NSString *_nowPage;
}

- (instancetype)initWithDoneOrderListApi:(NSString *)nowPage {
    if(self = [super init]) {
        _nowPage = nowPage;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_QueryMyDoneOrderList;
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

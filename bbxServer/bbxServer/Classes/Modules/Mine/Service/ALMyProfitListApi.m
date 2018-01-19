//
//  ALMyProfitListApi.m
//  bbxServer
//
//  Created by along on 2017/9/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMyProfitListApi.h"

@implementation ALMyProfitListApi {
    NSString *_nowPage;
}
- (instancetype)initMyProfitListApi:(NSString *)nowPage {
    if(self = [super init]) {
        _nowPage = nowPage;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_QueryMyProfitList;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"nowPage" : _nowPage,
             };
}

- (ALProfitModel *)profitModel {
    return [[ALProfitModel alloc] initWithDictionary:self.data error:nil];
}
@end

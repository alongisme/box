//
//  ALQueryBannerListApi.m
//  bbxUser
//
//  Created by xlshi on 2017/11/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALQueryBannerListApi.h"

@implementation ALQueryBannerListApi
- (instancetype)initQueryBannerListApi {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_Three_QueryBannerList;
}

- (NSArray<ALBannerListModel *> *)bannerListArray {
    if(!_bannerListArray) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in self.data[@"bannerList"]) {
            ALBannerListModel *model = [[ALBannerListModel alloc] initWithDictionary:dic error:nil];
            [arr addObject:model];
        }
        _bannerListArray = arr;
    }
    return _bannerListArray;
}

@end

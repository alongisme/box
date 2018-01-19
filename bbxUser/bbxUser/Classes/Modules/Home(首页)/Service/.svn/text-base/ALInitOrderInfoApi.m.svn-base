//
//  ALInitOrderInfoApi.m
//  bbxUser
//
//  Created by along on 2017/8/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALInitOrderInfoApi.h"

@implementation ALInitOrderInfoApi
- (instancetype)initOrderInfoApi {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_InitOrderInfo;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             };
}

- (NSArray<ALServiceLengthModel *> *)serviceLengthModelArray {
    NSMutableArray <ALServiceLengthModel *> *arr = [NSMutableArray array];
    for (NSDictionary *dic in self.data[@"serviceLengthList"]) {
        ALServiceLengthModel *model = [[ALServiceLengthModel alloc] initWithDictionary:dic error:nil];
        [arr addObject:model];
    }
    return arr;
}
@end

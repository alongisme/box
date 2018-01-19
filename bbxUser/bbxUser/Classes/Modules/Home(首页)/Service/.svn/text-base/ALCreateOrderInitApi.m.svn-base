//
//  ALCreateOrderInitApi.m
//  bbxUser
//
//  Created by along on 2017/9/20.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCreateOrderInitApi.h"

@implementation ALCreateOrderInitApi
- (instancetype)initCreateOrderInitApi {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_Two_CreateOrderInit;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             };
}

- (NSArray<ALServiceLengthModel *> *)serviceLengthModelArray {
    NSMutableArray <ALServiceLengthModel *> *arr = [NSMutableArray array];
    for (NSDictionary *dic in self.data[@"serviceNumList"]) {
        ALServiceLengthModel *model = [[ALServiceLengthModel alloc] initWithDictionary:dic error:nil];
        [arr addObject:model];
    }
    return arr;
}

- (NSArray<ALCommentTagModel *> *)skillTagListArray {
    NSMutableArray <ALCommentTagModel *> *arr = [NSMutableArray array];
    for (NSDictionary *dic in self.data[@"skillTagList"]) {
        ALCommentTagModel *model = [[ALCommentTagModel alloc] init];
        model.commentTagDes = dic[@"skillTagDes"];
        [arr addObject:model];
    }
    return arr;
}

- (NSArray<ALOptionListModel *> *)optionList {
    NSMutableArray <ALOptionListModel *> *arr = [NSMutableArray array];
    for (NSDictionary *dic in self.data[@"optionList"]) {
        ALOptionListModel *model = [[ALOptionListModel alloc] init];
        model.serviceLength = dic[@"serviceLength"];
        model.limitPrice = dic[@"limitPrice"];
        model.orglPrice = dic[@"orglPrice"];
        [arr addObject:model];
    }
    return arr;
}

- (NSArray *)exRequireList {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *requireDesDic in self.data[@"exRequireList"]) {
        [arr addObject:requireDesDic[@"requireDes"]];
    }
    return arr;
}
@end

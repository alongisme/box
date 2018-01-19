//
//  ALCommentTagApi.m
//  bbxUser
//
//  Created by along on 2017/8/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCommentTagApi.h"

@implementation ALCommentTagApi
- (instancetype)initWithCommentTagApi {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_QueryCommentTag;
}

- (NSArray<ALCommentTagModel *> *)commentTagList {
    if(!_commentTagList) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in self.data[@"commentTagList"]) {
            ALCommentTagModel *model = [[ALCommentTagModel alloc] initWithDictionary:dic error:nil];
            [arr addObject:model];
        }
        _commentTagList = arr;
    }
    return _commentTagList;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             };
}
@end

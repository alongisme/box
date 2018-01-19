//
//  ALSkillTagApi.m
//  bbxServer
//
//  Created by along on 2017/8/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSkillTagApi.h"

@implementation ALSkillTagApi
- (instancetype)initSkillTagApi {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_QuerySkillTag;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             };
}

- (NSArray *)skillTagDesArray {
    if(!_skillTagDesArray) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *desDic in self.data[@"skillTagList"]) {
            [array addObject:desDic[@"skillTagDes"]];
        }
        _skillTagDesArray = array;
    }
    return _skillTagDesArray;
}
@end

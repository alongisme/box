//
//  ALNewDetailApi.m
//  bbxUser
//
//  Created by along on 2017/8/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALNewDetailApi.h"

@implementation ALNewDetailApi {
    NSString *_newsId;
}

- (instancetype)initWithNewDetailApi:(NSString *)newsId {
    if(self = [super init]) {
        _newsId = newsId;
    }
    return self;
}

-(NSString *)requestUrl {
    return URL_QueryNewsDetail;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"newsId" : _newsId,
             };
}
@end

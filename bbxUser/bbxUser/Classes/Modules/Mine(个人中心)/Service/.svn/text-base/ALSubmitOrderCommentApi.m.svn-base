//
//  ALSubmitOrderCommentApi.m
//  bbxUser
//
//  Created by along on 2017/8/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSubmitOrderCommentApi.h"

@implementation ALSubmitOrderCommentApi {
    NSString *_orderId;
    NSString *_commentJson;
}

- (instancetype)initWithSubmitOrderCommentApi:(NSString *)orderId commentJson:(NSString *)commentJson {
    if(self = [super init]) {
        _orderId = orderId;
        _commentJson = commentJson;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_SubmitOrderComment;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"orderId" : _orderId,
             @"commentJson" : _commentJson,
             };
}
@end

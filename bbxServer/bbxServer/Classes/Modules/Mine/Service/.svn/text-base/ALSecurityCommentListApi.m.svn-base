//
//  ALSecurityCommentListApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSecurityCommentListApi.h"

@implementation ALSecurityCommentListApi {
    NSString *_securityId;
    NSString *_nowPage;
}

- (instancetype)initWithSecurityCommentListApi:(NSString *)securityId nowPage:(NSString *)nowPage {
    if(self = [super init]) {
        _securityId = securityId;
        _nowPage = nowPage;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_QuerySecurityCommentList;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"securityId" : _securityId,
             @"nowPage" : _nowPage,
             };
}

- (ALSecurityEvaluateModel *)securityEvaluateModel {
    _securityEvaluateModel = [[ALSecurityEvaluateModel alloc] initWithDictionary:self.data error:nil];
    return _securityEvaluateModel;
}

@end

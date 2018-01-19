//
//  ALSecurityInfoApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSecurityInfoApi.h"

@implementation ALSecurityInfoApi {
    NSString *_securityId;
}

- (instancetype)initWithSecurityInfoApi:(NSString *)securityId {
    if(self = [super init]) {
        _securityId = securityId;
    }
    return self;
}

+ (instancetype)SecurityInfoApi:(NSString *)securityId {
    return [[self alloc] initWithSecurityInfoApi:securityId];
}

- (NSString *)requestUrl {
    return URL_QuerySecurityInfo;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"securityId" : _securityId,
             };
}

- (ALSecurityInfoModel *)securityInfoModel {
    if(!_securityInfoModel) {
        _securityInfoModel = [[ALSecurityInfoModel alloc] initWithDictionary:self.data error:nil];
    }
    return _securityInfoModel;
}

@end

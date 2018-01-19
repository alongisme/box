//
//  ALImproveInforApi.m
//  bbxServer
//
//  Created by along on 2017/8/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALImproveInforApi.h"

@implementation ALImproveInforApi {
    NSString *_readlName;
    NSString *_idNo;
    NSString *_idcardFrontUrl;
    NSString *_idcardBackUrl;
    NSString *_idcardHandUrl;
    NSString *_aliUserId;
    NSString *_skillTag;
    NSString *_iconUrl;
}
- (instancetype)initImproveInforApi:(NSString *)readlName idNo:(NSString *)idNo idcardFrontUrl:(NSString *)idcardFrontUrl idcardBackUrl:(NSString *)idcardBackUrl idcardHandUrl:(NSString *)idcardHandUrl aliUserId:(NSString *)aliUserId skillTag:(NSString *)skillTag iconUrl:(NSString *)iconUrl {
    if(self = [super init]) {
        _readlName = readlName;
        _idNo = idNo;
        _idcardFrontUrl = idcardFrontUrl;
        _idcardBackUrl = idcardBackUrl;
        _idcardHandUrl = idcardHandUrl;
        _aliUserId = aliUserId;
        _skillTag = skillTag;
        _iconUrl = iconUrl;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_ImproveInfor;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"realName" : _readlName,
             @"idNo" : _idNo,
             @"idcardFrontUrl" : _idcardFrontUrl,
             @"idcardBackUrl" : _idcardBackUrl,
             @"idcardHandUrl" : _idcardHandUrl,
             @"aliUserId" : _aliUserId,
             @"skillTag" : _skillTag,
             @"iconUrl" : _iconUrl,
             };
}

@end

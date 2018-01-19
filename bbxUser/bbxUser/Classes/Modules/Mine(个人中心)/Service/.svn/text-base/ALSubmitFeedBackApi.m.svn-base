//
//  ALSubmitFeedBackApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSubmitFeedBackApi.h"

@implementation ALSubmitFeedBackApi {
    NSString *_content;
    NSString *_contactWay;
    NSString *_pickUrls;
}

- (instancetype)initWithSubmitFeedBackApi:(NSString *)content
                               contactWay:(NSString *)contactWay
                                  picUrls:(NSString *)pickUrls {
    if(self = [super init]) {
        _content = content;
        _contactWay = contactWay;
        _pickUrls = pickUrls;
    }
    return self;
}

+ (instancetype)SubmitFeedBackApi:(NSString *)content
                       contactWay:(NSString *)contactWay
                          picUrls:(NSString *)pickUrls {
    return [[self alloc] initWithSubmitFeedBackApi:content contactWay:contactWay picUrls:pickUrls];
}

- (NSString *)requestUrl {
    return URL_SubmitFeedBack;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"content" : _content,
             @"contactWay" : _contactWay,
             @"pickUrls" : _pickUrls,
             };
}
@end

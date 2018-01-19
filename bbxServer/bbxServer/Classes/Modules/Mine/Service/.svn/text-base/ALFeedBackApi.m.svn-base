//
//  ALFeedBackApi.m
//  bbxUser
//
//  Created by along on 2017/8/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALFeedBackApi.h"

@implementation ALFeedBackApi {
    NSString *_content;
    NSString *_contactWay;
    NSString *_picUrls;
}

- (NSString *)requestUrl {
    return URL_SubmitFeedBack;
}

- (instancetype)initWithFeedBackApi:(NSString *)content contactWay:(NSString *)contactWay picUrls:(NSString *)picUrls {
    if(self = [super init]) {
        _content = content;
        _contactWay = contactWay;
        _picUrls = picUrls;
    }
    return self;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"content" : _content,
             @"contactWay" : [_contactWay isVaild] ? _contactWay : @"",
             @"picUrls" : _picUrls,
             };
}
@end

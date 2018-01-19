//
//  ALCheckVerigicationCodeApi.m
//  bbxServer
//
//  Created by along on 2017/8/29.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCheckVerigicationCodeApi.h"

@implementation ALCheckVerigicationCodeApi {
    NSString *_phone;
    NSString *_messageCode;
}

- (instancetype)initWithGetVerificationApi:(NSString *)phone messageCode:(NSString *)messageCode {
    if(self = [super init]) {
        _phone = phone;
        _messageCode = messageCode;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_checkMessageCode;
}

- (id)requestArgument {
    return @{
             @"phone" : _phone,
             @"messageCode" : _messageCode
             };
}
@end

//
//  ALConfirmCustomOrderApi.m
//  bbxUser
//
//  Created by xlshi on 2017/11/9.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALConfirmCustomOrderApi.h"

@implementation ALConfirmCustomOrderApi {
    NSString *_customCode;
}
- (instancetype)initConfirmCustomOrderApi:(NSString *)customCode {
    if(self = [super init]) {
        _customCode = customCode;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_Three_ConfirmCustomOrder;
}

- (id)requestArgument {
    return @{
             UserID_CommonParams
             @"customCode" : _customCode,
             };
}
@end

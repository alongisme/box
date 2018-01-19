//
//  ALQueryBannerInfoApi.m
//  bbxUser
//
//  Created by xlshi on 2017/11/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALQueryBannerInfoApi.h"

@implementation ALQueryBannerInfoApi {
    NSString *_bannerId;
}
- (instancetype)initQueryBannerInfoApi:(NSString *)bannerId {
    if(self = [super init]) {
        _bannerId = bannerId;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_Three_QueryBannerInfo;
}

- (id)requestArgument {
    return @{
             @"bannerId" : _bannerId,
             };
}
@end

//
//  ALCheckVersionApi.m
//  bbxUser
//
//  Created by xlshi on 2018/1/26.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALCheckVersionApi.h"

@implementation ALCheckVersionApi
- (instancetype)initWithCheckVersionApi {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_CheckVersion;
}
@end

//
//  ALQueryBannerInfoApi.h
//  bbxUser
//
//  Created by xlshi on 2017/11/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALQueryBannerInfoApi : ALHttpRequest
- (instancetype)initQueryBannerInfoApi:(NSString *)bannerId;
@end

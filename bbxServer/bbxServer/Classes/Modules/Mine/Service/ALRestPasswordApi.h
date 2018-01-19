//
//  ALRestPasswordApi.h
//  bbxServer
//
//  Created by along on 2017/8/30.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALRestPasswordApi : ALHttpRequest
- (instancetype)initRestPasswordApi:(NSString *)phone newPassword:(NSString *)newPassword code:(NSString *)code;
@end

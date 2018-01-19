//
//  ALRegistApi.h
//  bbxServer
//
//  Created by along on 2017/8/29.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALRegistApi : ALHttpRequest
- (instancetype)initRegistApi:(NSString *)phone password:(NSString *)password code:(NSString *)code;
@end

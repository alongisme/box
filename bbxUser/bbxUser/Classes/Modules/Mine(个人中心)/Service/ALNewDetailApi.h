//
//  ALNewDetailApi.h
//  bbxUser
//
//  Created by along on 2017/8/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALNewDetailApi : ALHttpRequest
- (instancetype)initWithNewDetailApi:(NSString *)newsId;
@end

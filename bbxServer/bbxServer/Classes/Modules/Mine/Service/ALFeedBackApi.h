//
//  ALFeedBackApi.h
//  bbxUser
//
//  Created by along on 2017/8/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALFeedBackApi : ALHttpRequest
- (instancetype)initWithFeedBackApi:(NSString *)content contactWay:(NSString *)contactWay picUrls:(NSString *)picUrls;
@end

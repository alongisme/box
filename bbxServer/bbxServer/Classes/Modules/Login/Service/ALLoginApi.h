//
//  ALLoginApi.h
//  bbxServer
//
//  Created by along on 2017/8/25.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALLoginApi : ALHttpRequest
@property (nonatomic, strong) ALUserIDModel *idModel;
- (instancetype)initLoginApi:(NSString *)phone password:(NSString *)password;
@end

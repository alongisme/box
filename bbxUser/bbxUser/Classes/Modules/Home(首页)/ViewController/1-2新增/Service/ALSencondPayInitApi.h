//
//  ALSencondPayInitApi.h
//  bbxUser
//
//  Created by xlshi on 2018/1/24.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALSencondPayInitApi : ALHttpRequest
- (instancetype)initSencondPayInitApi:(NSString *)orderId;
@end

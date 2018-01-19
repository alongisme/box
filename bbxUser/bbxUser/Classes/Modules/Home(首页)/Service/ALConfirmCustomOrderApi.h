//
//  ALConfirmCustomOrderApi.h
//  bbxUser
//
//  Created by xlshi on 2017/11/9.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALConfirmCustomOrderApi : ALHttpRequest
- (instancetype)initConfirmCustomOrderApi:(NSString *)customCode;
@end

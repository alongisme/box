//
//  ALMyBalanceApi.h
//  bbxServer
//
//  Created by along on 2017/9/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALMyBalanceApi : ALHttpRequest
@property (nonatomic, copy) NSString *balance;
- (instancetype)initMyBalanceApi;
@end

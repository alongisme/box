//
//  ALOrderSecurityLocationApi.h
//  bbxUser
//
//  Created by along on 2017/9/5.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALSecurityLocationModel.h"

@interface ALOrderSecurityLocationApi : ALHttpRequest

@property (nonatomic, strong) NSArray <ALSecurityLocationModel *> *poiListArray;

- (instancetype)initOrderSecurityLocation:(NSString *)orderId;
@end

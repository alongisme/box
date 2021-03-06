//
//  ALRefreshOrderDetailApi.h
//  bbxUser
//
//  Created by xlshi on 2018/1/23.
//  Copyright © 2018年 along. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALOrderModel.h"
#import "ALSecurityLocationModel.h"

@interface ALRefreshOrderDetailApi : ALHttpRequest
@property (nonatomic, strong) NSArray <ALSecurityLocationModel *> *poiListArray;
@property (nonatomic, strong) ALOrderModel *orderModel;
- (instancetype)initWithRefreshOrderDetailApi:(NSString *)orderId;
@end

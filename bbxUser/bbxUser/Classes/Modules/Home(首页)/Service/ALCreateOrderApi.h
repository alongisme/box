//
//  ALOrderInitApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALCreateOrderApi : ALHttpRequest

/**
 订单初始化

 @param serviceAddress 服务地址
 @param contactsPhone 联系人电话
 @param contactsName 联系人姓名
 @param contactsSex 联系人性别
 @param securityNum 服务人数
 @param serviceAddressPoint 服务地址经纬度
 @return self
 */
- (instancetype)initWithCreateOrderApi:(NSString *)serviceAddress
                       contactsPhone:(NSString *)contactsPhone
                        contactsName:(NSString *)contactsName
                         contactsSex:(NSNumber *)contactsSex
                         securityNum:(NSString *)securityNum
                       serviceLength:(NSString *)serviceLength
                   serviceAddressPoint:(NSString *)serviceAddressPoint
                          preStartTime:(NSString *)preStartTime
                          orderMessage:(NSString *)orderMessage;
@end

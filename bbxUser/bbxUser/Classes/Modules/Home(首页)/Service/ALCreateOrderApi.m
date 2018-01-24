//
//  ALCreateOrderApi.m
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCreateOrderApi.h"

@implementation ALCreateOrderApi {
    NSString *_serviceAddress;
    NSString *_contactsPhone;
    NSString *_contactsName;
    NSNumber *_contactsSex;
    NSString *_securityNum;
    NSString *_serviceLength;
    NSString *_serviceAddressPoint;
    NSString *_preStartTime;
    NSString *_orderMessage;
    NSString *_isInsuranced;
}

- (instancetype)initWithCreateOrderApi:(NSString *)serviceAddress
                       contactsPhone:(NSString *)contactsPhone
                        contactsName:(NSString *)contactsName
                         contactsSex:(NSNumber *)contactsSex
                         securityNum:(NSString *)securityNum
                         serviceLength:(NSString *)serviceLength
                   serviceAddressPoint:(NSString *)serviceAddressPoint
                          preStartTime:(NSString *)preStartTime
                          orderMessage:(NSString *)orderMessage
                          isInsuranced:(NSString *)isInsuranced {
    if(self = [super init]) {
        _serviceAddress = serviceAddress;
        _contactsPhone = contactsPhone;
        _contactsName = contactsName;
        _contactsSex = contactsSex;
        _securityNum = securityNum;
        _serviceLength = serviceLength;
        _serviceAddressPoint = serviceAddressPoint;
        _preStartTime = preStartTime;
        _orderMessage = orderMessage;
        _isInsuranced = isInsuranced;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_Two_CreateOrder;
}

- (id)requestArgument {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic addEntriesFromDictionary:@{
                                    UserID_CommonParams
                                    @"serviceAddress" : _serviceAddress,
                                    @"contactsPhone" : _contactsPhone,
                                    @"contactsName" : _contactsName,
                                    @"contactsSex" : _contactsSex,
                                    @"securityNum" : _securityNum,
                                    @"serviceLength" : _serviceLength,
                                    @"serviceAddressPoint" : _serviceAddressPoint,
                                    @"preStartTime" : _preStartTime,
                                    @"isInsuranced" : _isInsuranced,
                                    }];
    
    
    if([_orderMessage isVaild]) {
        [dic setObject:_orderMessage forKey:@"orderMessage"];
    }
    return dic;
}
@end

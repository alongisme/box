//
//  ALOrderModel.h
//  bbxUser
//
//  Created by along on 2017/8/8.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ALSecurityLocationModel
@end

@protocol ALSecurityModel
@end

@interface ALOrderModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *acceptSeconds;
@property (nonatomic, copy) NSString<Optional> *payPrice;
@property (nonatomic, copy) NSString<Optional> *estimatedPrice;
@property (nonatomic, copy) NSString<Optional> *content;
@property (nonatomic, copy) NSString<Optional> *firstPrice;
@property (nonatomic, copy) NSString<Optional> *secondPrice;
@property (nonatomic, copy) NSString<Optional> *orderId;
@property (nonatomic, copy) NSString<Optional> *orderStatus;
@property (nonatomic, strong) NSNumber<Optional> *hasAvaCoupon;
@property (nonatomic, copy) NSString<Optional> *orderType;
@property (nonatomic, copy) NSString<Optional> *orderTypeDes;
@property (nonatomic, copy) NSString<Optional> *orderStatusDes;
@property (nonatomic, copy) NSString<Optional> *applyTime;
@property (nonatomic, copy) NSString<Optional> *preStartTime;
@property (nonatomic, copy) NSString<Optional> *seviceAddress;
@property (nonatomic, copy) NSString<Optional> *orderPrice;
@property (nonatomic, copy) NSString<Optional> *isCommented;
@property (nonatomic, copy) NSString<Optional> *securityNum;
@property (nonatomic, copy) NSNumber<Optional> *expireInterval;
@property (nonatomic, copy) NSString<Optional> *serviceLength;
@property (nonatomic, strong) NSNumber<Optional> *contactsSex;
@property (nonatomic, copy) NSString<Optional> *contactsName;
@property (nonatomic, copy) NSString<Optional> *contactsPhone;
@property (nonatomic, strong) NSArray<Optional,ALSecurityModel> *securityList;
@property (nonatomic, strong) NSArray<Optional,ALSecurityLocationModel> *poiList;
@end

@interface ALSecurityModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *phone;
@property (nonatomic, copy) NSString<Optional> *realName;
@property (nonatomic, copy) NSNumber<Optional> *isLeader;
@property (nonatomic, copy) NSNumber<Optional> *isLeaderDes;
@property (nonatomic, copy) NSString<Optional> *doOrderNum;
@property (nonatomic, copy) NSString<Optional> *securityId;
@property (nonatomic, copy) NSString<Optional> *avgRank;
@property (nonatomic, copy) NSString<Optional> *nickName;
@property (nonatomic, copy) NSString<Optional> *icon;
@end

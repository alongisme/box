//
//  ALMyDoingOrderModel.h
//  bbxServer
//
//  Created by along on 2017/9/1.
//  Copyright © 2017年 along. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ALOrderModel.h"

@interface ALClientInfoModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *clientIcon;
@property (nonatomic, copy) NSString <Optional> *clientNickName;
@property (nonatomic, copy) NSString <Optional> *orderContactPhone;
@end

@interface ALMyDoingOrderModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *isOnline;
@property (nonatomic, copy) NSString <Optional> *authStatus;
@property (nonatomic, copy) NSString <Optional> *authMsg;
@property (nonatomic, copy) NSString <Optional> *hasOrder;
@property (nonatomic, strong) ALOrderModel <Optional> *orderInfo;
@property (nonatomic, strong) ALClientInfoModel <Optional> *clientInfo;
@end


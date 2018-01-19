//
//  ALMyDoingOrderApi.h
//  bbxServer
//
//  Created by along on 2017/8/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALMyDoingOrderModel.h"

@interface ALMyDoingOrderApi : ALHttpRequest
@property (nonatomic, strong) ALMyDoingOrderModel *myDoingOrderModel;
- (instancetype)initMyDoingOrderApi;
@end

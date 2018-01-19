//
//  ALMyOrderListApi.h
//  bbxServer
//
//  Created by along on 2017/8/29.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALOrderListModel.h"

@interface ALMyOrderListApi : ALHttpRequest
@property (nonatomic, strong) ALOrderListModel *orderListModel;
- (instancetype)initMyOrderListApi:(NSString *)nowPage;
@end

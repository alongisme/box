//
//  ALMyDoneOrderList.h
//  bbxUser
//
//  Created by along on 2017/8/15.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALOrderListModel.h"

@interface ALMyDoneOrderList : ALHttpRequest
@property (nonatomic, strong) ALOrderListModel *orderListModel;

- (instancetype)initWithDoneOrderListApi:(NSString *)nowPage;
@end

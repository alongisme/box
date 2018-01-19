//
//  ALOrderListModel.h
//  bbxUser
//
//  Created by along on 2017/8/15.
//  Copyright © 2017年 along. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ALOrderModel.h"

@protocol ALOrderModel
@end

@interface ALOrderListModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *pageSize;
@property (nonatomic, copy) NSString<Optional> *hasNextPage;
@property (nonatomic, copy) NSString<Optional> *size;
@property (nonatomic, copy) NSArray<Optional,ALOrderModel> *orderList;
@end

//
//  ALOrderListTableViewCell.h
//  bbxUser
//
//  Created by along on 2017/8/8.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALOrderModel.h"

@interface ALOrderListTableViewCell : UITableViewCell
//index 1待支付 2评价 3镖师动态
@property (nonatomic, copy) void (^actionBlock)(NSUInteger index);
@end

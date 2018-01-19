//
//  ALPaySuccessViewController.h
//  AnyHelp
//
//  Created by along on 2017/7/26.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"
#import "ALPaySuccessView.h"
#import "ALOrderModel.h"

@protocol ALPaySuccessDelegate <NSObject>

- (void)resetOrderStatusInInfoViewController;

- (void)backToOrderListViewController;

- (void)backMainPageViewController;
@end

@interface ALPaySuccessViewController : ALBaseViewController

@property (nonatomic, assign) BOOL isNewOrder;

@property (nonatomic, strong) ALOrderModel *orderModel;
@property (nonatomic, assign) ALPayType payType;
@property (nonatomic, assign) id<ALPaySuccessDelegate> paySuccessDelegate;
@end

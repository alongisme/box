//
//  ALEvaluateViewController.h
//  bbxUser
//
//  Created by along on 2017/8/8.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"
#import "ALOrderModel.h"

@protocol ALEvaluateDelegate <NSObject>
- (void)EvaluateFinished;
@end

@interface ALEvaluateViewController : ALBaseViewController
@property (nonatomic, weak) id<ALEvaluateDelegate> delegate;
@property (nonatomic, assign) NSUInteger indexPath;
@property (nonatomic, strong) ALOrderModel *orderModel;
@end

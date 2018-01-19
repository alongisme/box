//
//  ALRedEnvelopeViewController.h
//  bbxUser
//
//  Created by along on 2017/8/3.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"
#import "ALRedEnvelopoModel.h"

@protocol ALRedEnvelopeDelegate <NSObject>
- (void)didSelectedWithIndex:(int)index model:(ALRedEnvelopoModel *)model;
@end

@interface ALRedEnvelopeViewController : ALBaseTableViewController
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, weak) id<ALRedEnvelopeDelegate> redEvelopeDelegate;
@end

//
//  ALDynamicsBottomView.h
//  bbxUser
//
//  Created by xlshi on 2018/1/24.
//  Copyright © 2018年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALDynamicsBottomView : UIView
@property (nonatomic, weak) UIButton *waitFinished;
@property (nonatomic, copy) void (^payBlock)();
@property (nonatomic, copy) void (^toEvaluateBlock)();
@property (nonatomic, copy) void (^closeEvaluateBlock)();
- (instancetype)initWithFrame:(CGRect)frame flag:(int)flag expireInterval:(NSNumber *)expireInterval;
- (void)show;
@end

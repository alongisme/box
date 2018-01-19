//
//  ALOrderFinishedView.h
//  bbxServer
//
//  Created by along on 2017/9/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALOrderFinishedView : UIView

@property (nonatomic, copy) void (^removeSuperView)();

- (instancetype)initWithFrame:(CGRect)frame isLeader:(BOOL)isLeader icon:(NSString *)icon length:(NSString *)length money:(NSString *)money;

- (void)show;
- (void)hide;
@end

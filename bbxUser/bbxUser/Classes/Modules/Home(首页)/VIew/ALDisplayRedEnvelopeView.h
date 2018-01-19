//
//  ALDisplayRedEnvelopeView.h
//  bbxUser
//
//  Created by xlshi on 2017/11/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTimeCouponListModel.h"

@interface ALDisplayRedEnvelopeView : UIView
- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array;
- (void)show;
@end

@interface ALDisplayRedEnvelopeCell : UIView
@property (nonatomic, copy) void (^usedButtonClickBlock)(void);
- (instancetype)initWithFrame:(CGRect)frame model:(ALTimeCouponListModel *)model;
@end

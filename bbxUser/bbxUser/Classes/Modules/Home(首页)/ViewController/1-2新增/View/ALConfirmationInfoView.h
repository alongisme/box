//
//  ALConfirmationInfoView.h
//  bbxUser
//
//  Created by xlshi on 2018/1/22.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALShadowView.h"
#import "ALOrderModel.h"

@interface ALConfirmationInfoView : ALShadowView
- (CGFloat)maxSubviewsY;
- (instancetype)initWithFrame:(CGRect)frame orderModel:(ALOrderModel *)model;
@end

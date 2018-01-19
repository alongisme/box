//
//  ALOrderInfoView.h
//  bbxServer
//
//  Created by along on 2017/8/30.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALShadowView.h"
#import "ALOrderModel.h"

@interface ALOrderInfoView : ALShadowView
- (instancetype)initWithFrame:(CGRect)frame model:(ALOrderModel *)model;
- (instancetype)initWithSecurityFrame:(CGRect)frame model:(ALOrderModel *)model;
- (instancetype)initWithShowCallBtnSecurityFrame:(CGRect)frame model:(ALOrderModel *)model;
@end

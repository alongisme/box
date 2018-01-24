//
//  ALNewSecurityLListView.h
//  bbxUser
//
//  Created by xlshi on 2018/1/24.
//  Copyright © 2018年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALOrderModel.h"

@interface ALNewSecurityLListView : ALShadowView
@property (nonatomic, copy) void (^itemDidSelectedAtIndex)(NSUInteger index); //选中哪行
- (instancetype)initWithFrame:(CGRect)frame onlyOne:(ALSecurityModel *)model;
@end

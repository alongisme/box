//
//  ALConfirContentView.h
//  bbxUser
//
//  Created by xlshi on 2018/1/22.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALShadowView.h"

@interface ALConfirContentView : ALShadowView
- (CGFloat)contentHeight;
- (instancetype)initWithFrame:(CGRect)frame content:(NSString *)content;
@end

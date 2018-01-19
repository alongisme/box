//
//  ALHudMessageView.h
//  bbxUser
//
//  Created by xlshi on 2017/11/8.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALHudMessageView : UIView
- (instancetype)initWithFrame:(CGRect)frame message:(NSString *)message;
- (void)show;
@end

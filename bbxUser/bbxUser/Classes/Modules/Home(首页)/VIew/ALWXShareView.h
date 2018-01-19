//
//  ALWXShareView.h
//  bbxUser
//
//  Created by xlshi on 2017/11/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALWXShareView : UIView
//0 微信 1朋友圈
@property (nonatomic, copy) void (^didSelectedIndex)(NSUInteger index);

- (void)show;
@end

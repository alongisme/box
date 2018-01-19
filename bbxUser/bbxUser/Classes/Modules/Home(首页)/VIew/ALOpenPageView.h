//
//  ALOpenPageView.h
//  bbxUser
//
//  Created by xlshi on 2017/12/5.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALOpenPageView : UIView
@property (nonatomic, copy) void (^removeFromWindowBlock)();
- (instancetype)initWithFrame:(CGRect)frame url:(NSString *)url;
- (void)show;
@end

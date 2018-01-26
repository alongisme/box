//
//  ALNewManySecutityListView.h
//  bbxUser
//
//  Created by xlshi on 2018/1/25.
//  Copyright © 2018年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALOrderModel.h"

@interface ALNewManySecutityListView : UIView
- (void)lookManyAction;
@property (nonatomic, copy) void (^loadManySecurityBlock)(int index);
- (instancetype)initWithFrame:(CGRect)frame arr:(NSArray *)arr;
@property (nonatomic, copy) void (^itemDidSelectedAtIndex)(NSUInteger index); 
@end

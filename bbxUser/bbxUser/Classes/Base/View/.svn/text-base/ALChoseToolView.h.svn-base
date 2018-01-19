//
//  ALChoseToolView.h
//  bbxUser
//
//  Created by along on 2017/8/3.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALServiceLengthModel.h"

typedef NS_ENUM(NSUInteger, ALChoseToolType) {
    ALChoseToolTypeServerNumber = 1,
    ALChoseToolTypeServerTime = 2,
    ALChoseToolTypeStartTime = 3,
};

@interface ALChoseToolView : UIView
@property (nonatomic, copy) void (^didDateSelectedBlock)(NSString *string);

@property (nonatomic, copy) void (^didSelectedBlock)(NSUInteger index);

@property (nonatomic, strong) NSArray *dataArray;

- (instancetype)initWithFrame:(CGRect)frame type:(ALChoseToolType)type;

- (void)showBottomView;

- (void)hideBottomView;
@end

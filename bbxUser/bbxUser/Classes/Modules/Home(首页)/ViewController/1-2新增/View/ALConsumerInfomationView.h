//
//  ALConsumerInfomationView.h
//  bbxUser
//
//  Created by xlshi on 2018/1/19.
//  Copyright © 2018年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ALConsumerInfomationDidSelected) {
    ALConsumerInfomationDidSelectedServerNumber = 0,
    ALConsumerInfomationDidSelectedStartTime = 1,
    ALConsumerInfomationDidSelectedContanct = 2,
};

@protocol ALAddressDelegate <NSObject>

- (void)consumerInfomationLineDidSelected:(ALConsumerInfomationDidSelected)type;

@end

@interface ALConsumerInfomationView : ALShadowView
@property (nonatomic, strong) UITextField *serverNumberContentTF;
@property (nonatomic, strong) UITextField *startTimeContentTF;
@property (nonatomic, strong) UITextField *telephoneContenTF;
@property (nonatomic, strong) UITextField *linkManContenTF;
@property (nonatomic, strong) UIButton *manBtn;
@property (nonatomic, strong) UIButton *womanBtn;

@property (nonatomic, weak) id<ALAddressDelegate> delegate;
@end

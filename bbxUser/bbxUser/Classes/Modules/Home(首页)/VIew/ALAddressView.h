//
//  ALAddressView.h
//  AnyHelp
//
//  Created by along on 2017/7/26.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALShadowView.h"

//typedef NS_ENUM(NSInteger, ALAddressDidSelected) {
//    ALAddressDidSelectedLoacation = 0,
//    ALAddressDidSelectedContanct = 1,
//};

//@protocol ALAddressDelegate <NSObject>
//
//- (void)addressLineDidSelected:(ALAddressDidSelected)type;
//
//@end

@interface ALAddressView : ALShadowView
//第一步骤
@property (nonatomic, strong) UITextField *serverAddressContentTF;
@property (nonatomic, strong) UITextField *streeTF;
@property (nonatomic, copy) void (^serverAddressClickBlock)();
//@property (nonatomic, strong) UITextField *telephoneContenTF;
//@property (nonatomic, strong) UITextField *linkManContenTF;
//@property (nonatomic, strong) UIButton *manBtn;
//@property (nonatomic, strong) UIButton *womanBtn;

//@property (nonatomic, weak) id<ALAddressDelegate> delegate;
@end

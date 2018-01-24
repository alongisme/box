//
//  ALPayPresentView.h
//  bbxUser
//
//  Created by xlshi on 2018/1/22.
//  Copyright © 2018年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALOrderModel.h"

@interface ALPayPresentView : UIView
- (instancetype)initWithFrame:(CGRect)frame orderModel:(ALOrderModel *)orderModel first:(BOOL)first dic:(NSDictionary *)dic;
@property (nonatomic, copy) void (^toRedEnv)();
@property (nonatomic, copy) void (^toPayBlock)(ALPayType payType);
@property (nonatomic, assign) ALPayType payType; //支付类型
@property (nonatomic, copy) NSString *disCount; //选中的红包
- (void)show;
- (void)showToViewController:(UIViewController *)viewController;
@end

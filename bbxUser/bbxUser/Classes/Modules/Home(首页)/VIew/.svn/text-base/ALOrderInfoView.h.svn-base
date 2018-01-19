//
//  ALOrderInfoView.h
//  AnyHelp
//
//  Created by along on 2017/7/27.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALShadowView.h"
#import "ALOrderModel.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

typedef NS_ENUM(NSUInteger, ALOrderInfoStyle) {
    ALOrderInfoStyleID = 0, //订单编号
    ALOrderInfoStyleRedEnvelope = 1, //红包
    ALOrderInfoStylePay = 2, //支付
    ALOrderInfoStyleInfo = 3, //信息
    ALOrderInfoStyleSecurity = 4, //镖师
};

@interface ALOrderInfoView : ALShadowView

@property (nonatomic, assign) BOOL isWorking; //是否进行中的状态
@property (nonatomic, strong) NSString *redPrice; //支付减去的红包
@property (nonatomic, copy) NSString *disCount; //选中的红包
@property (nonatomic, assign) ALPayType payType; //支付类型
@property (nonatomic, copy) void (^itemDidSelectedAtIndex)(NSUInteger index); //选中哪行
- (instancetype)initWithFrame:(CGRect)frame style:(ALOrderInfoStyle)style model:(ALOrderModel *)model;
@end

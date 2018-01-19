//
//  CommonMacros.h
//  AnyHelp
//
//  Created by along on 2017/7/21.
//  Copyright © 2017年 along. All rights reserved.
//

#ifndef CommonMacros_h
#define CommonMacros_h

typedef NS_ENUM(NSUInteger,ALPayType) {
    ALPayTypeWeiXinPay = 0,
    ALPayTypeAliPay = 1,
};

#define OrderStautsNew @"N" //新订单
#define OrderStatusWaitPay @"I" //初始状态等待支付
#define OrderStatusTimeOut @"P_C" //交易取消 超时
#define OrderStautsAllocating @"P" //派单中 已支付 等待后台分派保安
#define OrderStatusAllocatingWaitStart @"S" //排单中 已分配 等待保安开始订单
#define OrderStatusWorking @"D" //订单进行中
#define OrderStatusFinished @"E" //订单已完成
#define OrderStatusCancel @"C" //订单已取消

#define UserAuthStatusInit @"O" //初始
#define UserAuthStatusFirst @"F" //一审中
#define UserAuthStatusFirstReject @"R_F" //一审拒绝
#define UserAuthStatusSecond @"S" //二审中
#define UserAuthStatusSecondReject @"R_S" //二审拒绝
#define UserAuthStatusThird @"T" //三审中
#define UserAuthStatusThirdReject @"R_T" //三审拒绝
#define UserAuthStatusSuccess @"P" //已认证


//到登录界面
#define ReSetToLoginModule @"ReSetToLoginModule"
//到首页
#define ReSetToMainPageModule @"ReSetToMainPageModule"
//阿里支付回调
#define AlipayNotification @"AlipayNotification"
//微信支付回调
#define WechatPayNotification @"WechatPayNotification"
//更新我的界面
#define InitUserInfoDataNotification @"InitUserInfoDataNotification"
//改变订单列表状态
#define ChangeListIndexStatus @"ChangeListIndexStatus"
//推送消息处理
#define RemoteNotificationOrderInfo @"RemoteNotificationOrderInfo"

#define UserInfo_Default @"UserInfo_Default"

#endif /* CommonMacros_h */

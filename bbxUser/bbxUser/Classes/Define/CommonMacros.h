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
#define OrderStatusWaitAllocating @"A" //等待派单 //1.2新增
#define OrderStautsAllocating @"P" //派单中 已支付 等待后台分派保安
#define OrderStatusAllocatingWaitStart @"S" //派单中 已分配 等待保安开始订单
#define OrderStatusWorking @"D" //订单进行中
#define OrderStatusFinished @"E" //订单已完成
#define OrderStatusZ @"Z" //余额支付 //1.2新增
#define OrderStatusPS @"P_S" //已支付首款
#define OrderStatusCancel @"C" //订单已取消

#define OrderStautsCustom @"Custom"//个性定制

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
//登录成功
#define UserLoginSuceesssNotification @"UserLoginSuceesssNotification"

//用户信息
#define UserInfo_Default @"UserInfo_Default"

//首次启动
#define UserInfo_FirstLaunch @"UserInfo_FirstLaunch"
#endif /* CommonMacros_h */

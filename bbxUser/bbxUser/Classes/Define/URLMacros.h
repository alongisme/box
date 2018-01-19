//
//  URLMacros.h
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h

#if DEVELOPMENT

//公网测试环境
#define URL_Domain @"http://106.14.169.84/"
//公网测试环境
#define URL_Image @"http://106.14.169.84/file/"
//公网测试环境
#define URL_UpFile @"http://106.14.169.84/mobile/api/system/v1/uploadFile"
//服务器静态资源
#define URL_Resources @"http://106.14.169.84/resources/"

#else

//正式环境
#define URL_Domain @"http://www.biaobiaoxia.com/"
//正式环境
#define URL_Image @"http://www.biaobiaoxia.com/file/"
//正式环境
#define URL_UpFile @"http://www.biaobiaoxia.com/mobile/api/system/v1/uploadFile"
//服务器静态资源
#define URL_Resources @"http://www.biaobiaoxia.com/resources/"

#endif


////测试环境
//#define URL_Domain @"http://192.168.1.8:8080/"
////测试环境图片路径
//#define URL_Image @"http://192.168.1.8:8081/notify-dubbo/upload/"
//测试环境
//#define URL_UpFile @"http://192.168.1.8:8080/mobile/api/system/v1/uploadFile"
//服务器静态资源
//#define URL_Resources @"http://192.168.1.8:8080/resources/"


//通用属性 userid 和 uuid
#define UserID_CommonParams @"userId" : AL_MyAppDelegate.userModel.idModel.userId, \
@"uuid" : AL_MyAppDelegate.userModel.idModel.uuid,

#pragma mark ---------登录接口---------
#pragma mark 用户登录
#define URL_UserLogin @"/mobile/api/client/v1/login"

#pragma mark 获取验证码
#define URL_SendMessageCode @"/mobile/api/system/v1/sendMessageCode"

#pragma mark 查询用户正在进行中的订单数量接口
#define URL_QueryUserDoingOrderNum @"/mobile/api/client/v1/queryMyWaitingOrderNum.sec"

#pragma mark ---------我的模块---------
#pragma mark 初始化我的页面接口
#define URL_InitMyInfo @"/mobile/api/client/v1/initMyInfo.sec"

#pragma mark 初始化关于我们页面接口
#define URL_InitAboutUsInfo @"/initAboutUsInfo.sec"

#pragma mark 提交意见反馈接口
#define URL_SubmitFeedBack @"/mobile/api/client/v1/submitFeedBack.sec"

#pragma mark 我的消息列表接口（分页）
#define URL_QueryMyMessageList @"/mobile/api/client/v1/queryMyNoticeList.sec"

#pragma mark 查询活动详情
#define URL_QueryNewsDetail @"/mobile/api/client/v1/queryNewsDetail.sec"

#pragma mark 更改个人信息接口
#define URL_UpdateMyInfo @"/mobile/api/client/v1/updateMyInfo.sec"

#pragma mark 获取我的可用优惠券列表
#define URL_MyCouponList @"/mobile/api/client/v1/queryMyCouponList.sec"

#pragma mark 查询未完成订单列表接口（分页）
#define URL_QueryMyUndoneOrderList @"/mobile/api/client/v1/queryMyUndoneOrderList.sec"

#pragma mark 查询已完成订单列表接口（分页）
#define URL_QueryMyDoneOrderList @"/mobile/api/client/v1/queryMyDoneOrderList.sec"

#pragma mark 查询订单详情接口
#define URL_QueryOrderDetail @"/mobile/api/client/v1/queryOrderDetail.sec"

#pragma mark 获取订单评价标签
#define URL_QueryCommentTag @"/mobile/api/client/v1/queryCommentTag.sec"

#pragma mark 订单评价接口
#define URL_SubmitOrderComment @"/mobile/api/client/v1/submitOrderComment.sec"

#pragma mark 查询保安详情接口
#define URL_QuerySecurityInfo @"/mobile/api/client/v1/querySecurityInfo.sec"

#pragma mark 查询保安评价列表接口（分页）
#define URL_QuerySecurityCommentList @"/mobile/api/client/v1/querySecurityCommentList.sec"

#pragma mark 查询保安实时位置
#define URL_OrderSecurityLocation @"/mobile/api/client/v1/queryOrderSecurityLocation.sec"

#pragma mark ---------订单流程----------
#pragma mark 查询订单预估价接口
#define URL_QueryOrderEstimatedPrice @"/mobile/api/client/v1/queryOrderEstimatedPrice.sec"

#pragma mark 订单初始化接口
#define URL_CreateOrder @"/mobile/api/client/v1/createOrder.sec"

#pragma mark 创建订单信息初始化
#define URL_InitOrderInfo @"/mobile/api/client/v1/initOrderInfo.sec"

#pragma mark 获取订单可用优惠券列表接口
#define URL_QueryAvailableCouponList @"/mobile/api/client/v1/queryAvailableCouponList.sec"

#pragma mark 兑换优惠券接口
#define URL_ExchangeCoupon @"/mobile/api/client/v1/exchangeCoupon.sec"

#pragma mark 创建订单支付接口
#define URL_CreateAppPay @"/mobile/api/client/v1/createAppPay.sec"

#pragma mark 取消订单接口
#define URL_CancelOrder @"/mobile/api/client/v1/cancelOrder.sec"

#pragma mark 订单创建初始化接口
#define URL_CreateOrderInit @"/mobile/api/client/v1/createOrderInit.sec"

//增加
#pragma 订单创建初始化接口
#define URL_Two_CreateOrderInit @"/mobile/api/client/v1-1/createOrderInit.sec"

#pragma 获取最小时间接口
#define URL_Two_OrderMinStartTime @"/mobile/api/client/v1-1/queryOrderMinStartTime.sec"

#pragma 查询预估价接口
#define URL_Two_OrderEstimatedPrice @"/mobile/api/client/v1-1/queryOrderEstimatedPrice.sec"

#pragma 创建订单接口
#define URL_Two_CreateOrder @"/mobile/api/client/v1-1/createOrder.sec"

//增加
#pragma 个性定制确认
#define URL_Three_ConfirmCustomOrder @"/mobile/api/client/v1-1/confirmCustomOrder.sec"

#pragma 查询首页轮播图
#define URL_Three_QueryBannerList @"/mobile/api/client/v1/queryBannerList"
#pragma 查询轮播图详情
#define URL_Three_QueryBannerInfo @"/mobile/api/client/v1/queryBannerInfo"

//增加
#pragma 获取限时红包接口
#define URL_Four_GetTimelimitCoupon @"/mobile/api/client/v1/getTimelimitCoupon.sec"

//增加
#pragma 查询openpage接口
#define URL_Five_QueryOpenPage @"/mobile/api/client/v1/queryOpenPage"

#endif /* URLMacros_h */

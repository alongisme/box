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

//公网环境
#define URL_Domain @"http://106.14.169.84/"
//公网环境
#define URL_Image @"http://106.14.169.84/file/"
//公网环境
#define URL_UpFile @"http://106.14.169.84/mobile/api/system/v1/uploadFile"

#else

//正式环境
#define URL_Domain @"http://101.132.117.76/"
//正式环境
#define URL_Image @"http://101.132.117.76/file/"
//正式环境
#define URL_UpFile @"http://101.132.117.76/mobile/api/system/v1/uploadFile"

#endif

////测试环境
//#define URL_Domain @"http://192.168.1.8:8080/"
////测试环境图片路径
//#define URL_Image @"http://192.168.1.8:8081/notify-dubbo/upload/"
//测试环境
//#define URL_UpFile @"http://192.168.1.8:8080/mobile/api/system/v1/uploadFile"


#define UserID_CommonParams @"userId" : AL_MyAppDelegate.userModel.idModel.userId, \
@"uuid" : AL_MyAppDelegate.userModel.idModel.uuid,

#pragma mark ---------登录接口---------
#pragma mark 用户登录
#define URL_UserLogin @"/mobile/api/security/v1/login"

#pragma mark 用户注册
#define URL_Regist @"/mobile/api/security/v1/registerSecurity"

#pragma mark 重置密码接口
#define URL_RestPassword @"/mobile/api/security/v1/resetPassword";

#pragma mark 获取验证码
#define URL_SendMessageCode @"/mobile/api/system/v1/sendMessageCode"

#pragma mark 校验验证码
#define URL_checkMessageCode @"/mobile/api/system/v1/checkMessageCode"

#pragma mark ---------我的模块---------
#pragma mark 初始化我的页面接口
#define URL_InitMyInfo @"/mobile/api/security/v1/initMyInfo.sec"

#pragma mark 我的订单列表
#define URL_MyOrderList @"/mobile/api/security/v1/queryMyOrderList.sec"

#pragma mark 提交意见反馈接口
#define URL_SubmitFeedBack @"/mobile/api/security/v1/submitFeedBack.sec"

#pragma mark 我的消息列表接口（分页）
#define URL_QueryMyMessageList @"/mobile/api/security/v1/queryMyNoticeList.sec"

#pragma mark 查询活动详情
#define URL_QueryNewsDetail @"/mobile/api/security/v1/queryNewsDetail.sec"

#pragma mark 更改个人信息接口
#define URL_UpdateMyInfo @"/mobile/api/security/v1/updateMyInfo.sec"

#pragma mark 查询订单详情接口
#define URL_QueryOrderDetail @"/mobile/api/security/v1/queryOrderDetail.sec"

#pragma mark 获取订单评价标签
#define URL_QueryCommentTag @"/mobile/api/security/v1/queryCommentTag.sec"

#pragma mark 订单评价接口
#define URL_SubmitOrderComment @"/mobile/api/security/v1/submitOrderComment.sec"

#pragma mark 查询保安详情接口
#define URL_QuerySecurityInfo @"/mobile/api/security/v1/querySecurityInfo.sec"

#pragma mark 查询保安评价列表接口（分页）
#define URL_QuerySecurityCommentList @"/mobile/api/security/v1/querySecurityCommentList.sec"

#pragma mark 查询收益列表(分页)
#define URL_QueryMyProfitList @"/mobile/api/security/v1/queryMyProfitList"

#pragma mark 查询我的余额
#define URL_QueryMyBalance @"/mobile/api/security/v1/queryMyBalance"

#pragma mark 提现
#define URL_WithdrawToAli @"/mobile/api/security/v1/withdrawToAli"

#pragma mark ---------订单流程----------
#pragma mark 初始化订单界面接口
#define URL_InitMyDoingOrder @"/mobile/api/security/v1/initMyDoingOrder.sec"

#pragma mark 查询保安服务标签
#define URL_QuerySkillTag @"/mobile/api/security/v1/querySkillTag.sec"

#pragma mark 获取阿里授权string
#define URL_CreateAliLogin @"/mobile/api/security/v1/createAliLogin.sec"

#pragma mark 提交材料接口
#define URL_ImproveInfor @"/mobile/api/security/v1/improveInfor.sec"

#pragma mark 开始接单接口
#define URL_StartOrderReceiving @"/mobile/api/security/v1/startOrderReceiving.sec"

#pragma mark 开始任务接口
#define URL_StartMission @"/mobile/api/security/v1/startMission.sec"

#pragma mark 结束任务接口
#define URL_CompleteMission @"/mobile/api/security/v1/completeMission.sec"

#pragma mark 更新保安位置
#define URL_SecurityLocation @"/mobile/api/security/v1/refreshSecurityLocation.sec"

#endif /* URLMacros_h */

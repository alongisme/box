//
//  ALLoginApi.h
//  AnyHelp
//
//  Created by along on 2017/7/19.
//  Copyright © 2017年 along. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "ALUserModel.h"

//typedef NS_ENUM(NSInteger, ALUserLoginType){
//    ALUserLoginTypeUnKnow = 0,//未知
//    ALUserLoginTypeWeChat,//微信登录
//    ALUserLoginTypeQQ,///QQ登录
//    ALUserLoginTypeSina,//新浪微博登录
//};

@interface ALLoginApi : ALHttpRequest
//用户信息模型
@property (nonatomic, strong) ALUserIDModel *idModel;
//验证码登录
- (instancetype)initWithLoginApi:(NSString *)account code:(NSString *)code;
+ (instancetype)LoginApi:(NSString *)account code:(NSString *)code;
////QQ登录
//- (void)initWithQQLogin:(void (^)(NSDictionary *info))completion;
//+ (void)QQLogin:(void (^)(NSDictionary *info))completion;
////微信登录
//- (void)initWithWeChat:(void (^)(NSDictionary *info))completion;
//+ (void)WeChatLogin:(void (^)(NSDictionary *info))completion;
////新浪微博登录
//- (void)initWithSina:(void (^)(NSDictionary *info))completion;
//+ (void)SinaLogin:(void (^)(NSDictionary *info))completion;
@end

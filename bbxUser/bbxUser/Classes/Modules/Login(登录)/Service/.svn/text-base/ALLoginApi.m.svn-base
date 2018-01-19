//
//  ALLoginApi.m
//  AnyHelp
//
//  Created by along on 2017/7/19.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALLoginApi.h"

@implementation ALLoginApi {
    NSString *_account;
    NSString *_code;
}

#pragma mark Api Option
- (instancetype)initWithLoginApi:(NSString *)account code:(NSString *)code {
    if(self = [super init]) {
        _account = account;
        _code = code;
    }
    return self;
}

+ (instancetype)LoginApi:(NSString *)account code:(NSString *)code {
    return [[self alloc] initWithLoginApi:account code:code];
}

- (NSString *)requestUrl {
    return URL_UserLogin;
}

- (id)requestArgument {
    return @{
             @"phone" : _account,
             @"messageCode" : _code,
             };
}

#pragma mark User Model
- (ALUserIDModel *)idModel {
    if(!_idModel) {
        _idModel = [[ALUserIDModel alloc] initWithDictionary:self.data error:nil];
    }
    return _idModel;
}

#pragma mark ThirdParty Login
/*
- (void)initWithQQLogin:(void (^)(NSDictionary *info))completion {
    [self thirdPartyLoginWithType:UMSocialPlatformType_QQ Completion:^(id result) {
//        UMSocialUserInfoResponse *resp = result;
    }];
}

+ (void)QQLogin:(void (^)(NSDictionary *info))completion {
    [[self alloc] initWithQQLogin:completion];
}

- (void)initWithWeChat:(void (^)(NSDictionary *info))completion {
    [self thirdPartyLoginWithType:UMSocialPlatformType_WechatSession Completion:^(id result) {
//        UMSocialUserInfoResponse *resp = result;
    }];
}

+ (void)WeChatLogin:(void (^)(NSDictionary *info))completion {
    [[self alloc] initWithWeChat:completion];
}

- (void)initWithSina:(void (^)(NSDictionary *info))completion {
    [self thirdPartyLoginWithType:UMSocialPlatformType_Sina Completion:^(id result) {
//        UMSocialUserInfoResponse *resp = result;
    }];
}

+ (void)SinaLogin:(void (^)(NSDictionary *info))completion {
    [[self alloc] initWithSina:completion];
}

- (void)thirdPartyLoginWithType:(UMSocialPlatformType)type Completion:(void (^)(id result))completion {
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:nil completion:^(id result, NSError *error) {
        if(error) {
            [ALKeyWindow showHudError:error.localizedDescription];
        } else {
            if(completion) {
                completion(result);
            }
        }
    }];
}
*/


@end

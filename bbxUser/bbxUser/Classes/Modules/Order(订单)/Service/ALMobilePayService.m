//
//  ALMobilePayService.m
//  MobilePayDemo-master
//
//  Created by along on 2017/7/24.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import "ALMobilePayService.h"
#import "Order.h"
#import "WechatPayManager.h"
#import "RSADataSigner.h"

@implementation ALMobilePayService

static ALMobilePayService *_instance = nil;

+ (ALMobilePayService *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)alipayWithOrderString:(NSString *)orderString {
    AL_WeakSelf(self);
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:AliPayScheme callback:^(NSDictionary *resultDic) {
        NSUInteger resutltStatus = [resultDic[@"resultStatus"] integerValue];
        [weakSelf aliPayOrderStatus:resutltStatus];
    }];
}

- (void)aliPayOrderStatus:(NSUInteger)stauts {
    switch (stauts) {
        case 9000: {
            if (_PayCompltedHandleBlock) {
                _PayCompltedHandleBlock(ALPayHandleSuceess);
            }
//            [ALKeyWindow showHudSuccess:@"支付成功～"];
        }
            break;
        case 6001: {
            if (_PayCompltedHandleBlock ){
                _PayCompltedHandleBlock(ALPayHandleCancel);
                
            }
//            [ALKeyWindow showHudSuccess:@"用户中途取消～"];
            break;
        }
        case 8000: {
            if (_PayCompltedHandleBlock) {
                _PayCompltedHandleBlock(ALPayHandleFailed);
            }
            [ALKeyWindow showHudSuccess:@"正在处理～"];
        }
            break;
        case 4000: {
            if (_PayCompltedHandleBlock) {
                _PayCompltedHandleBlock(ALPayHandleFailed);
            }
            [ALKeyWindow showHudSuccess:@"支付失败～"];
        }
            break;
        case 6002: {
            if (_PayCompltedHandleBlock) {
                _PayCompltedHandleBlock(ALPayHandleFailed);
            }
            [ALKeyWindow showHudSuccess:@"网络连接出错～"];
        }
            break;
        case 6004: {
            if (_PayCompltedHandleBlock) {
                _PayCompltedHandleBlock(ALPayHandleFailed);
            }
            [ALKeyWindow showHudSuccess:@"支付结果未知～"];
        }
            break;
        default: {
            if (_PayCompltedHandleBlock) {
                _PayCompltedHandleBlock(ALPayHandleFailed);
            }
            [ALKeyWindow showHudSuccess:@"其他错误～"];
        }
            break;
    }

}

- (void)wechatOayOrderString:(NSString *)orderString {
    AL_MyAppDelegate.normalClickToBackApp = NO;
    NSData *data = [orderString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *params = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = [params objectForKey:@"appid"];  //微信开放平台审核通过的应用APPID
    req.partnerId          = [params objectForKey:@"partnerid"]; //微信支付分配的商户号
    req.prepayId            = [params objectForKey:@"prepayid"]; //微信返回的支付交易会话ID
    req.nonceStr            = [params objectForKey:@"noncestr"]; //随机字符串，不长于32位。推荐
    req.timeStamp          =  [[params objectForKey:@"timestamp"] intValue];   //时间戳
    req.package            =   @"Sign=WXPay"; //[dataDict objectForKey:@"package"];// Sign=WXPay
    req.sign                = [params objectForKey:@"sign"]; // 签名
    
    [WXApi sendReq:req];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wechatPayHandle:) name:WechatPayNotification object:nil];
}

//微信支付通知
- (void)wechatPayHandle:(NSNotification *)notification
{
    
    if ([notification.object isEqualToString:@"WXErrCodeUserCancel"]) {
//        [ALKeyWindow showHudError:@"用户中途取消～"];
        if (_PayCompltedHandleBlock ){
            _PayCompltedHandleBlock(ALPayHandleCancel);
            
        }
    } else if ([notification.object isEqualToString:@"WXSuccess"]) {
//        [ALKeyWindow showHudSuccess:@"支付成功～"];
        if (_PayCompltedHandleBlock) {
            _PayCompltedHandleBlock(ALPayHandleSuceess);
        }
        
    } else {
        [ALKeyWindow showHudSuccess:@"支付失败～"];
        if (_PayCompltedHandleBlock) {
            _PayCompltedHandleBlock(ALPayHandleFailed);
        }
    }
    
}
//支付宝回掉通知

- (void)AliPayHandle:(NSNotification *)notification{
    
    NSLog(@"notification.userInfo==%@",notification.userInfo);
    
    NSInteger orderState = [notification.userInfo[@"resultStatus"] integerValue];
    if (orderState == 9000) {
        if (_PayCompltedHandleBlock) {
            _PayCompltedHandleBlock(ALPayHandleSuceess);
        }
    }else if (orderState == 6001)
    {
        if (_PayCompltedHandleBlock ){
            _PayCompltedHandleBlock(ALPayHandleCancel);
            
        }
    }else{
        if (_PayCompltedHandleBlock) {
            _PayCompltedHandleBlock(ALPayHandleFailed);
        }
        
    }
    
    
}

- (void)showErrorMessage:(NSString *)message{
//    UIAlertView  * alert  = [[UIAlertView alloc]initWithTitle:@"错误提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    [alert show];
    NSLog(@"%@",message);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end

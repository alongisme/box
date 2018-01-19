//
//  ALAppDelegate+ALJPush.h
//  bbxUser
//
//  Created by along on 2017/8/18.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAppDelegate.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface ALAppDelegate (ALJPush) <JPUSHRegisterDelegate>
- (void)registJPushServerWithOptions:(NSDictionary *)launchOptions;
@end

//
//  ALUtilsMacros.h
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//

#ifndef ALUtilsMacros_h
#define ALUtilsMacros_h

#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

//DeBug
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s %d Line \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

//AppDelegate
#define AL_MyAppDelegate ((ALAppDelegate *)[UIApplication sharedApplication].delegate)

//KeyWindow
#define ALKeyWindow [UIApplication sharedApplication].keyWindow

//ScreenBounds
#define ALScreenBounds [UIScreen mainScreen].bounds
#define ALScreenWidth [UIScreen mainScreen].bounds.size.width
#define ALScreenHeight [UIScreen mainScreen].bounds.size.height

#define AL_WeakSelf(obj) __weak typeof(obj) weakSelf = obj;


//设置随机颜色
#define AL_RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f]
//设置颜色
#define AL_SetColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

//版本号
#define ALAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//拼接字符串
#define ALStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//导航栏默认高度
#define ALNavigationBarHeight (ALScreenHeight == 812 ? 88.0f : 64.0f)

//tabbar默认高度
#define ALTabBarHeight 0.0f

#endif /* ALUtilsMacros_h */

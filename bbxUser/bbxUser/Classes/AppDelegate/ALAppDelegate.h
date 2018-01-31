//
//  ALAppDelegate.h
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//
#import <AFNetworkReachabilityManager.h>

typedef NS_ENUM(NSInteger,ALBackToApp_Pay_Type) {
    ALBackToApp_Pay_Type_NONE = 0,
    ALBackToApp_Pay_Type_WX = 1,
    ALBackToApp_Pay_Type_ALI = 2,
};

@interface ALAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) ALUserModel *userModel;

@property (nonatomic, strong) BMKPoiInfo *poiInfoModel;

@property (nonatomic, assign) ALBackToApp_Pay_Type backPayType;
@property (nonatomic, assign) BOOL normalClickToBackApp;

@property (nonatomic, assign) AFNetworkReachabilityStatus netWorkstatus;
@end

//
//  ALAccountInfoView.h
//  AnyHelp
//
//  Created by along on 2017/7/25.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALAccountInfoView : ALShadowView
@property (nonatomic, copy) NSString *accountString;
@property (nonatomic, copy) NSString *codeString;
@property (nonatomic, copy) NSString *pwdString;
@property (nonatomic, assign) BOOL loginEnable;
@property (nonatomic, assign) BOOL changePwd;
@end

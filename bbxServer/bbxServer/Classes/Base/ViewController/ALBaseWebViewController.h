//
//  ALBaseWebViewController.h
//  bbxUser
//
//  Created by xlshi on 2017/11/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"
#import <WebKit/WebKit.h>

@interface ALBaseWebViewController : ALBaseViewController
@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, copy) NSString *requestUrl;
@end

//
//  ALProtocolViewController.m
//  bbxUser
//
//  Created by along on 2017/9/6.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALProtocolViewController.h"
@import WebKit;

@interface ALProtocolViewController ()
@property (nonatomic, strong) WKWebView *wkWebView;
@end

@implementation ALProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用户协议";

    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
    
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.wkWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:ALStringFormat(@"%@/resources/protocol/bbx-server-protocol.html",URL_Domain)]]];
}

#pragma mark lazy laod
- (WKWebView *)wkWebView {
    if(!_wkWebView) {
        _wkWebView = [[WKWebView alloc] init];
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}

@end

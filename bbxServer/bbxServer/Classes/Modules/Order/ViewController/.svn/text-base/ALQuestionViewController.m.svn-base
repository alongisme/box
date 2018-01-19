//
//  ALQuestionViewController.m
//  bbxServer
//
//  Created by along on 2017/9/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALQuestionViewController.h"
@import WebKit;

@interface ALQuestionViewController ()
@property (nonatomic, strong) WKWebView *wkWebView;
@end

@implementation ALQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"角色介绍";
    
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
    
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
#pragma mark 所有协议换地址
    [self.wkWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:ALStringFormat(@"%@/resources/protocol/character-document.html",URL_Domain)]]];
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

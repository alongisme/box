//
//  ALBaseWebViewController.m
//  bbxUser
//
//  Created by xlshi on 2017/11/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseWebViewController.h"

@interface ALBaseWebViewController ()
@end

@implementation ALBaseWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ((ALBaseNavigationController *)self.navigationController).customNavigationView.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
    
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(ALNavigationBarHeight, 0, 0, 0));
    }];
    
    if([self.requestUrl isVaild])
        [self.wkWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:ALStringFormat(@"%@",self.requestUrl)]]];

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

//
//  ALNewsDetailViewController.m
//  bbxUser
//
//  Created by along on 2017/8/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALNewsDetailViewController.h"
#import "ALNewDetailApi.h"
@import WebKit;

@interface ALNewsDetailViewController () 
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) ALNewDetailApi *neDetailApi;
@end

@implementation ALNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    [self loadData];
}

- (void)loadData {
    AL_WeakSelf(self);
    _neDetailApi = [[ALNewDetailApi alloc] initWithNewDetailApi:_newsId];
    [_neDetailApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [weakSelf.wkWebView loadHTMLString:weakSelf.neDetailApi.data[@"html"] baseURL:nil];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [ALKeyWindow showHudError:@"获取消息失败～"];
    }];
}

#pragma mark lazy load
- (WKWebView *)wkWebView {
    if(!_wkWebView) {
        _wkWebView = [[WKWebView alloc] init];
        [self.view addSubview:_wkWebView];
        
        [_wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
        }];
    }
    return _wkWebView;
}
@end

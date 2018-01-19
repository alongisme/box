//
//  ALBannerViewController.m
//  bbxUser
//
//  Created by xlshi on 2017/11/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBannerViewController.h"
#import "ALQueryBannerInfoApi.h"
#import "ALWXShareView.h"
#import "WXApiManager.h"

@interface ALBannerViewController () <WKNavigationDelegate>
@property (nonatomic, strong) ALWXShareView *wxshareView;
@property (nonatomic, strong) ALQueryBannerInfoApi *queryBannerInfoApi;
@end

@implementation ALBannerViewController

- (NSString*)decodeString:(NSString*)encodedString {
    NSString *decodedString = (__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault,(CFStringRef)encodedString,(CFStringRef)@"");
    return decodedString;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *protocolUrl = navigationAction.request.URL.absoluteString;
    if([protocolUrl isEqualToString:@"bbx://back"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if([protocolUrl containsString:@"bbx://share"]) {
        
        if(AL_MyAppDelegate.userModel.idModel.userId) {
            protocolUrl = (__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault,(CFStringRef)protocolUrl,(CFStringRef)@"");
            NSString *fromatUrl = [protocolUrl stringByReplacingOccurrencesOfString:@"bbx://share?" withString:@""];
            NSArray *parametersArr = [fromatUrl componentsSeparatedByString:@"&"];
            
            NSString *icon = @"";
            NSString *title = @"";
            NSString *content = @"";
            NSString *link = @"";
            
            if(parametersArr.count == 4) {
                if([parametersArr[0] isVaild] && [parametersArr[0] isKindOfClass:[NSString class]]) {
                    NSString *paraOne = parametersArr[0];
                    icon = [paraOne stringByReplacingOccurrencesOfString:@"icon=" withString:@""];
                }
                if([parametersArr[1] isVaild] && [parametersArr[1] isKindOfClass:[NSString class]]) {
                    NSString *paraTwo = parametersArr[1];
                    title = [paraTwo stringByReplacingOccurrencesOfString:@"title=" withString:@""];
                }
                if([parametersArr[2] isVaild] && [parametersArr[2] isKindOfClass:[NSString class]]) {
                    NSString *paraThree = parametersArr[2];
                    content = [paraThree stringByReplacingOccurrencesOfString:@"content=" withString:@""];
                }
                if([parametersArr[3] isVaild] && [parametersArr[3] isKindOfClass:[NSString class]]) {
                    NSString *paraFour = parametersArr[3];
                    link = [paraFour stringByReplacingOccurrencesOfString:@"link=" withString:@""];
                    link = [link stringByAppendingString:ALStringFormat(@"?userId=%@",AL_MyAppDelegate.userModel.idModel.userId)];
                }
            }
            
            ALWXShareView *shareView = [[ALWXShareView alloc] initWithFrame:CGRectZero];
            [shareView show];
            
            shareView.didSelectedIndex = ^(NSUInteger index) {
                if(index == 0) {
                    [[WXApiManager shareInstance] shareRedEnvelope:title content:content icon:icon link:link scene:WXSceneTimeline];
                } else {
                    [[WXApiManager shareInstance] shareRedEnvelope:title content:content icon:icon link:link scene:WXSceneSession];
                }
            };
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:ReSetToLoginModule object:nil];
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    ((ALBaseNavigationController *)self.navigationController).customNavigationView.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
    if(![_bannerId isVaild]) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(![_bannerId isVaild]) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        self.wkWebView.navigationDelegate = self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    AL_WeakSelf(self);
    if([_bannerId isVaild]) {
        _queryBannerInfoApi = [[ALQueryBannerInfoApi alloc] initQueryBannerInfoApi:_bannerId];
        [_queryBannerInfoApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf.wkWebView loadHTMLString:weakSelf.queryBannerInfoApi.data[@"bannerHtml"] baseURL:nil];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    } else {
        self.wkWebView.navigationDelegate = self;
        self.wkWebView.scrollView.bounces = NO;
        
        [self.wkWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(-20, 0, 0, 0));
        }];
    }
    
    //清楚缓存
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
}

- (void)dealloc {
    [_queryBannerInfoApi stop];
    _queryBannerInfoApi = nil;
}

@end

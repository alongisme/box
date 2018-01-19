//5
//  ALCustomizationViewController.m
//  bbxUser
//
//  Created by xlshi on 2017/11/6.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCustomizationViewController.h"
#import "ALHudMessageView.h"
#import "ALConfirmCustomOrderApi.h"
#import "ALOrderInfoViewController.h"
@import WebKit;

@interface ALCustomizationViewController ()
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) ALLabel *msgLab;
@property (nonatomic, strong) UIButton *telephoneBtn;
@property (nonatomic, strong) UIImageView *serviceProcessIV;
@property (nonatomic, weak) UITextField *customCodeTF;
@property (nonatomic, strong) ALConfirmCustomOrderApi *confirmCustomOrderApi;
@end

@implementation ALCustomizationViewController

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.customCodeTF.text = @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
    
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ALStringFormat(@"%@/pages/custom-order-direction.html",URL_Resources)]]];
}

- (void)initSubviews {
    
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(ALNavigationBarHeight + 42);
        make.bottom.equalTo(@0);
    }];

    [self.telephoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-16);
        make.bottom.equalTo(@-75);
    }];
    
    UIButton *tijiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tijiaoBtn setBackgroundImage:[UIImage imageNamed:@"tijiao"] forState:UIControlStateNormal];
    [tijiaoBtn addTarget:self action:@selector(tijiaoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tijiaoBtn];
    tijiaoBtn.adjustsImageWhenHighlighted = NO;
    tijiaoBtn.highlighted = NO;
    
    [tijiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@0);
    }];
    
    UIView *customCodeView = [[UIView alloc] init];
    customCodeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customCodeView];
    
    UITextField *customCodeTF = [[UITextField alloc] init];
    customCodeTF.font = ALThemeFont(16);
    customCodeTF.placeholder = @"请输入定制码";
    [customCodeView addSubview:customCodeTF];
    self.customCodeTF = customCodeTF;
    
    [customCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(@0);
        make.height.equalTo(tijiaoBtn);
        make.right.equalTo(tijiaoBtn.mas_left);
    }];
    
    [customCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(customCodeView);
        make.width.equalTo(@120);
    }];
}

- (void)tijiaoButtonAction {
    [self.view endEditing:YES];
    if(![self.customCodeTF.text isVaild]) {
        return;
    }
    
    if(AL_MyAppDelegate.userModel.idModel.userId) {
        _confirmCustomOrderApi = [[ALConfirmCustomOrderApi alloc] initConfirmCustomOrderApi:self.customCodeTF.text];
        AL_WeakSelf(self);
        [_confirmCustomOrderApi ALCustomHudStartWithErrorBlock:^(NSString *message) {
            if([message isVaild]) {
                ALHudMessageView *hudMessageView = [[ALHudMessageView alloc] initWithFrame:CGRectZero message:message];
                [hudMessageView show];
            }
        } CompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            ALOrderModel *orderModel = [[ALOrderModel alloc] init];
            orderModel.orderStatus = OrderStautsCustom;
            orderModel.orderId = weakSelf.confirmCustomOrderApi.data[@"orderId"];
            ALOrderInfoViewController *orderInfoVC = [[ALOrderInfoViewController alloc] init];
            orderInfoVC.orderModel = orderModel;
            
            [ALKeyWindow.rootViewController presentViewController:[[ALBaseNavigationController alloc] initWithRootViewController:orderInfoVC] animated:YES completion:^{
            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
            }];
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
        
        _confirmCustomOrderApi.dataErrorBlock = ^{
            [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
        };
        
        _confirmCustomOrderApi.noNetworkBlock = ^{
            [weakSelf showRequestStauts:ALRequestStatusDataError];
        };
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:ReSetToLoginModule object:nil];
    }
    
    
}

#pragma mark lazy load
- (WKWebView *)wkWebView {
    if(!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _wkWebView.backgroundColor = [UIColor clearColor];
        _wkWebView.opaque = NO;
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}

- (UIButton *)telephoneBtn {
    if(!_telephoneBtn) {
        _telephoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_telephoneBtn setBackgroundImage:[UIImage imageNamed:@"tel"] forState:UIControlStateNormal];
        [self.view addSubview:_telephoneBtn];
    }
    [_telephoneBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [MobClick event:ALMobEventID_B1];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4001066964"]];
        });
    }];
    return _telephoneBtn;
}

- (void)dealloc {
    [_confirmCustomOrderApi stop];
    _confirmCustomOrderApi = nil;
}
@end

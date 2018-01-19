//
//  ALLoginViewController.m
//  AnyHelp
//
//  Created by along on 2017/7/19.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALLoginViewController.h"
#import "ALAccountInfoView.h"
#import "ALLoginApi.h"
#import "ALUserIDModel.h"
#import <JPUSHService.h>
#import "ALProtocolViewController.h"
#import "ALMyInfoApi.h"

@interface ALLoginViewController ()
@property (nonatomic, strong) ALAccountInfoView *accountInfoView;
@property (nonatomic, strong) ALActionButton *loginBtn;
@property (nonatomic, strong) YYLabel *protocolLab;
@property (nonatomic, strong) ALLoginApi *loginApi;
@end

@implementation ALLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationOption];
    //初始化控件
    [self initSubviews];
    //绑定事件
    [self bindAction];
    
    //清空数据
    [NSObject AL_clearDataWithLocalKey:UserInfo_Default];
    AL_MyAppDelegate.userModel = nil;
    
    //清空推送标识
    [JPUSHService deleteAlias:nil seq:0];
    //停止友盟PUID统计
    [MobClick profileSignOff];
}

#pragma mark ConfigureNavigation
- (void)initNavigationOption {
    self.title = @"手机快捷登录";
    UIBarButtonItem *closeItem = [self createButtonItemWithImageName:@"icon_close_nor" selector:@selector(dismissAction)];
    self.navigationItem.leftBarButtonItem = closeItem;
}

#pragma mark Action
- (void)dismissAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initSubviews {
    [self.accountInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.right.equalTo(@-11);
        make.top.mas_equalTo(ALNavigationBarHeight + 10);
        make.height.equalTo(@95);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.top.equalTo(self.accountInfoView.mas_bottom).offset(25);
    }];
    
    [self.protocolLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-24);
        make.centerX.equalTo(self.view);
    }];
}

- (void)bindAction {
    AL_WeakSelf(self);
    [self.accountInfoView addObserverBlockForKeyPath:@"loginEnable" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
        NSString *val = ALStringFormat(@"%@", newVal);
        weakSelf.loginBtn.enabled = val.boolValue;
    }];
}

#pragma mark Action
- (void)loginButtonAction {
    AL_WeakSelf(self);
    _loginApi = [[ALLoginApi alloc] initWithLoginApi:self.accountInfoView.accountString code:self.accountInfoView.codeString];
    [_loginApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.view endEditing:YES];
        //设置用户id数据
        AL_MyAppDelegate.userModel.idModel = weakSelf.loginApi.idModel;
        //保存数据
        [AL_MyAppDelegate.userModel AL_saveLocalWithLocalKey:UserInfo_Default];
        //设置推送标识
        [JPUSHService setAlias:AL_MyAppDelegate.userModel.idModel.userId completion:nil seq:0];
        //友盟统计用户登录
        [MobClick profileSignInWithPUID:AL_MyAppDelegate.userModel.idModel.userId];
        
        ALMyInfoApi *myInfoApi = [[ALMyInfoApi alloc] initWithMyInfoApi];
        [myInfoApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            AL_MyAppDelegate.userModel.userInfoModel = myInfoApi.userInfoModel;
            [AL_MyAppDelegate.userModel AL_saveLocalWithLocalKey:UserInfo_Default];
            [weakSelf dismissAction];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:UserLoginSuceesssNotification object:nil];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark load
- (ALAccountInfoView *)accountInfoView {
    if(!_accountInfoView) {
        _accountInfoView = [[ALAccountInfoView alloc] init];
        [self.view addSubview:_accountInfoView];
    }
    return _accountInfoView;
}

- (ALActionButton *)loginBtn {
    if(!_loginBtn) {
        _loginBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:YES];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"btn-next-disabled"] forState:UIControlStateDisabled];
        [_loginBtn addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.enabled = NO;
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
}

- (YYLabel *)protocolLab {
    if(!_protocolLab) {
        _protocolLab = [[YYLabel alloc] init];
        _protocolLab.font = ALThemeFont(13);
        [self.view addSubview:_protocolLab];
    }
    
    AL_WeakSelf(self);
    //初始化可点击富文本
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"点击登录，即表示认同《镖镖用户协议》"];
    text.yy_lineSpacing = 0.2;
    text.yy_font = [UIFont systemFontOfSize:14];
    text.yy_color = [UIColor colorWithRGBA:0x999999FF];
    
    [text yy_setTextHighlightRange:NSMakeRange(10, 8) color:[UIColor colorWithRGBA:0x4B7FEBFF] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [weakSelf.navigationController pushViewController:[ALProtocolViewController new] animated:YES];
    }];
    
    _protocolLab.attributedText = text;  //设置富文本
    
    return _protocolLab;
}

- (void)dealloc {
    [_loginApi stop];
    [self.accountInfoView removeObserverBlocksForKeyPath:@"loginEnable"];
}
@end

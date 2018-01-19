//
//  ALSetPasswordViewController.m
//  bbxServer
//
//  Created by along on 2017/8/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSetPasswordViewController.h"
#import "ALPasswordInfoView.h"
#import "ALAuthenticationViewController.h"
#import "ALRestPasswordApi.h"
#import "ALRegistApi.h"
#import "ALAccountInfoView.h"
#import "ALLoginApi.h"
#import <JPUSHService.h>

@interface ALSetPasswordViewController ()
@property (nonatomic, strong) ALAccountInfoView *accountInfoView;
@property (nonatomic, strong) ALActionButton *nextBtn;

@property (nonatomic, strong) ALRegistApi *registApi;
@property (nonatomic, strong) ALLoginApi *loginApi;
@property (nonatomic, strong) ALRestPasswordApi *resetPasswordApi;
@end

@implementation ALSetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化控件
    [self initSubviews];
    [self bindAction];
}

- (void)initSubviews {
    [self.accountInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.top.mas_equalTo(ALNavigationBarHeight + 10);
        make.height.equalTo(@137);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.top.equalTo(self.accountInfoView.mas_bottom).offset(25);
    }];
}

- (void)bindAction {
    AL_WeakSelf(self);
    [self.accountInfoView addObserverBlockForKeyPath:@"loginEnable" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
        NSString *val = ALStringFormat(@"%@", newVal);
        weakSelf.nextBtn.enabled = val.boolValue;
    }];
}

#pragma mark Action
- (void)nextButtonAction {
    AL_WeakSelf(self);
    if([self.title isEqualToString:@"注册"]) {
        
        if(self.accountInfoView.pwdString.length < 6 || self.accountInfoView.pwdString.length > 32) {
            [ALKeyWindow showHudError:@"密码长度错误，请输入6—32位密码～"];
            return;
        }
        
        _registApi = [[ALRegistApi alloc] initRegistApi:self.accountInfoView.accountString password:[self.accountInfoView.pwdString md5String] code:self.accountInfoView.codeString];
        
        [_registApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            weakSelf.loginApi = [[ALLoginApi alloc] initLoginApi:weakSelf.accountInfoView.accountString password:[weakSelf.accountInfoView.pwdString md5String]];
            
            [weakSelf.loginApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                //设置用户id数据
                AL_MyAppDelegate.userModel.idModel = weakSelf.loginApi.idModel;
                //保存数据
                [AL_MyAppDelegate.userModel AL_saveLocalWithLocalKey:UserInfo_Default];
                
                //设置推送标识
                [JPUSHService setTags:[NSSet setWithObject:@"serverTag"] alias:AL_MyAppDelegate.userModel.idModel.userId fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    NSLog(@"%d",iResCode);
                }];
                
                //友盟统计用户登录
                [MobClick profileSignInWithPUID:AL_MyAppDelegate.userModel.idModel.userId];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:ReSetToMainPageModule object:nil];
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    } else if([self.title isEqualToString:@"重置密码"]){
        _resetPasswordApi = [[ALRestPasswordApi alloc] initRestPasswordApi:AL_MyAppDelegate.userModel.userInfoModel.phone newPassword:[self.accountInfoView.pwdString md5String] code:self.accountInfoView.codeString];
        
        [_resetPasswordApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    } else if([self.title isEqualToString:@"忘记密码"]) {
        _resetPasswordApi = [[ALRestPasswordApi alloc] initRestPasswordApi:self.accountInfoView.accountString newPassword:[self.accountInfoView.pwdString md5String] code:self.accountInfoView.codeString];
        
        [_resetPasswordApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    }
}

#pragma mark load
- (ALAccountInfoView *)accountInfoView {
    if(!_accountInfoView) {
        _accountInfoView = [[ALAccountInfoView alloc] init];
        [self.view addSubview:_accountInfoView];
        
        if([self.title isEqualToString:@"重置密码"]) {
            _accountInfoView.changePwd = YES;
        }
    }
    return _accountInfoView;
}

- (ALActionButton *)nextBtn {
    if(!_nextBtn) {
        _nextBtn = [ALActionButton buttonWithArcType:UIButtonTypeCustom];
        [_nextBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.enabled = NO;
        [self.view addSubview:_nextBtn];
    }
    return _nextBtn;
}

- (void)dealloc {
    [_registApi stop];
    [_loginApi stop];
    [_resetPasswordApi stop];
    [self.accountInfoView removeObserverBlocksForKeyPath:@"loginEnable"];
}
@end

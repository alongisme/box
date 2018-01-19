//
//  AccountInfoViewController.m
//  bbxUser
//
//  Created by along on 2017/8/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAccountInfoViewController.h"
#import "ALImagePickerController.h"
#import "ALEditAccountInfoViewController.h"
#import "ALUploadApi.h"
#import "ALUpdateMyInfoApi.h"
#import "ALUpdateServerTagViewController.h"
#import <JPUSHService.h>

@interface ALAccountInfoViewController ()
@property (nonatomic, strong) ALShadowView *accountView;
@property (nonatomic, strong) ALShadowView *phoneView;
@property (nonatomic, strong) ALShadowView *serverLabView;
@property (nonatomic, strong) ALShadowView *logoutView;
@end

@implementation ALAccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"账号信息";
    
    [self initSubviews];
    
    [self bindAction];
}

- (void)viewWillAppear:(BOOL)animated {
    self.accountView.nickName = AL_MyAppDelegate.userModel.userInfoModel.nickName;
}

- (void)initSubviews {
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.top.mas_equalTo(ALNavigationBarHeight + 10);
        make.height.equalTo(@111);
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.accountView);
        make.top.equalTo(self.accountView.mas_bottom).offset(10);
        make.height.equalTo(@45);
    }];
    
    [self.serverLabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.accountView);
        make.top.equalTo(self.phoneView.mas_bottom).offset(10);
        make.height.equalTo(@45);
    }];
    
    if(AL_MyAppDelegate.userModel.idModel.userId) {
        [self.logoutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.serverLabView);
            make.height.equalTo(@45);
            make.top.equalTo(self.serverLabView.mas_bottom).offset(30);
        }];
    }
}

- (void)bindAction {
    AL_WeakSelf(self);
    self.accountView.multiItemBlock = ^(NSUInteger index) {
        if(index == 1) {
            [ALAlertViewController showAlertOnlyCancelButton:weakSelf title:nil message:nil style:UIAlertControllerStyleActionSheet alertArray:@[@"从相册选择",@"拍照"] clickBlock:^(int index) {
                [ALImagePickerController ImagePickerWithDelegate:weakSelf SourceType:index == 0 ? UIImagePickerControllerSourceTypePhotoLibrary : UIImagePickerControllerSourceTypeCamera Edit:NO choseImageBlcok:^(UIImage *image, NSDictionary *info) {

                    [ALKeyWindow showHudInWindow];
                    ALUploadApi *api = [[ALUploadApi alloc] initWithImage:image];
                    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        
                        ALUpdateMyInfoApi *updateMyInfoApi = [[ALUpdateMyInfoApi alloc] initWithUpdateMyInfoApi:api.resonseImageFilePath nickName:nil];
                        
                        [updateMyInfoApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                            [ALKeyWindow showHudSuccess:@"修改头像成功～"];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                weakSelf.accountView.headString = ALStringFormat(@"%@%@",URL_Image,api.resonseImageFilePath);
                            });
                            AL_MyAppDelegate.userModel.userInfoModel.icon = weakSelf.accountView.headString;
                            [AL_MyAppDelegate.userModel AL_saveLocalWithLocalKey:UserInfo_Default];
                        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                            [ALKeyWindow hideHudInWindow];
                        }];
                        
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        [ALKeyWindow hideHudInWindow];
                    }];
                    
                } cannelBlock:nil];
            }];
        } else {
            ALEditAccountInfoViewController *editAccountInfoVC = [[ALEditAccountInfoViewController alloc]init];
            
            [weakSelf.navigationController pushViewController:editAccountInfoVC animated:YES];
        }
    };
    
    if(AL_MyAppDelegate.userModel.idModel.userId) {
        self.logoutView.clickBlock = ^{
            [ALAlertViewController showAlertOnlyCancelButton:weakSelf title:@"提示" message:@"是否退出登录？" style:UIAlertControllerStyleAlert Destructive:@"退出" clickBlock:^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"closeTimer" object:nil];
                
                //清空数据
                [NSObject AL_clearDataWithLocalKey:UserInfo_Default];
                AL_MyAppDelegate.userModel = nil;
                
                //清空推送标识
                [JPUSHService setTags:[NSSet set] alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    NSLog(@"%d",iResCode);
                }];
                
                //停止友盟PUID统计
                [MobClick profileSignOff];
                
                [ALKeyWindow.rootViewController dismissViewControllerAnimated:NO completion:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:ReSetToLoginModule object:nil];
                }];
                
            }];
        };
    }
    
    self.serverLabView.multiItemBlock = ^(NSUInteger index) {
        [weakSelf.navigationController pushViewController:[[ALUpdateServerTagViewController alloc] init] animated:YES];
    };
}

#pragma mark lazy load

- (ALShadowView *)accountView {
    if(!_accountView) {
        _accountView = [[ALShadowView alloc] initWithAccount:CGRectZero];
        _accountView.headString = ALStringFormat(@"%@%@",URL_Image,AL_MyAppDelegate.userModel.userInfoModel.icon);
        [self.view addSubview:_accountView];
    }
    return _accountView;
}

- (ALShadowView *)phoneView {
    if(!_phoneView) {
        _phoneView = [[ALShadowView alloc] initWithFrame:CGRectZero titleArray:@[@"手机号码"] contentArray:@[AL_MyAppDelegate.userModel.userInfoModel.phone] rightView:NO];
        [self.view addSubview:_phoneView];
        
    }
    return _phoneView;
}

- (ALShadowView *)serverLabView {
    if(!_serverLabView) {
        _serverLabView = [[ALShadowView alloc] initWithFrame:CGRectZero titleArray:@[@"服务标签"] contentArray:@[ALStringFormat(@"%@个",AL_MyAppDelegate.userModel.userInfoModel.skillTagNum)] rightView:YES];
        [self.view addSubview:_serverLabView];
    }
    return _serverLabView;
}

- (ALShadowView *)logoutView {
    if(!_logoutView) {
        _logoutView = [[ALShadowView alloc] initWithButton:CGRectZero title:@"退出"];
        [self.view addSubview:_logoutView];
    }
    return _logoutView;
}
@end

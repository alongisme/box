//
//  ALEditAccountInfoViewController.m
//  bbxUser
//
//  Created by along on 2017/8/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALEditAccountInfoViewController.h"
#import "ALUpdateMyInfoApi.h"

@interface ALEditAccountInfoViewController ()
@property (nonatomic, strong) ALShadowView *nickNameView;
@end

@implementation ALEditAccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改用户名";
    
    [self initSubviews];
}

- (void)initSubviews {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    
    [self.nickNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.top.mas_equalTo(ALNavigationBarHeight + 10);
        make.height.equalTo(@45);
    }];
}

- (void)saveAction {
    
    if([self.nickNameView.textString nickNameVerify]) {
        ALUpdateMyInfoApi *updateMyInfoApi = [[ALUpdateMyInfoApi alloc] initWithUpdateMyInfoApi:nil nickName:self.nickNameView.textString];
        
        [updateMyInfoApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [ALKeyWindow showHudSuccess:@"修改昵称成功～"];
            AL_MyAppDelegate.userModel.userInfoModel.nickName = self.nickNameView.textString;
            [AL_MyAppDelegate.userModel AL_saveLocalWithLocalKey:UserInfo_Default];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

        }];
    } else {
        [ALKeyWindow showHudError:@"昵称只能包含中文、字母、数字～"];
    }
}

#pragma mark lazy load
- (ALShadowView *)nickNameView {
    if(!_nickNameView) {
        _nickNameView = [[ALShadowView alloc] initWithFrame:CGRectZero placeholder:@"请输入昵称（不超过十个字）" type:ALShadowStyleTextFiled];
        _nickNameView.nickName = AL_MyAppDelegate.userModel.userInfoModel.nickName;
        self.nickNameView.textString = _nickNameView.nickName;
        [self.view addSubview:_nickNameView];
    }
    return _nickNameView;
}
@end

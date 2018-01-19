//
//  ALMineViewController.m
//  bbxUser
//
//  Created by along on 2017/8/4.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMineViewController.h"
#import "ALAccountInfoViewController.h"
#import "ALMyMessageViewController.h"
#import "ALSystemSettingViewController.h"
#import "ALOrderViewController.h"
#import "ALLoginViewController.h"
#import "ALMyInfoApi.h"
#import "ALRedEnvlopeViewController.h"

@interface ALMineViewController ()
@property (nonatomic, strong) ALShadowView *mineOrderView;
@property (nonatomic, strong) ALShadowView *otherView;
@property (nonatomic, strong) ALShadowView *myRedEnvView;
@property (nonatomic, weak) ALLabel *nameLab;
@property (nonatomic, weak) UIImageView *headIV;
@property (nonatomic, strong) ALMyInfoApi *myInfoApi;
@end

@implementation ALMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    [self initSubviews];
    
    [self bindAction];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initUserInfoData) name:InitUserInfoDataNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initUserInfoData];
}

- (void)initUserInfoData {
    if(AL_MyAppDelegate.userModel.idModel.userId) {
        AL_WeakSelf(self);
        [self.myInfoApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            weakSelf.nameLab.text = self.myInfoApi.userInfoModel.nickName;
            [weakSelf.headIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,self.myInfoApi.userInfoModel.icon)] placeholderImage:[UIImage imageNamed:@"touxiang_weidenglu"]];
            if([weakSelf.myInfoApi.userInfoModel.neMessage integerValue] == 1) {
                weakSelf.otherView.unreadMessage = YES;
            } else {
                weakSelf.otherView.unreadMessage = NO;
            }
            AL_MyAppDelegate.userModel.userInfoModel = weakSelf.myInfoApi.userInfoModel;
            [AL_MyAppDelegate.userModel AL_saveLocalWithLocalKey:UserInfo_Default];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    } else {
        self.nameLab.text = @"未登录";
    }
}

- (void)initSubviews {
    
    UIBarButtonItem *closeItem = [self createButtonItemWithImageName:@"Back Chevron" selector:@selector(dismissAction)];
    self.navigationItem.leftBarButtonItem = closeItem;
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithRGBA:ALThemeColor];
    [self.view addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ALNavigationBarHeight);
        make.centerX.width.equalTo(self.view);
        make.height.equalTo(@141);
    }];
    
    UIImageView *headIV = [[UIImageView alloc] init];
    headIV.backgroundColor = [UIColor whiteColor];
    headIV.userInteractionEnabled = YES;
    headIV.contentMode = UIViewContentModeScaleAspectFill;
    headIV.layer.masksToBounds = YES;
    headIV.layer.cornerRadius = 84/2;
    [bgView addSubview:headIV];
    self.headIV = headIV;
    
    [headIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,AL_MyAppDelegate.userModel.userInfoModel.icon)] placeholderImage:[UIImage imageNamed:@"touxiang_weidenglu"]];
    
    [headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@84);
        make.centerX.equalTo(bgView);
        make.top.equalTo(@10);
    }];
    
    ALLabel *nameLabel = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
    nameLabel.font = ALMediumTitleFont(16);
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = AL_MyAppDelegate.userModel.userInfoModel.nickName;
    [bgView addSubview:nameLabel];
    self.nameLab = nameLabel;
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(headIV.mas_bottom).offset(13);
        make.height.equalTo(@20);
    }];
    
    [self.mineOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom).offset(10);
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.height.equalTo(@45);
    }];
    
    [self.myRedEnvView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mineOrderView.mas_bottom).offset(10);
        make.leading.trailing.equalTo(self.mineOrderView);
        make.height.equalTo(@45);
    }];
    
    [self.otherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myRedEnvView.mas_bottom).offset(10);
        make.leading.trailing.equalTo(self.mineOrderView);
        make.height.equalTo(@91);
    }];
}

- (void)dismissAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)bindAction {
    AL_WeakSelf(self);
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        if(AL_MyAppDelegate.userModel.idModel.userId) {
            [weakSelf.navigationController pushViewController:[[ALAccountInfoViewController alloc] init] animated:YES];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:ReSetToLoginModule object:nil];
        }
    }];
    
    [self.headIV addGestureRecognizer:tapGestureRecognizer];
    
    self.mineOrderView.clickBlock = ^ {
        [MobClick event:ALMobEventID_B5];
        [weakSelf.navigationController pushViewController:[[ALOrderViewController alloc] init] animated:YES];
    };
    
    self.myRedEnvView.clickBlock = ^{
        [MobClick event:ALMobEventID_B6];
        [weakSelf.navigationController pushViewController:[[ALRedEnvlopeViewController alloc] init] animated:YES];
    };
    
    self.otherView.multiItemBlock = ^(NSUInteger index) {
        if(index == 1) {
            [MobClick event:ALMobEventID_B7];
            [weakSelf.navigationController pushViewController:[[ALMyMessageViewController alloc] init] animated:YES];
            weakSelf.otherView.unreadMessage = NO;
        } else if(index == 2){
            [MobClick event:ALMobEventID_B8];
            [weakSelf.navigationController pushViewController:[[ALSystemSettingViewController alloc] init] animated:YES];
        }
    };
}

#pragma mark lazy load
- (ALShadowView *)mineOrderView {
    if(!_mineOrderView) {
        _mineOrderView = [[ALShadowView alloc] initWithFrame:CGRectZero leftImageName:@"icon_order" title:@"我的订单" type:ALShadowStyleSingleMineItem];
        [self.view addSubview:_mineOrderView];
    }
    return _mineOrderView;
}

- (ALShadowView *)myRedEnvView {
    if(!_myRedEnvView) {
        _myRedEnvView = [[ALShadowView alloc] initWithFrame:CGRectZero leftImageName:@"youhuiquan" title:@"我的优惠券" type:ALShadowStyleSingleMineItem];
        [self.view addSubview:_myRedEnvView];
    }
    return _myRedEnvView;
}

- (ALShadowView *)otherView {
    if(!_otherView) {
        _otherView = [[ALShadowView alloc] initWithFrame:CGRectZero leftImageArray:@[@"wodexiaoxi",@"shezhi"] titleArray:@[@"我的消息",@"系统设置"] type:ALShadowStyleMultiMineItem];
        [self.view addSubview:_otherView];
    }
    return _otherView;
}

- (ALMyInfoApi *)myInfoApi {
    if(!_myInfoApi) {
        _myInfoApi = [[ALMyInfoApi alloc] init];
    }
    return _myInfoApi;
}

- (void)dealloc {
    [self.myInfoApi stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

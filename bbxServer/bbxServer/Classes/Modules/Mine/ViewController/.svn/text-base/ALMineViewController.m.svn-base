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
#import "ALOrderListViewController.h"
#import "ALEvaluateListViewController.h"
#import "ALMyInfoApi.h"
#import "WSStarRatingView.h"
#import "ALMyWalletViewController.h"

@interface ALMineViewController ()
@property (nonatomic, strong) ALShadowView *mineOrderView;
@property (nonatomic, strong) ALShadowView *otherView;
@property (nonatomic, strong) ALShadowView *myEvaView;
@property (nonatomic, strong) ALShadowView *myWalletView;
@property (nonatomic, weak) ALLabel *nameLab;
@property (nonatomic, weak) ALLabel *orderNumLab;
@property (nonatomic, weak) UIImageView *headIV;
@property (nonatomic, weak) WSStarRatingView *startLevelView;
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
    [self initUserInfoData];
}

- (void)initUserInfoData {
    if(AL_MyAppDelegate.userModel.idModel.userId) {
        AL_WeakSelf(self);
        [self.myInfoApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            weakSelf.nameLab.text = weakSelf.myInfoApi.userInfoModel.nickName;
            [weakSelf.headIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,weakSelf.myInfoApi.userInfoModel.icon)] placeholderImage:[UIImage imageNamed:@"huantouxiang_moren"]];
            weakSelf.orderNumLab.text = ALStringFormat(@"接单数：%@",weakSelf.myInfoApi.userInfoModel.doOrderNum);
            [weakSelf.startLevelView setScore:[weakSelf.myInfoApi.userInfoModel.avgRank floatValue] withAnimation:NO];

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
    
    UIBarButtonItem *closeItem = [self createButtonItemWithImageName:@"icon-back" selector:@selector(dismissAction)];
    self.navigationItem.leftBarButtonItem = closeItem;
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithRGBA:ALThemeColor];
    [self.view addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ALNavigationBarHeight);
        make.centerX.width.equalTo(self.view);
        make.height.equalTo(@168);
    }];
    
    UIImageView *headIV = [[UIImageView alloc] init];
    headIV.contentMode = UIViewContentModeScaleAspectFill;
    headIV.backgroundColor = [UIColor whiteColor];
    headIV.userInteractionEnabled = YES;
    headIV.layer.masksToBounds = YES;
    headIV.layer.cornerRadius = 84/2;
    [bgView addSubview:headIV];
    self.headIV = headIV;
    
    [headIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,AL_MyAppDelegate.userModel.userInfoModel.icon)] placeholderImage:[UIImage imageNamed:@"huantouxiang_moren"]];
    
    [headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@84);
        make.centerX.equalTo(bgView);
        make.top.equalTo(@10);
    }];
    
    UIImageView *approveIV = [[UIImageView alloc] init];
    [bgView addSubview:approveIV];
    
    [approveIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headIV);
        make.right.equalTo(headIV).offset(17);
    }];
    
    if([AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusSuccess]) {
        approveIV.image = [UIImage imageNamed:@"icon-Authenticated"];
    } else if ([AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusFirst] || [AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusSecond] || [AL_MyAppDelegate.authModel.authStatus isEqualToString:UserAuthStatusThird]) {
        approveIV.image = [UIImage imageNamed:@"icon-In authentication"];
    } else {
        approveIV.image = [UIImage imageNamed:@"icon-Authentication failed"];
    }
    
    ALLabel *nameLabel = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
    nameLabel.font = ALMediumTitleFont(16);
    nameLabel.textColor = [UIColor whiteColor];
    [bgView addSubview:nameLabel];
    self.nameLab = nameLabel;
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(headIV.mas_bottom).offset(13);
        make.height.equalTo(@20);
    }];
    
    ALLabel *orderNumLab = [[ALLabel alloc] init];
    orderNumLab.textColor = [UIColor whiteColor];
    [bgView addSubview:orderNumLab];
    self.orderNumLab = orderNumLab;
    
    ALLabel *levelLab = [[ALLabel alloc] init];
    levelLab.text = @"评级：";
    levelLab.textColor = [UIColor whiteColor];
    [bgView addSubview:levelLab];
    
    [orderNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headIV.mas_centerX).offset(-10);
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
    }];
    
    [levelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(orderNumLab);
        make.left.equalTo(headIV.mas_centerX).offset(10);
    }];
    
    [self.view layoutIfNeeded];
    
    WSStarRatingView *startLevelView = [[WSStarRatingView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(levelLab.frame), CGRectGetMinY(levelLab.frame) + 14 / 2.0, 78, 14) numberOfStar:789];
    startLevelView.userInteractionEnabled = NO;
    [bgView addSubview:startLevelView];
    self.startLevelView = startLevelView;
    
    [startLevelView setScore:0 withAnimation:NO];
    
    [self.mineOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom).offset(10);
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.height.equalTo(@45);
    }];
    
    [self.myWalletView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mineOrderView.mas_bottom).offset(10);
        make.leading.trailing.equalTo(self.mineOrderView);
        make.height.equalTo(@45);
    }];
    
    [self.myEvaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myWalletView.mas_bottom).offset(10);
        make.leading.trailing.equalTo(self.myWalletView);
        make.height.equalTo(@45);
    }];
    
    [self.otherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myEvaView.mas_bottom).offset(10);
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
        [weakSelf.navigationController pushViewController:[[ALOrderListViewController alloc] init] animated:YES];
    };
    
    self.myWalletView.clickBlock = ^{
        [weakSelf.navigationController pushViewController:[[ALMyWalletViewController alloc] init] animated:YES];
    };
    
    self.myEvaView.clickBlock = ^{
        ALEvaluateListViewController *evalutateListVC = [[ALEvaluateListViewController alloc] init];
        evalutateListVC.securityId = AL_MyAppDelegate.userModel.idModel.userId;
        [weakSelf.navigationController pushViewController:evalutateListVC animated:YES];
    };
    
    self.otherView.multiItemBlock = ^(NSUInteger index) {
        if(index == 1) {
            [weakSelf.navigationController pushViewController:[[ALMyMessageViewController alloc] init] animated:YES];
            weakSelf.otherView.unreadMessage = NO;
        } else if(index == 2){
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

- (ALShadowView *)myEvaView {
    if(!_myEvaView) {
        _myEvaView = [[ALShadowView alloc] initWithFrame:CGRectZero leftImageName:@"icon-My assessment" title:@"我的评价" type:ALShadowStyleSingleMineItem];
        [self.view addSubview:_myEvaView];
    }
    return _myEvaView;
}

- (ALShadowView *)myWalletView {
    if(!_myWalletView) {
        _myWalletView = [[ALShadowView alloc] initWithFrame:CGRectZero leftImageName:@"qianbao" title:@"我的钱包" type:ALShadowStyleSingleMineItem];
        [self.view addSubview:_myWalletView];
    }
    return _myWalletView;
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

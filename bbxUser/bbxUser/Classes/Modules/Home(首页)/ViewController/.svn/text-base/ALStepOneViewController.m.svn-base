//
//  ALOneStepViewController.m
//  AnyHelp
//
//  Created by along on 2017/7/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALStepOneViewController.h"
#import "ALStepView.h"
#import "ALAddressView.h"
#import "ALStepTwoViewController.h"
#import "ALChoseAddressViewController.h"
#import "LJContactManager.h"

@interface ALStepOneViewController () <ALAddressDelegate,ALChoseAddressDelegate>
@property (nonatomic, strong) ALStepView *stepView;
@property (nonatomic, strong) ALAddressView *addressView;
@property (nonatomic, strong) ALActionButton *saveAddressBtn;
@property (nonatomic) CLLocationCoordinate2D pt;
@end

@implementation ALStepOneViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //这里在做一次隐藏 是防止手势返回时 导航栏没有变
    ((ALBaseNavigationController *)self.navigationController).customNavigationView.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"呼叫镖镖";
    
    [self initSubviews];
    
    [self getServerAddressInLocation:self.poiInfoModel];
}

- (void)initSubviews {
    [self.stepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ALNavigationBarHeight);
        make.left.right.equalTo(@0);
        make.height.equalTo(@75);
    }];
    
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.equalTo(self.stepView.mas_bottom).offset(19);
        make.height.equalTo(@180);
    }];
    
    [self.saveAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-20);
        make.left.equalTo(@11);
        make.right.equalTo(@-11);
    }];
}

#pragma mark ALAddressDelegate
- (void)addressLineDidSelected:(ALAddressDidSelected)type {
    if(type == ALAddressDidSelectedLoacation) {
        [MobClick event:ALMobEventID_C1];
        ALChoseAddressViewController *choseAddressVC = [[ALChoseAddressViewController alloc] init];
        choseAddressVC.choseAddressDelegate = self;
        [self.navigationController pushViewController:choseAddressVC animated:YES];
    } else {
        AL_WeakSelf(self);
        [MobClick event:ALMobEventID_C2];
        [[LJContactManager sharedInstance] selectContactAtController:self complection:^(NSString *name, NSString *phone) {
            weakSelf.addressView.telephoneContenTF.text = phone;
            weakSelf.addressView.linkManContenTF.text = name;
        }];
    }
}

#pragma mark ALChoseAddressDelegate
- (void)getServerAddressInLocation:(BMKPoiInfo *)model {
    self.addressView.serverAddressContentTF.text = model.name;
    self.addressView.streeTF.text = model.address;
    self.pt = model.pt;
}

#pragma mark Action
- (void)nextStepAction {
    if(![self.addressView.streeTF.text isVaild] || ![self.addressView.serverAddressContentTF.text isVaild] || ![self.addressView.telephoneContenTF.text isVaild] || ![self.addressView.linkManContenTF.text isVaild]) {
        [ALKeyWindow showHudError:@"请补全相关信息~"];
        return;
    }
    
    if(![self.addressView.telephoneContenTF.text mobileVerifty]) {
        [ALKeyWindow showHudError:@"请输入正确的手机号~"];
        return;
    }
    [MobClick event:ALMobEventID_C3];
    ALStepTwoViewController *stepTwoVC = [[ALStepTwoViewController alloc] init];
    stepTwoVC.serviceAddress = [self.addressView.serverAddressContentTF.text stringByAppendingString:self.addressView.streeTF.text];
    stepTwoVC.contactsPhone = self.addressView.telephoneContenTF.text;
    stepTwoVC.contactsName = self.addressView.linkManContenTF.text;
    stepTwoVC.contactsSex = self.addressView.manBtn.selected ? @0 : @1;
    stepTwoVC.pt = self.pt;
    [self.navigationController pushViewController:stepTwoVC animated:YES];
}

#pragma mark lazy load
- (ALStepView *)stepView {
    if(!_stepView) {
        _stepView = [[ALStepView alloc] initWithFrame:CGRectZero title:@"第一步骤" subTitle:@"请填写地址及联系方式"];
        [self.view addSubview:_stepView];
    }
    return _stepView;
}

- (ALAddressView *)addressView {
    if(!_addressView) {
        _addressView = [[ALAddressView alloc] init];
        _addressView.delegate = self;
        [self.view addSubview:_addressView];
        
        _addressView.telephoneContenTF.text = AL_MyAppDelegate.userModel.userInfoModel.phone;
        _addressView.linkManContenTF.text = AL_MyAppDelegate.userModel.userInfoModel.nickName;
    }
    return _addressView;
}

- (ALActionButton *)saveAddressBtn {
    if(!_saveAddressBtn) {
        _saveAddressBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        [_saveAddressBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_saveAddressBtn addTarget:self action:@selector(nextStepAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_saveAddressBtn];
    }
    return _saveAddressBtn;
}

@end

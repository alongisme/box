//
//  ALAuthenticationViewController.m
//  bbxServer
//
//  Created by along on 2017/8/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAuthenticationViewController.h"
#import "ALStepView.h"
#import "ALIdentityInformationView.h"
//#import "ClickedLabelView.h"
#import "ALSkillTagApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ALCreateAliLoginApi.h"
#import "ALImproveInforApi.h"
#import "ALMultiImageUploadApi.h"
#import "ALCustomTagsView.h"

@interface ALAuthenticationViewController ()
//第一步
@property (nonatomic, strong) ALStepView *stepView;
@property (nonatomic, strong) ALIdentityInformationView *identityInfomationView;

//第二步
@property (nonatomic, strong) ALLabel *aliPayAuthLab;
@property (nonatomic, strong) ALShadowView *aliPayAuthView;
@property (nonatomic, strong) ALLabel *reminderLab;

//第三步
@property (nonatomic, strong) ALLabel *serverLab;
//@property (nonatomic, strong) ClickedLabelView *serverLabView;
@property (nonatomic, strong) ALCustomTagsView *customTagsView;
@property (nonatomic, strong) ALActionButton *nextBtn;


@property (nonatomic, strong) ALSkillTagApi *skillTagApi;
@property (nonatomic, strong) ALCreateAliLoginApi *createAliLoginApi;
@property (nonatomic, strong) ALImproveInforApi *improveInforApi;
@property (nonatomic, strong) ALMultiImageUploadApi *multiImageUploadApi;
@end

@implementation ALAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交资料";
    [self loadData];
}

- (void)loadData {
    if(_currentStep == 2) {
        AL_WeakSelf(self);
        _skillTagApi = [[ALSkillTagApi alloc] initSkillTagApi];
        
        [_skillTagApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf initSubviews];
            [weakSelf bindAction];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
        
        _skillTagApi.noNetworkBlock = ^{
            [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
        };
        
        _skillTagApi.dataErrorBlock = ^{
            [weakSelf showRequestStauts:ALRequestStatusDataError];
        };
    } else {
        [self initSubviews];
        [self bindAction];
    }
}

- (void)reloadData {
    [self loadData];
}

- (void)initSubviews {
    [self.stepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ALNavigationBarHeight);
        make.left.right.equalTo(@0);
        make.height.equalTo(@75);
    }];
    
    if(_currentStep == 0) {
        [self.identityInfomationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(self.view);
            make.top.equalTo(self.stepView.mas_bottom);
            make.bottom.equalTo(@0);
        }];
    } else if(_currentStep == 1) {
        [self.aliPayAuthLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(self.stepView.mas_bottom).offset(12);
        }];
        
        [self.aliPayAuthView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.height.equalTo(@45);
            make.right.equalTo(@-14);
            make.top.equalTo(self.aliPayAuthLab.mas_bottom).offset(10);
        }];
        
        [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.right.equalTo(@-14);
            make.bottom.equalTo(@-10);
        }];
        
        [self.reminderLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.nextBtn.mas_top).offset(-10);
        }];
    } else {
        [self.serverLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(self.stepView.mas_bottom).offset(12);
        }];
        
        [self.view layoutIfNeeded];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (unsigned int i = 0; i < self.skillTagApi.skillTagDesArray.count; i++) {
            ALCommentTagModel *model = [ALCommentTagModel new];
            model.commentTagDes = self.skillTagApi.skillTagDesArray[i];
            [arr addObject:model];
        }
        _customTagsView = [[ALCustomTagsView alloc] initWithShadowFrame:CGRectMake(14, CGRectGetMaxY(self.serverLab.frame) + 10, ALScreenWidth - 28, (arr.count / 3 + 1) * (20 + 10)) tagArray:arr startOffsetX:14 space:10 expandHeight:10 selected:YES];
        _customTagsView.showEva = NO;
        [self.view addSubview:_customTagsView];
//        self.serverLabView.frame = CGRectMake(14, CGRectGetMaxY(self.serverLab.frame) + 12, ALScreenWidth - 28, _serverLabView.maxY + 15);
        
        [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.right.equalTo(@-14);
            make.bottom.equalTo(@-10);
        }];
    }
}

- (void)bindAction {
    AL_WeakSelf(self);
    if(_currentStep == 0) {
        
        self.identityInfomationView.nextStepAction = ^{
            NSArray *infoArray = weakSelf.identityInfomationView.identiftyInfoArray;
            for (unsigned int i = 0; i < infoArray.count; i++) {
                id obj = infoArray[i];
                if([obj isKindOfClass:[NSString class]]) {
                    NSString *string = obj;
                    if(![string isVaild]) {
                        [ALKeyWindow showHudError:@"请补全信息～"];
                        return ;
                    }
                    if(i == 2) {
                        if(![NSString validateIDCardNumber:string]) {
                            [ALKeyWindow showHudError:@"请输入正确的身份证号码～"];
                            return ;
                        }
                    }
                }
            }
            
            ALAuthenticationViewController *authenticationVC = [[ALAuthenticationViewController alloc] init];
            authenticationVC.identifyArray = weakSelf.identityInfomationView.identiftyInfoArray;
            authenticationVC.currentStep = weakSelf.currentStep + 1;
            [weakSelf.navigationController pushViewController:authenticationVC animated:YES];
            
        };
    } else if(_currentStep == 1) {
        self.aliPayAuthView.multiItemBlock = ^(NSUInteger index) {
            [weakSelf doAlipayAuth];
        };
        
        [self.nextBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            ALAuthenticationViewController *authenticationVC = [[ALAuthenticationViewController alloc] init];
            
            authenticationVC.identifyArray = weakSelf.identifyArray;
            if(![weakSelf.aliUserId isVaild]) {
                [weakSelf.view showHudError:@"请先验证支付宝～"];
                return;
            }
            authenticationVC.aliUserId = weakSelf.aliUserId;
            authenticationVC.currentStep = weakSelf.currentStep + 1;
            [weakSelf.navigationController pushViewController:authenticationVC animated:YES];
            
        }];
    } else if(_currentStep == 2) {
        [self.nextBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            NSString *allSelectedTag = [weakSelf.customTagsView getSelectedTagString];
            if(![allSelectedTag isVaild]) {
                [weakSelf.view showHudError:@"至少选择一个服务标签～"];
                return;
            }
            
            NSArray *infoArray = weakSelf.identifyArray;
            
            weakSelf.multiImageUploadApi = [[ALMultiImageUploadApi alloc] initWithMultiImageUploadStart:@[infoArray[0],infoArray[3],infoArray[4],infoArray[5]] Success:^(NSString *filePathString) {
                NSArray *imgArr = [filePathString componentsSeparatedByString:@","];
                ALImproveInforApi *improveInforApi = [[ALImproveInforApi alloc] initImproveInforApi:infoArray[1] idNo:infoArray[2] idcardFrontUrl:imgArr[1] idcardBackUrl:imgArr[2] idcardHandUrl:imgArr[3] aliUserId:weakSelf.aliUserId skillTag:allSelectedTag iconUrl:imgArr[0]];
                
                [improveInforApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        [ALKeyWindow hideHudInWindow];
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                    [ALKeyWindow hideHudInWindow];
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }];
            } failure:^{
                [ALKeyWindow hideHudInWindow];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }];

        }];

    }
}

//支付宝授权
- (void)doAlipayAuth {
    _createAliLoginApi = [[ALCreateAliLoginApi alloc] initCreateAliLoginApi];
    AL_WeakSelf(self);
    [_createAliLoginApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [[AlipaySDK defaultService] auth_V2WithInfo:weakSelf.createAliLoginApi.data[@"infoStr"]
                                         fromScheme:AliPayScheme
                                           callback:^(NSDictionary *resultDic) {
                                               [weakSelf alipayNotification:resultDic];
//                                               NSLog(@"result = %@",resultDic);
//                                               // 解析 auth code
//                                               NSString *result = resultDic[@"result"];
//                                               NSString *authCode = nil;
//                                               if (result.length>0) {
//                                                   NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                                                   for (NSString *subResult in resultArr) {
//                                                       if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                                                           authCode = [subResult substringFromIndex:10];
//                                                           break;
//                                                       }
//                                                   }
//                                               }
//                                               NSLog(@"授权结果 authCode = %@", authCode?:@"");
                                           }];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)alipayNotification:(NSDictionary *)result {
    if([result[@"resultStatus"] integerValue] == 9000) {
        self.aliPayAuthView.aliPayAuthStatus = YES;        
        for (NSString *string in [result[@"result"] componentsSeparatedByString:@"&"]) {
            if([string containsString:@"user_id"]) {
                self.aliUserId = [string stringByReplacingOccurrencesOfString:@"user_id=" withString:@""];
            }
        }
    }
}

#pragma mark lazy load
- (ALStepView *)stepView {
    if(!_stepView) {
        _stepView = [[ALStepView alloc] initWithFrame:CGRectZero index:_currentStep];
        [self.view addSubview:_stepView];
    }
    return _stepView;
}

- (ALIdentityInformationView *)identityInfomationView {
    if(!_identityInfomationView) {
        _identityInfomationView = [[ALIdentityInformationView alloc] init];
        [self.view addSubview:_identityInfomationView];
    }
    return _identityInfomationView;
}

//第二步
- (ALLabel *)aliPayAuthLab {
    if(!_aliPayAuthLab) {
        _aliPayAuthLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _aliPayAuthLab.text = @"支付宝验证";
        _aliPayAuthLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
        [self.view addSubview:_aliPayAuthLab];
    }
    return _aliPayAuthLab;
}

- (ALShadowView *)aliPayAuthView {
    if(!_aliPayAuthView) {
        _aliPayAuthView = [[ALShadowView alloc] initWithFrame:CGRectZero titleArray:@[@"验证支付宝"] contentArray:@[@"未验证"] rightView:YES];
        [self.view addSubview:_aliPayAuthView];
    }
    return _aliPayAuthView;
}

- (ALLabel *)reminderLab {
    if(!_reminderLab) {
        _reminderLab = [[ALLabel alloc] init];
        [self.view addSubview:_reminderLab];
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"温馨提示:请绑定您的支付宝，后续薪资会进入该支付宝"];
        attString.yy_font = ALThemeFont(13);
        attString.yy_color = [UIColor colorWithRGB:0x2A2A2A];
        [attString yy_setColor:[UIColor colorWithRGBA:ALThemeColor] range:NSMakeRange(0, 5)];
        _reminderLab.attributedText = attString;
        
    }
    return _reminderLab;
}

- (ALActionButton *)nextBtn {
    if(!_nextBtn) {
        _nextBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        if(_currentStep == 2) {
            [_nextBtn setTitle:@"提交" forState:UIControlStateNormal];
        } else {
            [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        }
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _nextBtn.enabled = YES;
        [self.view addSubview:_nextBtn];
    }
    return _nextBtn;
}

//第三步
- (ALLabel *)serverLab {
    if(!_serverLab) {
        _serverLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        [self.view addSubview:_serverLab];
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"服务标签（至少选择一个）"];
        attString.yy_font = ALThemeFont(14);
        [attString yy_setColor:[UIColor colorWithRGB:0xF55254] range:NSMakeRange(4, attString.length - 4)];
        _serverLab.attributedText = attString;
    }
    return _serverLab;
}

//- (ClickedLabelView *)serverLabView {
//    if(!_serverLabView) {
//        [self.view layoutIfNeeded];
//        
//        NSMutableArray *arr = [NSMutableArray array];
//        for (unsigned int i = 0; i < self.skillTagApi.skillTagDesArray.count; i++) {
//            ALCommentTagModel *model = [ALCommentTagModel new];
//            model.commentTagDes = self.skillTagApi.skillTagDesArray[i];
//            [arr addObject:model];
//        }
//        _serverLabView = [[ClickedLabelView alloc] initWithShadowFrame:CGRectMake(14, CGRectGetMaxY(self.serverLab.frame) + 10, ALScreenWidth - 28, 100) dataArray:arr startMargin:10];
//        [self.view addSubview:_serverLabView];
//    }
//    return _serverLabView;
//}

- (void)dealloc {
    [_createAliLoginApi stop];
    [_skillTagApi stop];
}
@end

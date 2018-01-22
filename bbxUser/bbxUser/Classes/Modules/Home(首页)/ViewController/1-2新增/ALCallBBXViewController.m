//
//  ALCallBBXViewController.m
//  bbxUser
//
//  Created by xlshi on 2018/1/19.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALCallBBXViewController.h"
#import "ALOrderInfoViewController.h"
#import "ALCreateOrderApi.h"
#import "ALOrderEstimatedPriceApi.h"
#import "ALOrderModel.h"
#import "ALServerTagViewController.h"
#import "ALCreateOrderInitApi.h"
#import "ALMoneyInfoView.h"
#import "ALChoseSeverView.h"
#import "ALAdditionalDemandView.h"
#import "ALQueryOrderMinStartTimeApi.h"
#import "ALAddressView.h"
#import "ALChoseAddressViewController.h"
#import "LJContactManager.h"
#import "ALConsumerInfomationView.h"
#import "ALSafeProtectView.h"

@interface ALCallBBXViewController ()<ALAddressDelegate,ALChoseAddressDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
//选择服务
@property (nonatomic, strong) ALChoseSeverView *choseServerView;
//服务人数
@property (nonatomic, strong) ALShadowView *serverNumberView;
//下单人信息
@property (nonatomic, strong) ALConsumerInfomationView *consumerInfomationView;
//开始时间
@property (nonatomic, strong) ALShadowView *startTimeView;
//服务时间
@property (nonatomic, strong) ALShadowView *serverTimeView;
//安全保
@property (nonatomic, strong) ALSafeProtectView *safeProtectView;
//备注
@property (nonatomic, strong) ALShadowView *commentView;

//提示文字
@property (nonatomic, strong) ALLabel *mesLab;
//底部view
@property (nonatomic, strong) ALShadowView *shadowView;
@property (nonatomic, strong) ALLabel *priceLab;
@property (nonatomic, strong) ALActionButton *nextStepBtn;

@property (nonatomic, strong) ALCreateOrderInitApi *createOrderInitApi;
@property (nonatomic, strong) ALQueryOrderMinStartTimeApi *queryOrderMinStartTimeApi;

@property (nonatomic, strong) ALAddressView *addressView;
@property (nonatomic) CLLocationCoordinate2D pt;
@end

@implementation ALCallBBXViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //这里在做一次隐藏 是防止手势返回时 导航栏没有变
    ((ALBaseNavigationController *)self.navigationController).customNavigationView.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.title = @"呼叫镖镖";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData {
    AL_WeakSelf(self);
    _createOrderInitApi = [[ALCreateOrderInitApi alloc] initCreateOrderInitApi];
    
    [_createOrderInitApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSInteger defaultIndex = [weakSelf.createOrderInitApi.data[@"defaultIndex"] integerValue];
        ALOptionListModel *model = weakSelf.createOrderInitApi.optionList[defaultIndex];
        
        weakSelf.queryOrderMinStartTimeApi = [[ALQueryOrderMinStartTimeApi alloc] initQueryOrderMinStartTimeApi:model.serviceLength];
        
        [weakSelf.queryOrderMinStartTimeApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf initSubviews];
            [weakSelf bindAction];
            weakSelf.choseServerView.selectedIndex = defaultIndex;
            //默认为1人
            weakSelf.consumerInfomationView.serverNumberContentTF.text = @"1人";
            
            [weakSelf removeRequestStatusView];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
    _createOrderInitApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _createOrderInitApi.dataErrorBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusDataError];
    };
}

- (void)queryOrderEstimatedPrice:(NSString *)people length:(NSString *)length {
    AL_WeakSelf(self);
    //预测价格
    ALOrderEstimatedPriceApi *orderEstimatedPriceApi = [[ALOrderEstimatedPriceApi alloc] initWithOrderEstimatedPriceApi:[people stringByReplacingOccurrencesOfString:@"人" withString:@""] serviceLength:length];
    
    [orderEstimatedPriceApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString *estimatedPrice = orderEstimatedPriceApi.data[@"estimatedPrice"];
        NSMutableAttributedString *priceAttString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"预付：¥%@",estimatedPrice)];
        priceAttString.yy_font = ALMediumTitleFont(24);
        priceAttString.yy_color = [UIColor colorWithRGB:0xF8504F];
        [priceAttString yy_setTextHighlightRange:NSMakeRange(0, 3) color:[UIColor colorWithRGBA:ALLabelTextColor] backgroundColor:nil userInfo:nil];
        [priceAttString yy_setFont:ALThemeFont(16) range:NSMakeRange(0, 3)];
        
        weakSelf.priceLab.attributedText = priceAttString;
        
        [weakSelf setStartTimeConetent];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [ALKeyWindow showHudError:@"订单创建失败～"];
    }];
}

- (void)reloadData {
    [self loadData];
}

- (void)initSubviews {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
        make.bottom.equalTo(@-120);
    }];
    
    [self.choseServerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@160);
    }];
    
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.equalTo(self.choseServerView.mas_bottom).offset(10);
        make.height.equalTo(@91);
    }];
    
    [self.consumerInfomationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).offset(-22);
        make.top.equalTo(self.addressView.mas_bottom).offset(10);
        make.height.equalTo(@180);
    }];
    
    [self.serverNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).offset(-22);
        make.height.equalTo(@45);
    }];

    [self.startTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serverNumberView.mas_bottom).offset(10);
        make.leading.right.height.equalTo(self.serverNumberView);
    }];
    
    self.serverNumberView.hidden = YES;
    self.startTimeView.hidden = YES;
    
//    [self.scrollView layoutIfNeeded];
    
    [self.safeProtectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.consumerInfomationView.mas_bottom).offset(10);
        make.height.equalTo(@72);
        make.leading.right.equalTo(self.consumerInfomationView);
    }];
    
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safeProtectView.mas_bottom).offset(10);
        make.height.equalTo(@90);
        make.leading.right.equalTo(self.consumerInfomationView);
    }];
    
    [self.mesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView);
        make.top.equalTo(self.commentView.mas_bottom).offset(15);
    }];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@120);
        make.bottom.equalTo(@0);
    }];
    
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-10);
        make.left.equalTo(@11);
        make.right.equalTo(@-11);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shadowView);
        make.top.equalTo(@20);
    }];
    
    [self.view layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.mesLab.frame) + 15);
}

- (void)bindAction {
    AL_WeakSelf(self);
    
    self.choseServerView.didSelectedBlock = ^(NSUInteger index) {
        [weakSelf queryOrderEstimatedPrice:weakSelf.consumerInfomationView.serverNumberContentTF.text length:weakSelf.choseServerView.currentLength];
        [weakSelf setStartTimeConetent];
    };
    
    self.serverNumberView.clickBlock = ^ {
        
        NSMutableArray *serviceNumList = [NSMutableArray array];
        
        for (NSDictionary *dic in weakSelf.createOrderInitApi.data[@"serviceNumList"]) {
            [serviceNumList addObject:dic[@"num"]];
        }
        
        ALChoseToolView *serverNumberView = [[ALChoseToolView alloc] initWithFrame:CGRectZero type:ALChoseToolTypeServerNumber];
        serverNumberView.dataArray = serviceNumList;
        [serverNumberView showBottomView];
        
        serverNumberView.didSelectedBlock = ^(NSUInteger index) {
            [MobClick event:ALMobEventID_D1];
            weakSelf.serverNumberView.contentString = ALStringFormat(@"%@人",serviceNumList[index]);
            [weakSelf queryOrderEstimatedPrice:weakSelf.serverNumberView.contentString length:weakSelf.choseServerView.currentLength];
        };
    };
    
    self.startTimeView.clickBlock = ^{
        NSUInteger minStartTime = [weakSelf.queryOrderMinStartTimeApi.data[@"minStartTime"] integerValue];
        NSDate *minDate = [NSDate dateWithTimeIntervalSince1970:minStartTime];
        NSDate *maxDate = [minDate dateByAddingWeeks:1];
        
        ALChoseToolView *serverNumberView = [[ALChoseToolView alloc] initWithFrame:CGRectZero type:ALChoseToolTypeStartTime];
        serverNumberView.dataArray = @[minDate,maxDate];
        [serverNumberView showBottomView];
        
        serverNumberView.didDateSelectedBlock = ^(NSString *string) {
            [MobClick event:ALMobEventID_D2];
            weakSelf.startTimeView.contentString = string;
        };
    };
    
    self.serverTimeView.clickBlock = ^ {
        ALChoseToolView *severTimeView = [[ALChoseToolView alloc] initWithFrame:CGRectZero type:ALChoseToolTypeServerTime];
        NSMutableArray *lengthArr = [NSMutableArray array];
        for (ALServiceLengthModel *model in weakSelf.createOrderInitApi.serviceLengthModelArray) {
            [lengthArr addObject:model.lengthDes];
        }
        severTimeView.dataArray = lengthArr;
        [severTimeView showBottomView];
        
        severTimeView.didSelectedBlock = ^(NSUInteger index) {
            [MobClick event:ALMobEventID_D3];
            weakSelf.serverTimeView.contentString = weakSelf.createOrderInitApi.serviceLengthModelArray[index].lengthDes;
            [weakSelf queryOrderEstimatedPrice:weakSelf.serverNumberView.contentString length:weakSelf.choseServerView.currentLength];
        };
    };
}

#pragma mark Action
- (void)nextStepAction {

    AL_WeakSelf(self);
    NSString *preStartTime = self.startTimeView.contentString;
    //创建订单
    if([self.startTimeView.contentString containsString:@"今天"]) {
        NSString *ymdString = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
        preStartTime = [preStartTime stringByReplacingOccurrencesOfString:@"今天" withString:ymdString];
    } else {
        preStartTime = [preStartTime stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
        preStartTime = [preStartTime stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
        preStartTime = [preStartTime stringByReplacingOccurrencesOfString:@"日" withString:@""];
    }
    ALCreateOrderApi *createOrderApi = [ALCreateOrderApi new];
//    [[ALCreateOrderApi alloc] initWithCreateOrderApi:[self.addressView.serverAddressContentTF.text stringByAppendingString:self.addressView.streeTF.text] contactsPhone:self.addressView.telephoneContenTF.text contactsName:self.addressView.linkManContenTF.text contactsSex:self.addressView.manBtn.selected ? @0 : @1 securityNum:[self.serverNumberView.contentString stringByReplacingOccurrencesOfString:@"人" withString:@""] serviceLength:self.choseServerView.currentLength serviceAddressPoint:ALStringFormat(@"%lf,%lf",weakSelf.pt.longitude,weakSelf.pt.latitude) preStartTime:preStartTime orderMessage:self.commentView.textString];
    
    if([self.commentView.textString isVaild]) {
        [MobClick event:ALMobEventID_D5];
    }
    
    [createOrderApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ALOrderModel *orderModel = [[ALOrderModel alloc] init];
        orderModel.orderStatus = OrderStautsNew;
        orderModel.orderId = createOrderApi.data[@"orderId"];
        orderModel.hasAvaCoupon = createOrderApi.data[@"hasAvaCoupon"];
        orderModel.orderPrice = [weakSelf.priceLab.text substringFromIndex:3];
        orderModel.expireInterval = createOrderApi.data[@"expireInterval"];
        
        ALOrderInfoViewController *stepThreeVC = [[ALOrderInfoViewController alloc]init];
        stepThreeVC.orderModel = orderModel;
        [MobClick event:ALMobEventID_D7];
        [ALKeyWindow.rootViewController presentViewController:[[ALBaseNavigationController alloc] initWithRootViewController:stepThreeVC] animated:YES completion:^{
            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
        }];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [ALKeyWindow showHudError:@"订单创建失败～"];
    }];
}

//设置开始时间
- (void)setStartTimeConetent {
    self.queryOrderMinStartTimeApi = [[ALQueryOrderMinStartTimeApi alloc] initQueryOrderMinStartTimeApi:self.choseServerView.currentLength];
    
    AL_WeakSelf(self);
    [self.queryOrderMinStartTimeApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSTimeInterval minStartTime = [weakSelf.queryOrderMinStartTimeApi.data[@"minStartTime"] doubleValue];
        NSDate *selected = [NSDate dateWithTimeIntervalSince1970:minStartTime];
        
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        
        if(selected.year == today.year && selected.month == today.month && selected.day == today.day) {
            [dateFormatter setDateFormat:@"今天 HH:mm"];
        }
        NSString *currentOlderOneDateStr = [dateFormatter stringFromDate:selected];
        
        weakSelf.consumerInfomationView.startTimeContentTF.text = currentOlderOneDateStr;
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark ALAddressDelegate
- (void)consumerInfomationLineDidSelected:(ALConsumerInfomationDidSelected)type {
    AL_WeakSelf(self);

    if(type == ALConsumerInfomationDidSelectedServerNumber) {
        NSMutableArray *serviceNumList = [NSMutableArray array];
        
        for (NSDictionary *dic in weakSelf.createOrderInitApi.data[@"serviceNumList"]) {
            [serviceNumList addObject:dic[@"num"]];
        }
        
        ALChoseToolView *serverNumberView = [[ALChoseToolView alloc] initWithFrame:CGRectZero type:ALChoseToolTypeServerNumber];
        serverNumberView.dataArray = serviceNumList;
        [serverNumberView showBottomView];
        
        serverNumberView.didSelectedBlock = ^(NSUInteger index) {
            [MobClick event:ALMobEventID_D1];
            weakSelf.consumerInfomationView.serverNumberContentTF.text = ALStringFormat(@"%@人",serviceNumList[index]);
            [weakSelf queryOrderEstimatedPrice:weakSelf.consumerInfomationView.serverNumberContentTF.text length:weakSelf.choseServerView.currentLength];
        };
    } else if(type == ALConsumerInfomationDidSelectedStartTime) {
        NSUInteger minStartTime = [weakSelf.queryOrderMinStartTimeApi.data[@"minStartTime"] integerValue];
        NSDate *minDate = [NSDate dateWithTimeIntervalSince1970:minStartTime];
        NSDate *maxDate = [minDate dateByAddingWeeks:1];
        
        ALChoseToolView *serverNumberView = [[ALChoseToolView alloc] initWithFrame:CGRectZero type:ALChoseToolTypeStartTime];
        serverNumberView.dataArray = @[minDate,maxDate];
        [serverNumberView showBottomView];
        
        serverNumberView.didDateSelectedBlock = ^(NSString *string) {
            [MobClick event:ALMobEventID_D2];
            weakSelf.consumerInfomationView.startTimeContentTF.text = string;
        };
    } else {
        [[LJContactManager sharedInstance] selectContactAtController:self complection:^(NSString *name, NSString *phone) {
            //            weakSelf.addressView.telephoneContenTF.text = phone;
            //            weakSelf.addressView.linkManContenTF.text = name;
        }];
    }
}

#pragma mark ALChoseAddressDelegate
- (void)getServerAddressInLocation:(BMKPoiInfo *)model {
    self.addressView.serverAddressContentTF.text = model.name;
    self.addressView.streeTF.text = model.address;
    self.pt = model.pt;
}

#pragma mark lazy load
- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (ALChoseSeverView *)choseServerView {
    if(!_choseServerView) {
        _choseServerView = [[ALChoseSeverView alloc] initWithFrame:CGRectZero array:self.createOrderInitApi.optionList];
        [self.scrollView addSubview:_choseServerView];
    }
    return _choseServerView;
}

- (ALConsumerInfomationView *)consumerInfomationView {
    if(!_consumerInfomationView) {
        _consumerInfomationView = [[ALConsumerInfomationView alloc] init];
        _consumerInfomationView.delegate = self;
        [self.scrollView addSubview:_consumerInfomationView];
        _consumerInfomationView.serverNumberContentTF.text = @"1人";
    }
    return _consumerInfomationView;
}

- (ALAddressView *)addressView {
    if(!_addressView) {
        _addressView = [[ALAddressView alloc] init];
        [self.view addSubview:_addressView];
        
        AL_WeakSelf(self);
        _addressView.serverAddressClickBlock = ^{
            ALChoseAddressViewController *choseAddressVC = [[ALChoseAddressViewController alloc] init];
            choseAddressVC.choseAddressDelegate = weakSelf;
            [weakSelf.navigationController pushViewController:choseAddressVC animated:YES];
        };
    }
    return _addressView;
}

- (ALSafeProtectView *)safeProtectView {
    if(!_safeProtectView) {
        _safeProtectView = [[ALSafeProtectView alloc]init];
        [self.scrollView addSubview:_safeProtectView];
    }
    return _safeProtectView;
}

- (ALShadowView *)serverNumberView {
    if(!_serverNumberView) {
        _serverNumberView = [[ALShadowView alloc] initWithFrame:CGRectZero title:@"服务人数" content:@"1人" type:ALShadowStyleDoubleLabel];
        [self.scrollView addSubview:_serverNumberView];
    }
    return _serverNumberView;
}

- (ALShadowView *)serverTimeView {
    if(!_serverTimeView) {
        _serverTimeView = [[ALShadowView alloc] initWithFrame:CGRectZero title:@"服务时长" content:@"1小时" type:ALShadowStyleDoubleLabel];
        [self.scrollView addSubview:_serverTimeView];
    }
    return _serverTimeView;
}

- (ALShadowView *)startTimeView {
    if(!_startTimeView) {
        _startTimeView = [[ALShadowView alloc] initWithFrame:CGRectZero title:@"开始时间" content:@"" type:ALShadowStyleStartTime];
        [self.scrollView addSubview:_startTimeView];
    }
    return _startTimeView;
}

- (ALLabel *)mesLab {
    if(!_mesLab) {
        _mesLab = [[ALLabel alloc] init];
        _mesLab.text = @" 呼叫镖镖：最早开始服务时间为当前下单时间2小时后";
        _mesLab.textColor = [UIColor colorWithRGBA:0x999999FF];
        _mesLab.font = ALThemeFont(13);
        [self.scrollView addSubview:_mesLab];
    }
    return _mesLab;
}

- (ALShadowView *)shadowView {
    if(!_shadowView) {
        _shadowView = [[ALShadowView alloc] init];
        [self.view addSubview:_shadowView];
    }
    return _shadowView;
}

- (ALLabel *)priceLab {
    if(!_priceLab) {
        _priceLab = [[ALLabel alloc] init];
        _priceLab.attributedText = [[NSAttributedString alloc] initWithString:@"预付："];
        [self.shadowView addSubview:_priceLab];
    }
    return _priceLab;
}

- (ALShadowView *)commentView {
    if(!_commentView) {
        _commentView = [[ALShadowView alloc] initWithTextView:CGRectZero placeholder:@"备注：如身高、技能等" type:ALShadowStyleTextView];
        [self.scrollView addSubview:_commentView];
    }
    return _commentView;
}

- (ALActionButton *)nextStepBtn {
    if(!_nextStepBtn) {
        _nextStepBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        [_nextStepBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_nextStepBtn addTarget:self action:@selector(nextStepAction) forControlEvents:UIControlEventTouchUpInside];
        [self.shadowView addSubview:_nextStepBtn];
    }
    return _nextStepBtn;
}

@end

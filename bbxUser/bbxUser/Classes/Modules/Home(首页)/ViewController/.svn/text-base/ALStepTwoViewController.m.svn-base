//
//  ALStepTwoViewController.m
//  AnyHelp
//
//  Created by along on 2017/7/27.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALStepTwoViewController.h"
#import "ALOrderInfoViewController.h"
#import "ALStepView.h"
#import "ALCreateOrderApi.h"
#import "ALOrderEstimatedPriceApi.h"
#import "ALOrderModel.h"
#import "ALServerTagViewController.h"
#import "ALCreateOrderInitApi.h"
#import "ALMoneyInfoView.h"
#import "ALChoseSeverView.h"
#import "ALAdditionalDemandView.h"
#import "ALQueryOrderMinStartTimeApi.h"

@interface ALStepTwoViewController () //<ALServerTagDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
//顶部标题
@property (nonatomic, strong) ALStepView *stepView;
//选择服务
@property (nonatomic, strong) ALChoseSeverView *choseServerView;
//服务人数
@property (nonatomic, strong) ALShadowView *serverNumberView;
//开始时间
@property (nonatomic, strong) ALShadowView *startTimeView;
//服务时间
@property (nonatomic, strong) ALShadowView *serverTimeView;
////服务标签
//@property (nonatomic, strong) ALShadowView *tagView;
////额外需求
//@property (nonatomic, strong) ALAdditionalDemandView *additionalDemandView;
//备注
@property (nonatomic, strong) ALShadowView *commentView;

//提示文字
@property (nonatomic, strong) ALLabel *mesLab;
//底部view
@property (nonatomic, strong) ALShadowView *shadowView;
@property (nonatomic, strong) ALLabel *priceLab;
@property (nonatomic, strong) UIButton *priceInfoBtn;
@property (nonatomic, strong) ALActionButton *nextStepBtn;

@property (nonatomic, strong) ALCreateOrderInitApi *createOrderInitApi;
@property (nonatomic, strong) ALQueryOrderMinStartTimeApi *queryOrderMinStartTimeApi;
@end

@implementation ALStepTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.title = @"呼叫镖镖";
    
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
            weakSelf.serverNumberView.contentString = @"1人";
            
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
        NSMutableAttributedString *priceAttString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"金额：¥%@",estimatedPrice)];
        priceAttString.yy_font = ALMediumTitleFont(24);
        priceAttString.yy_color = [UIColor colorWithRGB:0xF8504F];
        [priceAttString yy_setTextHighlightRange:NSMakeRange(0, 3) color:[UIColor colorWithRGBA:ALLabelTextColor] backgroundColor:nil userInfo:nil];
        [priceAttString yy_setFont:ALThemeFont(14) range:NSMakeRange(0, 3)];
        
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
    [self.stepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@75);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stepView.mas_bottom);
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
    
    [self.serverNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.choseServerView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).offset(-22);
        make.height.equalTo(@45);
    }];
    
    [self.startTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serverNumberView.mas_bottom).offset(10);
        make.leading.right.height.equalTo(self.serverNumberView);
    }];
    
//    [self.serverTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.startTimeView.mas_bottom).offset(10);
//        make.leading.right.height.equalTo(self.startTimeView);
//    }];
    
//    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.startTimeView.mas_bottom).offset(10);
//        make.leading.right.height.equalTo(self.startTimeView);
//    }];
    
    [self.scrollView layoutIfNeeded];
    
//    _additionalDemandView = [[ALAdditionalDemandView alloc] initWithFrame:CGRectMake(11, CGRectGetMaxY(self.tagView.frame) + 10, ALScreenWidth - 22, 0) dataArray:self.createOrderInitApi.exRequireList];
//    [self.scrollView addSubview:_additionalDemandView];
//
//    _additionalDemandView.frame = CGRectMake(11, CGRectGetMaxY(self.tagView.frame) + 10, ALScreenWidth - 22, _additionalDemandView.clickedLabelView.maxY + 30);
    
    [self.scrollView layoutIfNeeded];
    
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGRectGetMaxY(self.startTimeView.frame) + 10);
        make.height.equalTo(@90);
        make.leading.right.equalTo(self.startTimeView);
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
    
    [self.priceInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceLab);
        make.right.equalTo(@-30);
    }];
    
    [self.view layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.mesLab.frame) + 15);
}

- (void)bindAction {
    AL_WeakSelf(self);
    
    self.choseServerView.didSelectedBlock = ^(NSUInteger index) {
        [weakSelf queryOrderEstimatedPrice:weakSelf.serverNumberView.contentString length:weakSelf.choseServerView.currentLength];
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
    
//    self.tagView.clickBlock = ^{
//        ALServerTagViewController *serverTagVC = [[ALServerTagViewController alloc] init];
//        serverTagVC.tagArray = weakSelf.createOrderInitApi.skillTagListArray;
//        serverTagVC.delegate = weakSelf;
//        serverTagVC.tagString = weakSelf.tagView.contentString;
//        [weakSelf.navigationController pushViewController:serverTagVC animated:YES];
//    };
}

//#pragma mark ALServerTagDelegate
//- (void)getAllSelectedTag:(NSString *)tagString {
//    self.tagView.contentString = tagString;
//}

#pragma mark Action
- (void)nextStepAction {
//    if([self.tagView.contentString isEqualToString:@"请选择服务类型"]) {
//        [ALKeyWindow showHudError:@"请选择服务类型～"];
//        return;
//    }

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
    ALCreateOrderApi *createOrderApi = [[ALCreateOrderApi alloc] initWithCreateOrderApi:self.serviceAddress contactsPhone:self.contactsPhone contactsName:self.contactsName contactsSex:self.contactsSex securityNum:[self.serverNumberView.contentString stringByReplacingOccurrencesOfString:@"人" withString:@""] serviceLength:self.choseServerView.currentLength serviceAddressPoint:ALStringFormat(@"%lf,%lf",weakSelf.pt.longitude,weakSelf.pt.latitude) preStartTime:preStartTime orderMessage:self.commentView.textString];
    
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
        
        weakSelf.startTimeView.contentString = currentOlderOneDateStr;
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
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

- (ALStepView *)stepView {
    if(!_stepView) {
        _stepView = [[ALStepView alloc] initWithFrame:CGRectZero title:@"第二步骤" subTitle:@"请选择相关服务"];
        [self.view addSubview:_stepView];
    }
    return _stepView;
}

- (ALChoseSeverView *)choseServerView {
    if(!_choseServerView) {
        _choseServerView = [[ALChoseSeverView alloc] initWithFrame:CGRectZero array:self.createOrderInitApi.optionList];
        [self.scrollView addSubview:_choseServerView];
    }
    return _choseServerView;
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

//- (ALShadowView *)tagView {
//    if(!_tagView) {
//        _tagView = [[ALShadowView alloc] initWithFrame:CGRectZero title:@"服务标签" content:@"请选择服务类型" type:ALShadowStyleTagView];
//        [self.scrollView addSubview:_tagView];
//    }
//    return _tagView;
//}

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
        _priceLab.attributedText = [[NSAttributedString alloc] initWithString:@"金额："];
        [self.shadowView addSubview:_priceLab];
    }
    return _priceLab;
}

- (UIButton *)priceInfoBtn {
    if(!_priceInfoBtn) {
        _priceInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_priceInfoBtn setBackgroundImage:[UIImage imageNamed:@"mingxi"] forState:UIControlStateNormal];
        [self.shadowView addSubview:_priceInfoBtn];
        
        AL_WeakSelf(self);
        [_priceInfoBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [MobClick event:ALMobEventID_D6];
            NSInteger index = [weakSelf.createOrderInitApi.data[@"defaultIndex"] integerValue];
            ALOptionListModel *model = weakSelf.createOrderInitApi.optionList[index];
            
            ALMoneyInfoView *moneyInfoView = [[ALMoneyInfoView alloc] initWithFrame:CGRectZero money:[weakSelf.priceLab.text stringByReplacingOccurrencesOfString:@"金额：" withString:@""] length:model.serviceLength num:[weakSelf.serverNumberView.contentString stringByReplacingOccurrencesOfString:@"服务人数：" withString:@""]];
            [moneyInfoView show];
        }];
    }
    return _priceInfoBtn;
}

- (ALShadowView *)commentView {
    if(!_commentView) {
        _commentView = [[ALShadowView alloc] initWithTextView:CGRectZero placeholder:@"给镖师捎句话" type:ALShadowStyleTextView];
        [self.scrollView addSubview:_commentView];
    }
    return _commentView;
}

- (ALActionButton *)nextStepBtn {
    if(!_nextStepBtn) {
        _nextStepBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        [_nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextStepBtn addTarget:self action:@selector(nextStepAction) forControlEvents:UIControlEventTouchUpInside];
        [self.shadowView addSubview:_nextStepBtn];
    }
    return _nextStepBtn;
}
@end

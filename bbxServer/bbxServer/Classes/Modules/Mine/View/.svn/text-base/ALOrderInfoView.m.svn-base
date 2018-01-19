//
//  ALOrderInfoView.m
//  bbxServer
//
//  Created by along on 2017/8/30.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALOrderInfoView.h"
#import "WSStarRatingView.h"

@interface ALOrderInfoView ()
@property (nonatomic, strong) ALOrderModel *model;

@property (nonatomic, strong) ALLabel *titleLab;
@property (nonatomic, strong) UIView *orderLineView;

@end

@implementation ALOrderInfoView

- (instancetype)initWithFrame:(CGRect)frame model:(ALOrderModel *)model {
    if(self = [super init]) {
        ALLabel *orderInfoLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        orderInfoLab.text = @"订单信息";
        [self addSubview:orderInfoLab];
        
        [orderInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@14);
        }];
        
        ALLabel *orderStatusLab = [[ALLabel alloc] init];
        orderStatusLab.text = model.orderStatusDes;
        [self addSubview:orderStatusLab];
        
        [orderStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(orderInfoLab);
            make.right.equalTo(@-14);
        }];
        
        UIView *hLineView = [[UIView alloc] init];
        hLineView.backgroundColor = [UIColor colorWithRGBA:ALVCbgColor];
        [self addSubview:hLineView];
        
        [hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@1);
            make.top.equalTo(orderInfoLab.mas_bottom).offset(8);
        }];
        
        //下单时间
        ALLabel *orderTimeLab = [[ALLabel alloc] init];
        orderTimeLab.text = @"开始时间";
        [self addSubview:orderTimeLab];
        
        [orderTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(hLineView.mas_bottom).offset(15);
            CGFloat width = [orderTimeLab.text widthForFont:orderTimeLab.font] + 0.5;
            make.width.equalTo(@(width));
        }];
        
        ALLabel *orderTime = [[ALLabel alloc] init];
        orderTime.text = model.preStartTime;
        orderTime.textAlignment = NSTextAlignmentLeft;
        orderTime.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        [self addSubview:orderTime];
        
        [orderTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orderTimeLab.mas_right).offset(12);
            make.right.equalTo(@-14);
            make.centerY.equalTo(orderTimeLab);
        }];
        
        //服务时长
        ALLabel *serverTimeLab = [[ALLabel alloc] init];
        serverTimeLab.text = @"服务时长";
        [self addSubview:serverTimeLab];
        
        [serverTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(orderTime.mas_bottom).offset(15);
        }];
        
        ALLabel *serverTime = [[ALLabel alloc] init];
        serverTime.textAlignment = NSTextAlignmentLeft;
        serverTime.text = ALStringFormat(@"%@小时   %@人",model.serviceLength,model.securityNum);
        serverTime.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        [self addSubview:serverTime];
        
        [serverTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(orderTime);
            make.right.equalTo(@-14);
            make.centerY.equalTo(serverTimeLab);
        }];
        
        //联系人
        ALLabel *linkManLab = [[ALLabel alloc] init];
        linkManLab.text = @"联系人";
        [self addSubview:linkManLab];
        
        [linkManLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(serverTime.mas_bottom).offset(15);
        }];
        
        ALLabel *linkMan = [[ALLabel alloc] init];
        linkMan.textAlignment = NSTextAlignmentLeft;
        linkMan.text = ALStringFormat(@"%@   %@",model.contactsName,model.contactsPhone);
        linkMan.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        [self addSubview:linkMan];
        
        [linkMan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(orderTime);
            make.right.equalTo(@-14);
            make.centerY.equalTo(linkManLab);
        }];
        
        //服务地址
        ALLabel *serverAddressLab = [[ALLabel alloc] init];
        serverAddressLab.text = @"服务地址";
        [self addSubview:serverAddressLab];
        
        [serverAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(linkMan.mas_bottom).offset(15);
        }];
        
        ALLabel *serverAddress = [[ALLabel alloc] init];
        serverAddress.textAlignment = NSTextAlignmentLeft;
        serverAddress.text = model.seviceAddress;
        serverAddress.numberOfLines = 0;
        serverAddress.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        [self addSubview:serverAddress];
        
        [serverAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(orderTime);
            make.right.equalTo(@-14);
            make.top.equalTo(serverAddressLab);
        }];
        
        //线2
        UIView *hLineView2 = [[UIView alloc] init];
        hLineView2.backgroundColor = [UIColor colorWithRGBA:ALVCbgColor];
        [self addSubview:hLineView2];
        
        [hLineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@1);
            make.top.equalTo(serverAddress.mas_bottom).offset(8);
        }];
        
        //订单号
        ALLabel *orderIdLab = [[ALLabel alloc] init];
        orderIdLab.text = @"订单号";
        [self addSubview:orderIdLab];
        
        [orderIdLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(hLineView2.mas_bottom).offset(15);
        }];
        
        ALLabel *orderId = [[ALLabel alloc] init];
        orderId.textAlignment = NSTextAlignmentLeft;
        orderId.text = model.orderId;
        orderId.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        [self addSubview:orderId];
        
        [orderId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(orderTime);
            make.right.equalTo(@-14);
            make.centerY.equalTo(orderIdLab);
        }];
        
    }
    return self;
}

- (instancetype)initWithSecurityFrame:(CGRect)frame model:(ALOrderModel *)model {
    if(self = [super initWithFrame:frame]) {
        _model = model;
        [self initSecurityList:NO];
    }
    return self;
}

- (instancetype)initWithShowCallBtnSecurityFrame:(CGRect)frame model:(ALOrderModel *)model {
    if(self = [super initWithFrame:frame]) {
        _model = model;
        [self initSecurityList:YES];
    }
    return self;
}

//接单镖师
- (void)initSecurityList:(BOOL)showCallBtn {
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@10);
    }];
    
    [self.orderLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(self.titleLab.mas_bottom).offset(6);
    }];
    
    NSArray *securityList = _model.securityList;
    
    UIView *lastView = nil;
    
    AL_WeakSelf(self);
    
    for (unsigned int i = 0; i < securityList.count; i++) {
        
        ALSecurityModel *securityModel = _model.securityList[i];
        
        //每一行的view
        UIView *itemView = [[UIView alloc] init];
        [self addSubview:itemView];
        
        UIImageView *headIV = [[UIImageView alloc] init];
        headIV.contentMode = UIViewContentModeScaleAspectFill;
        headIV.userInteractionEnabled = YES;
        headIV.layer.masksToBounds = YES;
        headIV.layer.cornerRadius = 48/2.0;
        [itemView addSubview:headIV];
        
        [headIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(itemView);
            make.left.equalTo(@15);
            make.size.mas_equalTo(CGSizeMake(48, 48));
        }];
        [headIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,securityModel.icon)]];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(weakSelf.multiItemBlock) {
                weakSelf.multiItemBlock(i);
            }
        }];
        [headIV addGestureRecognizer:tapGesture];
        
        ALLabel *nameLab = [[ALLabel alloc] init];
        nameLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        nameLab.font = ALThemeFont(16);
        [itemView addSubview:nameLab];
        
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headIV.mas_right).offset(25);
            make.top.equalTo(headIV).offset(5);
        }];
        
        if([securityModel.securityId isEqualToString:AL_MyAppDelegate.userModel.idModel.userId]) {
            nameLab.text = @"我";
        } else {
            nameLab.text = securityModel.realName;
            
            if(showCallBtn) {
                UIButton *callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [callBtn setBackgroundImage:[UIImage imageNamed:@"btn-contact"] forState:UIControlStateNormal];
                [itemView addSubview:callBtn];
                
                [callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(@-14);
                    make.centerY.equalTo(nameLab);
                }];
                
                [callBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ALStringFormat(@"tel://%@",securityModel.phone)]];
                    });
                }];
            }            
        }
        
        UIImageView *leadIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:securityModel.isLeader.boolValue ? @"icon_leader" : @"icon_member"]];
        [itemView addSubview:leadIV];
        
        [leadIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameLab);
            make.left.equalTo(nameLab.mas_right).offset(5);
        }];
        
        [self layoutIfNeeded];
        
        WSStarRatingView *startRatingView = [[WSStarRatingView alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLab.frame), 40, 78, 14) numberOfStar:5];
        [itemView addSubview:startRatingView];
        startRatingView.userInteractionEnabled = NO;
        [startRatingView setScore:[securityModel.avgRank floatValue] withAnimation:NO];
        
        ALLabel *doOrderNumLab = [[ALLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(startRatingView.frame) + 20, 40 , ALScreenWidth - 28 - CGRectGetMaxX(startRatingView.frame) - 20 - 10, 14)];
        doOrderNumLab.textAlignment = NSTextAlignmentLeft;
        doOrderNumLab.text = ALStringFormat(@"接单数：%@",[securityModel.doOrderNum isVaild] ? securityModel.doOrderNum : @"0");
        doOrderNumLab.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
        [itemView addSubview:doOrderNumLab];
        
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            lastView ? make.top.equalTo(lastView.mas_bottom) : make.top.equalTo(self.orderLineView.mas_bottom);
            make.left.right.equalTo(@0);
            make.height.equalTo(@68);
        }];
        
        if(i != securityList.count - 1) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = [UIColor colorWithRGBA:0xF5F6FAFF];
            [self addSubview:lineView];
            
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@0);
                make.right.equalTo(@0);
                make.height.equalTo(@1);
                make.top.equalTo(itemView.mas_bottom);
            }];
            lastView = lineView;
        }
    }
}

#pragma mark lazy load
- (ALLabel *)titleLab {
    if(!_titleLab) {
        _titleLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _titleLab.font = ALMediumTitleFont(12);
        _titleLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
        [self addSubview:_titleLab];
        
        _titleLab.text = ALStringFormat(@"服务人数(%@)",_model.securityNum);
    }
    return _titleLab;
}

- (UIView *)orderLineView {
    if(!_orderLineView) {
        _orderLineView = [[UIView alloc] init];
        _orderLineView.backgroundColor = [UIColor colorWithRGBA:0xF5F6FAFF];
        [self addSubview:_orderLineView];
    }
    return _orderLineView;
}

@end

//
//  ALOrderInfoView.m
//  AnyHelp
//
//  Created by along on 2017/7/27.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALOrderInfoView.h"
#import "WSStarRatingView.h"

@interface ALOrderInfoView ()
@property (nonatomic, assign) ALOrderInfoStyle style;
//订单信息
@property (nonatomic, strong) ALLabel *titleLab;
@property (nonatomic, strong) UIButton *securityLocationBtn;
@property (nonatomic, strong) UIView *orderLineView;
@property (nonatomic, strong) ALLabel *payMoneyLab;
@property (nonatomic, strong) ALLabel *moneyLab;

//红包
@property (nonatomic, strong) ALLabel *redEnvelopeLab;
@property (nonatomic, strong) UIImageView *redEnvelopeIV;
@property (nonatomic, strong) UILabel *subSpriceLab;

@property (nonatomic, strong) UIImageView *rightIV;

@property (nonatomic, strong) ALOrderModel *model;
@end

@implementation ALOrderInfoView

- (instancetype)initWithFrame:(CGRect)frame style:(ALOrderInfoStyle)style model:(ALOrderModel *)model {
    if(self = [super initWithFrame:frame]) {
        _style = style;
        _model = model;
        
        if(style == ALOrderInfoStyleID) {
            
        } else if(style == ALOrderInfoStyleRedEnvelope) {
            AL_WeakSelf(self);
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                if(weakSelf.clickBlock) {
                    weakSelf.clickBlock();
                }
            }];
            
            [self addGestureRecognizer:tapGestureRecognizer];
        } else if (style == ALOrderInfoStylePay) {
            if([WXApi isWXAppInstalled]) {
                [self initPayViewWithImageArray:@[@"wxPay",@"alipay"] titleArray:@[@"微信支付",@"支付宝支付"]];
            } else {
                self.payType = ALPayTypeAliPay;
                [self initPayViewWithImageArray:@[@"alipay"] titleArray:@[@"支付宝支付"]];
            }
        } else if(style == ALOrderInfoStyleInfo) {
            [self initOrderInfoView];
        } else if(style == ALOrderInfoStyleSecurity) {
            [self initSecurityList];
        }
        
    }
    return self;
}

//订单信息
- (void)initOrderInfoView {
    self.titleLab.text = @"订单信息";
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@10);
    }];
    
    [self.orderLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(self.titleLab.mas_bottom).offset(6);
    }];
    
    ALLabel *statusLab = [[ALLabel alloc] init];
    statusLab.text = _model.orderStatusDes;
    statusLab.font = ALThemeFont(13);
    statusLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
    [self addSubview:statusLab];
    
    [statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab);
        make.right.equalTo(@-14);
    }];
    
    NSArray *infoArr = @[@"time",@"fuwu",@"lianxiren",@"dizhi"];
    
    UIView *lastView = nil;
    
    for (unsigned int i = 0; i < infoArr.count; i++) {
        UIImageView *iconIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:infoArr[i]]];
        [self addSubview:iconIV];
        
        ALLabel *label = [[ALLabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
        
        if(i == 0) {
            label.text = _model.preStartTime;
        } else if (i == 1) {
            label.text = ALStringFormat(@"%@小时    %@人",_model.serviceLength,_model.securityNum);
        } else if (i == 2) {
            label.text = ALStringFormat(@"%@ %@",_model.contactsName,_model.contactsPhone);
        } else if (i == 3) {
            label.numberOfLines = 0;
            label.text = _model.seviceAddress;
        }
        
        if(lastView) {
            [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(20, 20));
                make.left.equalTo(self.titleLab);
                make.top.equalTo(lastView.mas_bottom).offset(9);
            }];
        } else {
            [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(20, 20));
                make.left.equalTo(self.titleLab);
                make.top.equalTo(self.orderLineView.mas_bottom).offset(13);
            }];
        }
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconIV.mas_right).offset(14);
            if(i == 3) {
                make.top.equalTo(iconIV);
                make.right.equalTo(@-14);
            } else {
                make.height.equalTo(iconIV);
                make.centerY.equalTo(iconIV);
            }
        }];
        
        lastView = iconIV;
    }
}

//接单镖师
- (void)initSecurityList {
    self.titleLab.text = @"接单镖师";
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@10);
    }];
    
    [self.orderLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(self.titleLab.mas_bottom).offset(6);
    }];
    
    if(![_model.orderStatus isEqualToString:OrderStatusFinished]) {
        [self.securityLocationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLab);
            make.right.equalTo(@-14);
        }];
    }
    
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
        headIV.layer.cornerRadius = 45/2.0;
        [itemView addSubview:headIV];
        
        [headIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,[NSURL URLWithString:securityModel.icon])] placeholderImage:[UIImage imageNamed:@"touxiang_weidenglu"]];
        [headIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(itemView);
            make.left.equalTo(@15);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        
        //添加点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(weakSelf.itemDidSelectedAtIndex) {
                weakSelf.itemDidSelectedAtIndex(i);
            }
        }];
        
        [headIV addGestureRecognizer:tapGesture];
        
        ALLabel *nameLab = [[ALLabel alloc] init];
        nameLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        nameLab.text = securityModel.realName;
        nameLab.font = ALThemeFont(16);
        [itemView addSubview:nameLab];
        
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headIV.mas_right).offset(25);
            make.top.equalTo(headIV);
        }];
        
        UIImageView *leadIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:securityModel.isLeader.boolValue ? @"icon_leader" : @"icon_member"]];
        [itemView addSubview:leadIV];
        
        [leadIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameLab);
            make.left.equalTo(nameLab.mas_right).offset(5);
        }];
        
        [self layoutIfNeeded];
        
        WSStarRatingView *startRatingView = [[WSStarRatingView alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLab.frame), 35, 78, 14) numberOfStar:5];
        [itemView addSubview:startRatingView];
        startRatingView.userInteractionEnabled = NO;
        [startRatingView setScore:[securityModel.avgRank floatValue] withAnimation:NO];
        
        ALLabel *doOrderNumLab = [[ALLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(startRatingView.frame) + 20, 35 , ALScreenWidth - 28 - CGRectGetMaxX(startRatingView.frame) - 20 - 10, 14)];
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

//支付
- (void)initPayViewWithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray {
    
    int itemCount = (int)imageArray.count;
    
    UIView *lastView = nil;
    AL_WeakSelf(self);
    
    for (unsigned int i = 0; i < imageArray.count; i++) {
        UIView *item = [[UIView alloc] init];
        item.userInteractionEnabled = YES;
        item.backgroundColor = [UIColor clearColor];
        [self addSubview:item];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(UITapGestureRecognizer *sender) {
            UIButton *wxBtn = [self viewWithTag:10];
            UIButton *aliBtn = [self viewWithTag:11];
            if(sender.view.tag == 20) {
                [weakSelf selectAction:wxBtn];
            } else {
                [weakSelf selectAction:aliBtn];
            }
        }];
        [item addGestureRecognizer:tapGesture];
        item.tag = i + 20;
        
        //icon
        UIImageView *iconIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageArray[i]]];
        [item addSubview:iconIV];
        
        [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(item);
            make.left.equalTo(@14);
        }];
        
        //title
        ALLabel *titleLab = [[ALLabel alloc] init];
        titleLab.text = titleArray[i];
        [item addSubview:titleLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(item);
            make.left.equalTo(iconIV.mas_right).offset(10);
        }];
        
        //tap button
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"select_nor"] forState:UIControlStateNormal];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"select_sel"] forState:UIControlStateSelected];
        [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        i == 0 ? (selectBtn.selected = YES) : (selectBtn.selected = NO);
        selectBtn.tag = i + 10;
        [item addSubview:selectBtn];
        
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(item);
            make.right.equalTo(@-20);
        }];
        
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if(lastView) {
                [item mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(lastView);
                    make.right.left.equalTo(@0);
                    make.top.equalTo(lastView.mas_bottom).offset(1);
                }];
                
            } else {
                make.top.left.right.equalTo(@0);
                float multiplied = 1.0 / itemCount;
                float margin = multiplied - 1;
                make.height.equalTo(self).offset(margin).multipliedBy(multiplied);
            }
        }];
        
        lastView = item;
        
        if(i != itemCount - 1) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = [UIColor colorWithRGBA:0xF5F6FAFF];
            [self addSubview:lineView];
            
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@56);
                make.right.equalTo(@0);
                make.height.equalTo(@1);
                make.top.equalTo(item.mas_bottom);
            }];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(_style == ALOrderInfoStyleID) {
        
        [self.orderLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@1);
            make.top.equalTo(@29);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.top.equalTo(@10);
        }];
        
        [self.payMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.bottom.equalTo(@0);
            make.top.equalTo(self.orderLineView.mas_bottom);
        }];
        
        [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.payMoneyLab);
            make.right.equalTo(@-16);
        }];
    } else if(_style == ALOrderInfoStyleRedEnvelope) {
        [self.redEnvelopeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(@16);
        }];
        
        [self.redEnvelopeIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.redEnvelopeLab.mas_right).offset(10);
        }];
        
        [self.rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(@-16);
        }];
        
        [self.subSpriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.rightIV.mas_left).offset(-10);
        }];
    }
}

- (void)initMoney:(NSString *)price {
    NSMutableAttributedString *resultAttr = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"¥%@",[price stringByReplacingOccurrencesOfString:@"¥" withString:@""])];
    resultAttr.yy_font = ALMediumTitleFont(20);
    resultAttr.yy_color = [UIColor colorWithRGBA:0xF8504FFF];
    [resultAttr yy_setFont:ALThemeFont(14) range:NSMakeRange(0, 1)];
    [resultAttr yy_setKern:@3 range:NSMakeRange(0, 1)];
    _moneyLab.attributedText = resultAttr;
}

- (void)setRedPrice:(NSString *)redPrice {
    _redPrice = redPrice;
    
    float newPrice = [[_model.orderPrice stringByReplacingOccurrencesOfString:@"¥" withString:@""]  floatValue] - [redPrice floatValue];
    if(newPrice <= 0) {
        [self initMoney:@"0"];
    } else {
        [self initMoney:ALStringFormat(@"%.2lf",newPrice)];
    }
}

- (void)setDisCount:(NSString *)disCount {
    _disCount = disCount;
    if([disCount isEqualToString:@"-1"]) {
        _subSpriceLab.text = @"";
    } else {
        _subSpriceLab.font = ALThemeFont(14);
        _subSpriceLab.textColor = [UIColor colorWithRGBA:0xF8504FFF];
        _subSpriceLab.text = ALStringFormat(@"- ¥%@",disCount);
    }
}

#pragma mark Action 
- (void)selectAction:(UIButton *)sender {
    UIButton *wxBtn = [self viewWithTag:10];
    UIButton *aliBtn = [self viewWithTag:11];
    
    if(sender == wxBtn) {
        wxBtn.selected = YES;
        aliBtn.selected = NO;
        _payType = ALPayTypeWeiXinPay;
    } else {
        wxBtn.selected = NO;
        aliBtn.selected = YES;
        _payType = ALPayTypeAliPay;
    }
}

#pragma mark lazy load
//订单id
- (ALLabel *)titleLab {
    if(!_titleLab) {
        _titleLab = [[ALLabel alloc] init];
        _titleLab.font = ALThemeFont(12);
        [self addSubview:_titleLab];
        
        _titleLab.text = ALStringFormat(@"订单编号：%@",_model.orderId);
    }
    return _titleLab;
}

- (UIButton *)securityLocationBtn {
    if(!_securityLocationBtn) {
        _securityLocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_securityLocationBtn setTitle:@"保镖实时位置 >" forState:UIControlStateNormal];
        [_securityLocationBtn setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateNormal];
        _securityLocationBtn.titleLabel.font = ALThemeFont(13);
        [self addSubview:_securityLocationBtn];
        AL_WeakSelf(self);
        [_securityLocationBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if(weakSelf.itemDidSelectedAtIndex) {
                weakSelf.itemDidSelectedAtIndex(999);
            }
        }];
    }
    return _securityLocationBtn;
}

- (UIView *)orderLineView {
    if(!_orderLineView) {
        _orderLineView = [[UIView alloc] init];
        _orderLineView.backgroundColor = [UIColor colorWithRGBA:0xF5F6FAFF];
        [self addSubview:_orderLineView];
    }
    return _orderLineView;
}

- (ALLabel *)payMoneyLab {
    if(!_payMoneyLab) {
        _payMoneyLab = [[ALLabel alloc] init];
        if([_model.orderStatus isEqualToString:OrderStatusWaitPay] || [_model.orderStatus isEqualToString:OrderStatusCancel] || [_model.orderStatus isEqualToString:OrderStatusTimeOut]) {
            if([_model.orderType isEqualToString:@"1"]) {
                _payMoneyLab.text = @"总金额";
            } else {
                _payMoneyLab.text = @"预支付";
            }
        } else if([_model.orderStatus isEqualToString:OrderStatusFinished]) {
            _payMoneyLab.text = @"总金额";
        } else if([_model.orderStatus isEqualToString:OrderStatusZ]) {
            _payMoneyLab.text = @"余额支付";
        } else {
            _payMoneyLab.text = @"预支付";
            if([_model.orderType isEqualToString:@"1"]) {
                _payMoneyLab.text = @"总金额";
            }
        }
        [self addSubview:_payMoneyLab];
    }
    return _payMoneyLab;
}

- (ALLabel *)moneyLab {
    if(!_moneyLab) {
        _moneyLab = [[ALLabel alloc] init];
        [self addSubview:_moneyLab];
        if([_model.orderStatus isEqualToString:OrderStatusWaitPay] || [_model.orderStatus isEqualToString:OrderStatusCancel] || [_model.orderStatus isEqualToString:OrderStatusTimeOut]) {
            if([_model.orderType isEqualToString:@"1"]) {
                [self initMoney:[NSString stringWithFormat:@"%.2lf",[_model.payPrice doubleValue]]];
            } else {
                [self initMoney:_model.firstPrice];
            }
        } else if([_model.orderStatus isEqualToString:OrderStatusFinished]) {
            _payMoneyLab.text = @"总金额";
            [self initMoney:[NSString stringWithFormat:@"%@",_model.payPrice]];
        } else if([_model.orderStatus isEqualToString:OrderStatusZ]) {
            [self initMoney:_model.secondPrice];
        } else {
            [self initMoney:_model.firstPrice];
            if([_model.orderType isEqualToString:@"1"]) {
                [self initMoney:_model.payPrice];
            }
        }
    }
    return _moneyLab;
}

//红包
- (ALLabel *)redEnvelopeLab {
    if(!_redEnvelopeLab) {
        _redEnvelopeLab = [[ALLabel alloc] init];
        _redEnvelopeLab.text = @"优惠券";
        [self addSubview:_redEnvelopeLab];
    }
    return _redEnvelopeLab;
}

- (UIImageView *)redEnvelopeIV {
    if(!_redEnvelopeIV) {
        _redEnvelopeIV = [[UIImageView alloc] init];
        _redEnvelopeIV.image = [UIImage imageNamed:@"icon_hongbao"];
        [self addSubview:_redEnvelopeIV];
    }
    return _redEnvelopeIV;
}

- (UILabel *)subSpriceLab {
    if(!_subSpriceLab) {
        _subSpriceLab = [[UILabel alloc] init];
        _subSpriceLab.font = ALThemeFont(14);
        _subSpriceLab.textColor = [UIColor colorWithRGBA:0xF8504FFF];
        [self addSubview:_subSpriceLab];
        
        if([_model.hasAvaCoupon integerValue] == 0) {
            _subSpriceLab.text = @"无可用红包";
            _subSpriceLab.textColor = [UIColor colorWithRGBA:0x999999FF];
            _subSpriceLab.font = ALThemeFont(13);
        }
    }
    return _subSpriceLab;
}

- (UIImageView *)rightIV {
    if(!_rightIV) {
        _rightIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Right"]];
        [self addSubview:_rightIV];
    }
    return _rightIV;
}
@end

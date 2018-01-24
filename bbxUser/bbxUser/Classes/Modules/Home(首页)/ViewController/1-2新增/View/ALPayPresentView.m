//
//  ALPayPresentView.m
//  bbxUser
//
//  Created by xlshi on 2018/1/22.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALPayPresentView.h"

@interface ALPayPresentView()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) ALLabel *waitPayMoney;
@property (nonatomic, strong) UIButton *wxSelBtn;
@property (nonatomic, strong) UIImageView *aliIV;
@property (nonatomic, strong) ALLabel *aliPayLab;
@property (nonatomic, strong) UIButton *aliSelBtn;
@property (nonatomic, strong) ALActionButton *toPayBtn;

//dynamics
@property (nonatomic, strong) ALLabel *titleLab;
@property (nonatomic, strong) UIView *hlineView;
@property (nonatomic, strong) ALLabel *safeMoneyLab;
@property (nonatomic, strong) ALLabel *safeMoney;
@property (nonatomic, strong) ALLabel *redEnvLab;
@property (nonatomic, strong) ALLabel *redEnv;
@property (nonatomic, strong) UIImageView *rightIV;
@property (nonatomic, strong) UIImageView *wxIV;
@property (nonatomic, strong) ALLabel *wxPayLab;

@property (nonatomic, strong) NSString *startMoney;

@property (nonatomic, strong) ALOrderModel *model;
@property (nonatomic, assign) BOOL first;
@property (nonatomic, strong) NSDictionary *dic;
@end

@implementation ALPayPresentView

- (instancetype)initWithFrame:(CGRect)frame orderModel:(ALOrderModel *)orderModel first:(BOOL)first dic:(NSDictionary *)dic {
    if(self = [super initWithFrame:frame]) {
        
        self.model = orderModel;
        self.first = first;
        self.dic = dic;
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@17);
            make.top.equalTo(@17);
        }];
        
        [self.toPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.right.equalTo(@-14);
            make.bottom.equalTo(@-14);
        }];
        
        if(first) {
            [self.waitPayMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(@35);
            }];
            
        } else {
            [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(@20);
            }];
            
            [self.hlineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(@0);
                make.height.equalTo(@1);
                make.top.equalTo(self.titleLab.mas_bottom).offset(14);
            }];
            
            [self.waitPayMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self.hlineView.mas_bottom).offset(13);
            }];
            
            [self.safeMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@29);
                make.top.equalTo(self.hlineView.mas_bottom).offset(68);
            }];
            
            [self.safeMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.safeMoneyLab);
                make.right.equalTo(@-35);
            }];
            
            [self.redEnvLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@29);
                make.top.equalTo(self.safeMoneyLab.mas_bottom).offset(24);
            }];
            
            [self.rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@-35);
                make.centerY.equalTo(self.redEnvLab);
                make.size.mas_equalTo(CGSizeMake(8, 14));
            }];
            
            [self.redEnv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.redEnvLab);
                make.right.equalTo(self.rightIV.mas_left).offset(-10);
            }];
        }
        [self initPayViewWithImageArray:@[@"wxPay",@"alipay"] titleArray:@[@"微信支付",@"支付宝支付"] first:first];

    }
    return self;
}

- (void)initPayViewWithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray first:(BOOL)first {
    
    int itemCount = (int)imageArray.count;
    
    UIView *lastView = nil;
    AL_WeakSelf(self);
    
    for (unsigned int i = 0; i < imageArray.count; i++) {
        UIView *item = [[UIView alloc] init];
        item.userInteractionEnabled = YES;
        item.backgroundColor = [UIColor clearColor];
        [self.bottomView addSubview:item];
        
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
            make.left.equalTo(@27);
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
            make.right.equalTo(@-33);
        }];
        
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if(lastView) {
                [item mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(lastView);
                    make.right.left.equalTo(@0);
                    make.top.equalTo(lastView.mas_bottom).offset(5);
                }];
            } else {
                if(first) {
                    make.top.equalTo(@80);
                } else {
                    make.top.equalTo(self.redEnvLab.mas_bottom).offset(20);
                }
                make.left.right.equalTo(@0);
                make.height.equalTo(@40);
            }
        }];
        
        lastView = item;
        
        if(i != itemCount - 1) {
//            UIView *lineView = [[UIView alloc] init];
//            lineView.backgroundColor = [UIColor colorWithRGBA:0xF5F6FAFF];
//            [self addSubview:lineView];
//
//            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(@56);
//                make.right.equalTo(@0);
//                make.height.equalTo(@1);
//                make.top.equalTo(item.mas_bottom);
//            }];
        }
    }
}

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

- (void)show {
    [ALKeyWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.bgView.backgroundColor = [UIColor colorWithRGBA:0x00000099];
        
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
        }];
        [self.bgView layoutIfNeeded];
    }];
}

- (void)showToViewController:(UIViewController *)viewController {
    [viewController.view addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.bgView.backgroundColor = [UIColor colorWithRGBA:0x00000099];
        
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
        }];
        [self.bgView layoutIfNeeded];
    }];
}

- (void)hideBottomView {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.bgView.backgroundColor = [UIColor colorWithRGBA:0x00000000];
        
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@200);
        }];
        [self.bgView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)closeAction {
    [self hideBottomView];
}

- (void)toPayAction {
    if(self.toPayBlock) {
        self.toPayBlock(self.payType);
    }
}

- (void)setDisCount:(NSString *)disCount {
    _disCount = disCount;
    
    if([disCount isEqualToString:@"-1"]) {
        NSMutableAttributedString *priceAttString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"待支付金额：¥%@",self.startMoney)];
        priceAttString.yy_font = ALMediumTitleFont(24);
        priceAttString.yy_color = [UIColor colorWithRGB:0xF8504F];
        [priceAttString yy_setTextHighlightRange:NSMakeRange(0, 6) color:[UIColor colorWithRGBA:ALLabelTextColor] backgroundColor:nil userInfo:nil];
        [priceAttString yy_setFont:ALThemeFont(16) range:NSMakeRange(0, 6)];
        _waitPayMoney.attributedText = priceAttString;
        _redEnv.text = ALStringFormat(@"%@张可用",self.dic[@"couponCount"]);
    } else {
        _redEnv.text = ALStringFormat(@"-¥%@",disCount);
        NSString *newMoney = ALStringFormat(@"%.2lf",[self.startMoney doubleValue] - [disCount doubleValue]);
        NSMutableAttributedString *priceAttString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"待支付金额：¥%@",newMoney)];
        priceAttString.yy_font = ALMediumTitleFont(24);
        priceAttString.yy_color = [UIColor colorWithRGB:0xF8504F];
        [priceAttString yy_setTextHighlightRange:NSMakeRange(0, 6) color:[UIColor colorWithRGBA:ALLabelTextColor] backgroundColor:nil userInfo:nil];
        [priceAttString yy_setFont:ALThemeFont(16) range:NSMakeRange(0, 6)];
        _waitPayMoney.attributedText = priceAttString;
    }
}

#pragma mark lazy load

- (UIView *)bgView {
    if(!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithRGBA:0x00000000];
        [self addSubview:_bgView];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.width.height.equalTo(self);
        }];
    }
    return _bgView;
}

- (UIView *)bottomView {
    if(!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [self.bgView addSubview:_bottomView];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(self.bgView);
            if(_first) {
                make.height.equalTo(@255);
                make.bottom.equalTo(@255);
            } else {
                make.height.equalTo(@375);
                make.bottom.equalTo(@375);
            }
        }];
    }
    return _bottomView;
}

- (UIButton *)closeBtn {
    if(!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"pay_close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:_closeBtn];
    }
    return _closeBtn;
}

- (ALLabel *)titleLab {
    if(!_titleLab) {
        _titleLab = [[ALLabel alloc] init];
        _titleLab.text = @"支付";
        _titleLab.font = ALThemeFont(20);
        _titleLab.textColor = [UIColor colorWithRGB:0x333333];
        [self.bottomView addSubview:_titleLab];
    }
    return _titleLab;
}

- (UIView *)hlineView {
    if(!_hlineView) {
        _hlineView = [UIView new];
        _hlineView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.99 alpha:1.00];
        [self.bottomView addSubview:_hlineView];
    }
    return _hlineView;
}

- (ALLabel *)waitPayMoney {
    if(!_waitPayMoney) {
        _waitPayMoney = [[ALLabel alloc] init];
        if(_first) {
            NSMutableAttributedString *priceAttString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"预付：¥%@",_model.firstPrice)];
            priceAttString.yy_font = ALMediumTitleFont(24);
            priceAttString.yy_color = [UIColor colorWithRGB:0xF8504F];
            [priceAttString yy_setTextHighlightRange:NSMakeRange(0, 3) color:[UIColor colorWithRGBA:ALLabelTextColor] backgroundColor:nil userInfo:nil];
            [priceAttString yy_setFont:ALThemeFont(16) range:NSMakeRange(0, 3)];
            _waitPayMoney.attributedText = priceAttString;
        } else {
            NSMutableAttributedString *priceAttString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"待支付金额：¥%@",self.dic[@"secondPrice"])];
            self.startMoney = self.dic[@"secondPrice"];
            priceAttString.yy_font = ALMediumTitleFont(24);
            priceAttString.yy_color = [UIColor colorWithRGB:0xF8504F];
            [priceAttString yy_setTextHighlightRange:NSMakeRange(0, 6) color:[UIColor colorWithRGBA:ALLabelTextColor] backgroundColor:nil userInfo:nil];
            [priceAttString yy_setFont:ALThemeFont(16) range:NSMakeRange(0, 6)];
            _waitPayMoney.attributedText = priceAttString;
        }
        
        [self.bottomView addSubview:_waitPayMoney];
    }
    return _waitPayMoney;
}

- (ALLabel *)safeMoneyLab {
    if(!_safeMoneyLab) {
        _safeMoneyLab = [[ALLabel alloc] init];
        _safeMoneyLab.text = @"安全保抵扣";
        [self.bottomView addSubview:_safeMoneyLab];
    }
    return _safeMoneyLab;
}

- (ALLabel *)safeMoney {
    if(!_safeMoney) {
        _safeMoney = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _safeMoney.text = ALStringFormat(@"-¥%@",self.dic[@"discountPrice"]);
        _safeMoney.textColor = [UIColor colorWithRGB:0xF8504F];
        [self.bottomView addSubview:_safeMoney];
    }
    return _safeMoney;
}

- (ALLabel *)redEnvLab {
    if(!_redEnvLab) {
        _redEnvLab = [[ALLabel alloc] init];
        _redEnvLab.text = @"优惠券";
        [self.bottomView addSubview:_redEnvLab];
    }
    return _redEnvLab;
}

- (ALLabel *)redEnv {
    if(!_redEnv) {
        _redEnv = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        if([self.dic[@"couponCount"] isEqualToString:@"0"]) {
            _redEnv.text = @"无可用优惠券";
        }
        else {
            _redEnv.text = ALStringFormat(@"%@张可用",self.dic[@"couponCount"]);
            AL_WeakSelf(self);
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                if(weakSelf.toRedEnv) {
                    weakSelf.toRedEnv();
                }
            }];
            
            _redEnv.userInteractionEnabled = YES;
            [_redEnv addGestureRecognizer:tap];
        }
        _redEnv.textColor = [UIColor colorWithRGB:0xF8504F];
        [self.bottomView addSubview:_redEnv];
    }
    return _redEnv;
}

- (UIImageView *)rightIV {
    if(!_rightIV) {
        _rightIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dy_Right"]];
        [self.bottomView addSubview:_rightIV];
    }
    return _rightIV;
}

- (ALActionButton *)toPayBtn {
    if(!_toPayBtn) {
        _toPayBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        [_toPayBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_toPayBtn setBackgroundImage:[UIImage imageNamed:@"btn-Sign out pressed"] forState:UIControlStateDisabled];
        [_toPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [_toPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _toPayBtn.layer.cornerRadius = 5;
        _toPayBtn.layer.masksToBounds = YES;
        [self.bottomView addSubview:_toPayBtn];
        [_toPayBtn addTarget:self action:@selector(toPayAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toPayBtn;
}
@end

//
//  ALConfirmationInfoView.m
//  bbxUser
//
//  Created by xlshi on 2018/1/22.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALConfirmationInfoView.h"

@interface ALConfirmationInfoView()
@property (nonatomic, strong) UIView *vlineView;
@property (nonatomic, strong) ALLabel *orderInfoLab;
@property (nonatomic, strong) ALLabel *orderId;

@property (nonatomic, strong) ALLabel *serverAddressLab;
@property (nonatomic, strong) ALLabel *serverAddress;

@property (nonatomic, strong) ALLabel *estimateMoneyLab;
@property (nonatomic, strong) ALLabel *estimateMoney;
@property (nonatomic, strong) UIButton *estimateProtocolBtn;

@property (nonatomic, strong) ALLabel *waitPayMoneyLab;
@property (nonatomic, strong) ALLabel *waitPayMoney;

@property (nonatomic, strong) ALOrderModel *model;
@end

@implementation ALConfirmationInfoView

- (instancetype)initWithFrame:(CGRect)frame orderModel:(ALOrderModel *)model {
    if(self = [super initWithFrame:frame]) {
        
        self.model = model;
        
        [self.vlineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(@15);
            make.size.mas_equalTo(CGSizeMake(4, 16));
        }];
        
        [self.orderInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.vlineView);
            make.left.equalTo(self.vlineView.mas_right).offset(6);
        }];
        
        [self.orderId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-14);
            make.centerY.equalTo(self.vlineView);
        }];
        
        UIView *oneLine = [self lineView];
        [oneLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.height.equalTo(@1);
            make.top.equalTo(self.vlineView.mas_bottom).offset(7);
        }];
        
        [self.serverAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(oneLine.mas_bottom).offset(12);
            CGFloat serverAddressLabWid = [self.serverAddressLab.text widthForFont:self.serverAddressLab.font];
            make.width.equalTo(@(serverAddressLabWid + 5));
        }];
        
        [self.serverAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.serverAddressLab);
            make.right.equalTo(@-14);
            make.left.equalTo(self.serverAddressLab.mas_right).offset(12);
            CGFloat serverAddressLabWid = [self.serverAddressLab.text widthForFont:self.serverAddressLab.font];
            CGFloat height = [self.serverAddress.text heightForFont:self.serverAddress.font width:ALScreenWidth - 28 - 28 - 12 - serverAddressLabWid - 5];
            make.height.equalTo(@(height + 5));
        }];

        UIView *twoLine = [self lineView];
        [twoLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.serverAddressLab.mas_right).offset(12);
            make.right.equalTo(@-15);
            make.height.equalTo(@1);
            make.top.equalTo(self.serverAddress.mas_bottom).offset(12);
        }];
        
        [self.estimateMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(twoLine.mas_bottom).offset(12);
        }];
        
        [self.estimateProtocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.estimateMoneyLab);
            make.left.equalTo(self.estimateMoneyLab.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
        
        [self.estimateMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-14);
            make.centerY.equalTo(self.estimateMoneyLab);
        }];
        
        UIView *threeLine = [self lineView];
        [threeLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.height.leading.equalTo(twoLine);
            make.top.equalTo(self.estimateMoney.mas_bottom).offset(12);
        }];
        
        [self.waitPayMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(threeLine.mas_bottom).offset(12);
        }];
        
        [self.waitPayMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-14);
            make.centerY.equalTo(self.waitPayMoneyLab);
        }];
    }
    return self;
}

- (CGFloat)maxSubviewsY {
    return CGRectGetMaxY(self.waitPayMoney.frame);
}

- (UIView *)lineView {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRGBA:0xF5F6FAFF];
    [self addSubview:lineView];
    return lineView;
}

#pragma mark lazy load
- (UIView *)vlineView {
    if(!_vlineView) {
        _vlineView = [UIView new];
        _vlineView.backgroundColor = [UIColor colorWithRGBA:ALThemeColor];
        [self addSubview:_vlineView];
    }
    return _vlineView;
}

- (ALLabel *)orderInfoLab {
    if(!_orderInfoLab) {
        _orderInfoLab = [[ALLabel alloc] init];
        _orderInfoLab.font = ALThemeFont(13);
        _orderInfoLab.text = @"订单信息";
        [self addSubview:_orderInfoLab];
    }
    return _orderInfoLab;
}

- (ALLabel *)orderId {
    if(!_orderId) {
        _orderId = [[ALLabel alloc] init];
        _orderId.font = ALThemeFont(13);
        _orderId.text = [NSString stringWithFormat:@"编号:%@",_model.orderId];
        [self addSubview:_orderId];
    }
    return _orderId;
}

- (ALLabel *)serverAddressLab {
    if(!_serverAddressLab) {
        _serverAddressLab = [[ALLabel alloc] init];
        _serverAddressLab.font = ALThemeFont(13);
        _serverAddressLab.text = @"服务地址";
        [self addSubview:_serverAddressLab];
    }
    return _serverAddressLab;
}

- (ALLabel *)serverAddress {
    if(!_serverAddress) {
        _serverAddress = [[ALLabel alloc] init];
        _serverAddress.font = ALThemeFont(15);
        _serverAddress.textColor = [UIColor colorWithRGB:0x333333];
        _serverAddress.textAlignment = NSTextAlignmentRight;
        _serverAddress.numberOfLines = 0;
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:_model.seviceAddress];
        attStr.yy_lineSpacing = 4;
        _serverAddress.attributedText = attStr;
        [self addSubview:_serverAddress];
    }
    return _serverAddress;
}

- (ALLabel *)estimateMoneyLab {
    if(!_estimateMoneyLab) {
        _estimateMoneyLab = [[ALLabel alloc] init];
        _estimateMoneyLab.font = ALThemeFont(13);
        _estimateMoneyLab.text = @"预付金额";
        [self addSubview:_estimateMoneyLab];
    }
    return _estimateMoneyLab;
}

- (ALLabel *)estimateMoney {
    if(!_estimateMoney) {
        _estimateMoney = [[ALLabel alloc] init];
        _estimateMoney.font = ALThemeFont(15);
        _estimateMoney.text = [NSString stringWithFormat:@"%@元",_model.firstPrice];
        _estimateMoney.textColor = [UIColor colorWithRGB:0x333333];
        [self addSubview:_estimateMoney];
    }
    return _estimateMoney;
}

- (ALLabel *)waitPayMoneyLab {
    if(!_waitPayMoneyLab) {
        _waitPayMoneyLab = [[ALLabel alloc] init];
        _waitPayMoneyLab.font = ALThemeFont(13);
        _waitPayMoneyLab.text = @"待支付金额";
        [self addSubview:_waitPayMoneyLab];
    }
    return _waitPayMoneyLab;
}

- (ALLabel *)waitPayMoney {
    if(!_waitPayMoney) {
        _waitPayMoney = [[ALLabel alloc] init];
        _waitPayMoney.font = ALThemeFont(15);
        _waitPayMoney.text = [NSString stringWithFormat:@"%@元",_model.secondPrice];
        _waitPayMoney.textColor = [UIColor colorWithRGB:0x333333];
        [self addSubview:_waitPayMoney];
    }
    return _waitPayMoney;
}

- (UIButton *)estimateProtocolBtn {
    if(!_estimateProtocolBtn) {
        _estimateProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _estimateProtocolBtn.titleLabel.font = ALThemeFont(9);
        [_estimateProtocolBtn setTitle:@"?" forState:UIControlStateNormal];
        [_estimateProtocolBtn setTitleColor:[UIColor colorWithRGB:0x999999] forState:UIControlStateNormal];
        [self addSubview:_estimateProtocolBtn];
        _estimateProtocolBtn.layer.masksToBounds = YES;
        _estimateProtocolBtn.layer.cornerRadius = 14/2.0;
        _estimateProtocolBtn.layer.borderColor = [UIColor colorWithRGB:0x999999].CGColor;
        _estimateProtocolBtn.layer.borderWidth = 1.0;
        
        [_estimateProtocolBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            NSLog(@"安全保协议");
        }];
    }
    return _estimateProtocolBtn;
}
@end

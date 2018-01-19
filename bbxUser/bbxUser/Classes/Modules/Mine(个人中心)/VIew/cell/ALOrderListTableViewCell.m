//
//  ALOrderListTableViewCell.m
//  bbxUser
//
//  Created by along on 2017/8/8.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALOrderListTableViewCell.h"

@interface ALOrderListTableViewCell ()
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) ALLabel *jjOrderLab;
@property (nonatomic, strong) ALLabel *orderStautsLab;
@property (nonatomic, strong) UIView *hLineView;
@property (nonatomic, strong) UIImageView *timeIV;
@property (nonatomic, strong) ALLabel *timeLab;
@property (nonatomic, strong) UIImageView *addressIV;
@property (nonatomic, strong) ALLabel *addressLab;
@property (nonatomic, strong) ALLabel *priceLab;
@property (nonatomic, strong) UIButton *actionButton;

@property (nonatomic, assign) ALOrderModel *model;
@end

@implementation ALOrderListTableViewCell

- (void)bindModel:(ALOrderModel *)model {
    
    _model = model;
    self.orderStautsLab.text = model.orderStatusDes;
    if([model.orderStatus isEqualToString:OrderStatusWaitPay]) {
        self.actionButton.hidden = NO;
        [self.actionButton setBackgroundImage:[UIImage imageNamed:@"btn_zhifu"] forState:UIControlStateNormal];
        [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.priceLab);
            make.right.equalTo(@-18);
        }];
    } else if([model.orderStatus isEqualToString:OrderStatusFinished]) {
        self.actionButton.hidden = NO;
        if([model.isCommented integerValue] == 0) {
            [self.actionButton setBackgroundImage:[UIImage imageNamed:@"btn_pingjia"] forState:UIControlStateNormal];
            
            [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.priceLab);
                make.right.equalTo(@-18);
            }];
        } else {
            self.actionButton.hidden = YES;
        }
    } else {
        self.actionButton.hidden = YES;
    }
    
    self.timeLab.text = model.preStartTime;
    self.addressLab.text = model.seviceAddress;
    
    NSMutableAttributedString *priceAttString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"金额：¥%@",model.orderPrice)];
    priceAttString.yy_font = ALThemeFont(14);
    priceAttString.yy_color = [UIColor colorWithRGBA:ALLabelTextColor];
    [priceAttString yy_setColor:[UIColor colorWithRGBA:ALLabelTitleColor] range:NSMakeRange(3, priceAttString.length - 3)];
    [priceAttString yy_setFont:ALMediumTitleFont(14) range:NSMakeRange(3, priceAttString.length - 3)];
    self.priceLab.attributedText = priceAttString;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.equalTo(@10);
        make.bottom.equalTo(@0);
    }];
    
    [self.jjOrderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(@14);
    }];
    
    [self.orderStautsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.jjOrderLab);
        make.right.equalTo(@-14);
    }];
    
    [self.hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(self.jjOrderLab.mas_bottom).offset(6);
    }];
    
    [self.timeIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(self.hLineView.mas_bottom).offset(8);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeIV);
        make.left.equalTo(self.timeIV.mas_right).offset(12);
    }];
    
    [self.addressIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(self.timeIV.mas_bottom).offset(7);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.addressIV);
        make.right.equalTo(@-14);
        make.left.equalTo(self.addressIV.mas_right).offset(12);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(self.addressLab.mas_bottom).offset(15);
    }];
    
}

#pragma mark Action
- (void)actionButtonAction {
    if([_model.orderStatus isEqualToString:OrderStatusWaitPay]) {
        if(_actionBlock) {
            _actionBlock(1);
        }
    } else if ([_model.orderStatus isEqualToString:OrderStatusFinished]) {
        if(_actionBlock) {
            _actionBlock(2);
        }
    }
}

#pragma mark lazy load
- (UIView *)bgView {
    if(!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
        [_bgView.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeZero radius:1];
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}

- (ALLabel *)jjOrderLab {
    if(!_jjOrderLab) {
        _jjOrderLab = [[ALLabel alloc] init];
        _jjOrderLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
        _jjOrderLab.text = @"订单信息";
        [self.bgView addSubview:_jjOrderLab];
    }
    return _jjOrderLab;
}

- (ALLabel *)orderStautsLab {
    if(!_orderStautsLab) {
        _orderStautsLab = [[ALLabel alloc] init];
        _orderStautsLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
        _orderStautsLab.font = ALThemeFont(13);
        [self.bgView addSubview:_orderStautsLab];
    }
    return _orderStautsLab;
}

- (UIView *)hLineView {
    if(!_hLineView) {
        _hLineView = [[UIView alloc] init];
        _hLineView.backgroundColor = [UIColor colorWithRGBA:ALVCbgColor];
        [self.bgView addSubview:_hLineView];
    }
    return _hLineView;
}

- (UIImageView *)timeIV {
    if(!_timeIV) {
        _timeIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_time"]];
        [self.bgView addSubview:_timeIV];
    }
    return _timeIV;
}

- (ALLabel *)timeLab {
    if(!_timeLab) {
        _timeLab = [[ALLabel alloc] init];
        _timeLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        [self.bgView addSubview:_timeLab];
    }
    return _timeLab;
}

- (UIImageView *)addressIV {
    if(!_addressIV) {
        _addressIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_address"]];
        [self.bgView addSubview:_addressIV];
    }
    return _addressIV;
}

- (ALLabel *)addressLab {
    if(!_addressLab) {
        _addressLab = [[ALLabel alloc] init];
        _addressLab.textAlignment = NSTextAlignmentLeft;
        _addressLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        [self.bgView addSubview:_addressLab];
    }
    return _addressLab;
}

- (ALLabel *)priceLab {
    if(!_priceLab) {
        _priceLab = [[ALLabel alloc] init];
        [self.bgView addSubview:_priceLab];
    }
    return _priceLab;
}

- (UIButton *)actionButton {
    if(!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionButton addTarget:self action:@selector(actionButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:_actionButton];
    }
    return _actionButton;
}
@end

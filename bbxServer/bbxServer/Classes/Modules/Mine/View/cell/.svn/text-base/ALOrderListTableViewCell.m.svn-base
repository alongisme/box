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
@property (nonatomic, strong) UIImageView *rightIV;

@property (nonatomic, strong) UIView *hLineView;
@property (nonatomic, strong) UIImageView *timeIV;
@property (nonatomic, strong) ALLabel *timeLab;

@property (nonatomic, strong) UIImageView *linkManIV;
@property (nonatomic, strong) ALLabel *linkManLab;

@property (nonatomic, strong) UIImageView *addressIV;
@property (nonatomic, strong) ALLabel *addressLab;

@property (nonatomic, assign) ALOrderModel *model;
@end

@implementation ALOrderListTableViewCell

- (void)bindModel:(ALOrderModel *)model {
    
    _model = model;
    self.orderStautsLab.text = model.orderStatusDes;
    if([model.orderStatus isEqualToString:OrderStatusWaitPay]) {
     
    } else if([model.orderStatus isEqualToString:OrderStatusFinished]) {

    }
    
    self.jjOrderLab.text = ALStringFormat(@"本单角色：%@",model.myPositionDes);
    self.timeLab.text = model.preStartTime;
    self.linkManLab.text = model.contactName;
    self.addressLab.text = model.seviceAddress;
    
    NSMutableAttributedString *priceAttString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"金额：¥%@",model.orderPrice)];
    priceAttString.yy_font = ALThemeFont(14);
    priceAttString.yy_color = [UIColor colorWithRGBA:ALLabelTextColor];
    [priceAttString yy_setColor:[UIColor colorWithRGBA:ALLabelTitleColor] range:NSMakeRange(3, priceAttString.length - 3)];
    [priceAttString yy_setFont:ALMediumTitleFont(14) range:NSMakeRange(3, priceAttString.length - 3)];
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
    
    [self.rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.jjOrderLab);
        make.right.equalTo(@-14);
    }];
    
    [self.orderStautsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.jjOrderLab);
        make.right.equalTo(self.rightIV.mas_left).offset(-10);
    }];
    
    [self.hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(self.jjOrderLab.mas_bottom).offset(6);
    }];
    
    [self.timeIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(self.hLineView.mas_bottom).offset(8);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeIV);
        make.left.equalTo(self.timeIV.mas_right).offset(12);
    }];
    
    [self.linkManIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(self.timeLab.mas_bottom).offset(7);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [self.linkManLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.linkManIV);
        make.right.equalTo(@-14);
        make.left.equalTo(self.linkManIV.mas_right).offset(12);
    }];
    
    [self.addressIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(self.linkManIV.mas_bottom).offset(7);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.addressIV);
        make.right.equalTo(@-14);
        make.left.equalTo(self.addressIV.mas_right).offset(12);
    }];
    
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
        _jjOrderLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _jjOrderLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
        [self.bgView addSubview:_jjOrderLab];
    }
    return _jjOrderLab;
}

- (ALLabel *)orderStautsLab {
    if(!_orderStautsLab) {
        _orderStautsLab = [[ALLabel alloc] init];
        _orderStautsLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        _orderStautsLab.font = ALThemeFont(15);
        [self.bgView addSubview:_orderStautsLab];
    }
    return _orderStautsLab;
}

- (UIImageView *)rightIV {
    if(!_rightIV) {
        _rightIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Right"]];
        [self.bgView addSubview:_rightIV];
    }
    return _rightIV;
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
        _timeIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-time"]];
        [self.bgView addSubview:_timeIV];
    }
    return _timeIV;
}

- (ALLabel *)timeLab {
    if(!_timeLab) {
        _timeLab = [[ALLabel alloc] init];
        _timeLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        _timeLab.textAlignment = NSTextAlignmentLeft;
        [self.bgView addSubview:_timeLab];
    }
    return _timeLab;
}

- (UIImageView *)linkManIV {
    if(!_linkManIV) {
        _linkManIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-lianxiren"]];
        [self.bgView addSubview:_linkManIV];
    }
    return _linkManIV;
}

- (ALLabel *)linkManLab {
    if(!_linkManLab) {
        _linkManLab = [[ALLabel alloc] init];
        _linkManLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        _linkManLab.textAlignment = NSTextAlignmentLeft;
        [self.bgView addSubview:_linkManLab];
    }
    return _linkManLab;
}

- (UIImageView *)addressIV {
    if(!_addressIV) {
        _addressIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-position"]];
        [self.bgView addSubview:_addressIV];
    }
    return _addressIV;
}

- (ALLabel *)addressLab {
    if(!_addressLab) {
        _addressLab = [[ALLabel alloc] init];
        _addressLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        _addressLab.textAlignment = NSTextAlignmentLeft;
        [self.bgView addSubview:_addressLab];
    }
    return _addressLab;
}

@end

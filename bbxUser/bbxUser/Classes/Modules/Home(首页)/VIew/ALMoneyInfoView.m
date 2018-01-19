//
//  ALMoneyInfoView.m
//  bbxUser
//
//  Created by along on 2017/9/22.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMoneyInfoView.h"

@interface ALMoneyInfoView ()
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *length;
@property (nonatomic, copy) NSString *num;

@property (nonatomic, strong) ALShadowView *infoView;
@property (nonatomic, strong) ALLabel *titleLab;
@property (nonatomic, strong) ALLabel *moneyLab;
@property (nonatomic, strong) ALLabel *lengthLab;
@property (nonatomic, strong) ALLabel *numLab;
@property (nonatomic, strong) ALLabel *subTitleLab;
@property (nonatomic, strong) ALLabel *contentLab;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *closeBtn;
@end

@implementation ALMoneyInfoView

- (instancetype)initWithFrame:(CGRect)frame money:(NSString *)money length:(NSString *)length num:(NSString *)num {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        _money = money;
        _length = length;
        _num = num;
        
        [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.left.equalTo(@50);
            make.right.equalTo(@-50);
            make.height.equalTo(@300);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@20);
        }];
        
        [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.titleLab);
            make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        }];
        
        [self.lengthLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.titleLab);
            make.top.equalTo(self.moneyLab.mas_bottom).offset(10);
        }];
        
        [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.titleLab);
            make.top.equalTo(self.lengthLab.mas_bottom).offset(10);
        }];
        
        [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.numLab.mas_bottom).offset(20);
            make.leading.equalTo(self.titleLab);
        }];
        
        [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.titleLab);
            make.top.equalTo(self.subTitleLab.mas_bottom).offset(10);
            make.right.equalTo(@-14);
            make.bottom.equalTo(@-15);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@1);
            make.height.equalTo(@35);
            make.centerX.equalTo(self);
            make.top.equalTo(self.infoView.mas_bottom);
        }];
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView.mas_bottom);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

- (void)show {
    [ALKeyWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (void)closeButtonAction {
    [self removeFromSuperview];
}

#pragma mark lazy load
- (ALShadowView *)infoView {
    if(!_infoView) {
        _infoView = [[ALShadowView alloc] init];
        [self addSubview:_infoView];
    }
    return _infoView;
}

- (ALLabel *)titleLab {
    if(!_titleLab) {
        _titleLab = [[ALLabel alloc] initWithFrame:CGRectZero];
        _titleLab.text = @"价格明细:";
        _titleLab.textColor = [UIColor colorWithRGBA:ALThemeColor];
        [self.infoView addSubview:_titleLab];
    }
    return _titleLab;
}

- (ALLabel *)moneyLab {
    if(!_moneyLab) {
        _moneyLab = [[ALLabel alloc] init];
        _moneyLab.font = ALThemeFont(15);
        _moneyLab.text = ALStringFormat(@"金额：%@",_money);
        [self.infoView addSubview:_moneyLab];
    }
    return _moneyLab;
}

- (ALLabel *)lengthLab {
    if(!_lengthLab) {
        _lengthLab = [[ALLabel alloc] init];
        _lengthLab.font = ALThemeFont(15);
        _lengthLab.text = ALStringFormat(@"服务时长：%@",_length);
        [self.infoView addSubview:_lengthLab];
    }
    return _lengthLab;
}

- (ALLabel *)contentLab {
    if(!_contentLab) {
        _contentLab = [[ALLabel alloc] init];
        if([UIScreen mainScreen].bounds.size.width == 414) _contentLab.font = ALThemeFont(13);
        _contentLab.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
        _contentLab.numberOfLines = 0;
        _contentLab.textAlignment = NSTextAlignmentLeft;
        [self.infoView addSubview:_contentLab];
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"(1)若您支付之后，取消了该订单或者一定时间内未有保安接单，我们将及时与您取得联系，确认后将退还到您的账户中。\n(2)若您还需要加长服务时间，只需再次下单即可，或者联系客服，我们将为您提供解决方案！"];
        attString.yy_lineSpacing = 5;
        _contentLab.attributedText = attString;
    }
    return _contentLab;
}

- (ALLabel *)numLab {
    if(!_numLab) {
        _numLab = [[ALLabel alloc] init];
        _numLab.font = ALThemeFont(15);
        _numLab.text = ALStringFormat(@"服务人数：%@",_num);
        [self.infoView addSubview:_numLab];
    }
    return _numLab;
}

- (ALLabel *)subTitleLab {
    if(!_subTitleLab) {
        _subTitleLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _subTitleLab.text = @"关于退款&时长说明：";
        _subTitleLab.textColor = [UIColor colorWithRGBA:ALThemeColor];
        [self.infoView addSubview:_subTitleLab];
    }
    return _subTitleLab;
}

- (UIView *)lineView {
    if(!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (UIButton *)closeBtn {
    if(!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeBtn];
    }
    return _closeBtn;
}
@end

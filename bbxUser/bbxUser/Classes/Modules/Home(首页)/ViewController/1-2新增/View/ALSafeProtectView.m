//
//  ALSafeProtectView.m
//  bbxUser
//
//  Created by xlshi on 2018/1/19.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALSafeProtectView.h"

@interface ALSafeProtectView()
@property (nonatomic, strong) ALLabel *titleLab;
@property (nonatomic, strong) ALLabel *subTitleLab;
@property (nonatomic, strong) UIButton *safeProtocolBtn;
@property (nonatomic, strong) UISwitch *safeSwitch;
@end

@implementation ALSafeProtectView

- (instancetype)init {
    if(self = [super init]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self.safeSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(@-14);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@16);
        make.left.equalTo(@14);
    }];

    [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.bottom.equalTo(@-16);
    }];
    
    [self.safeProtocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab);
        make.left.equalTo(self.titleLab.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
}

- (NSString *)isOn {
    return [NSString stringWithFormat:@"%d",self.safeSwitch.on];
}

#pragma mark lazy load
- (ALLabel *)titleLab {
    if(!_titleLab) {
        _titleLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _titleLab.text = @"安全保";
        _titleLab.font = ALMediumTitleFont(18);
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

- (ALLabel *)subTitleLab {
    if(!_subTitleLab) {
        _subTitleLab = [[ALLabel alloc] init];
        _subTitleLab.text = @"安保延误、安全保障赔付";
        _subTitleLab.font = ALThemeFont(12);
        [self addSubview:_subTitleLab];
    }
    return _subTitleLab;
}

- (UIButton *)safeProtocolBtn {
    if(!_safeProtocolBtn) {
        _safeProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _safeProtocolBtn.titleLabel.font = ALThemeFont(9);
        [_safeProtocolBtn setTitle:@"?" forState:UIControlStateNormal];
        [_safeProtocolBtn setTitleColor:[UIColor colorWithRGB:0x999999] forState:UIControlStateNormal];
        [self addSubview:_safeProtocolBtn];
        _safeProtocolBtn.layer.masksToBounds = YES;
        _safeProtocolBtn.layer.cornerRadius = 14/2.0;
        _safeProtocolBtn.layer.borderColor = [UIColor colorWithRGB:0x999999].CGColor;
        _safeProtocolBtn.layer.borderWidth = 1.0;
        
        [_safeProtocolBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            NSLog(@"安全保协议");
        }];
    }
    return _safeProtocolBtn;
}

- (UISwitch *)safeSwitch {
    if(!_safeSwitch) {
        _safeSwitch = [[UISwitch alloc] init];
        _safeSwitch.on = YES;
        [self addSubview:_safeSwitch];
    }
    return _safeSwitch;
}
@end

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

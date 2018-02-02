//
//  ALSafeProtectView.m
//  bbxUser
//
//  Created by xlshi on 2018/1/19.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALSafeProtectView.h"
#import "ALBaseWebViewController.h"

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

- (void)safeProtocolAction {
    ALBaseWebViewController *wbvc = [[ALBaseWebViewController alloc] init];
    wbvc.title = @"安全保服务协议";
    wbvc.requestUrl = ALStringFormat(@"%@/resources/protocol/insurance-protocol.html",URL_Domain);
    [ALKeyWindow.currentViewController.navigationController pushViewController:wbvc animated:YES];
}

- (UIButton *)safeProtocolBtn {
    if(!_safeProtocolBtn) {
        _safeProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_safeProtocolBtn setBackgroundImage:[UIImage imageNamed:@"wenhao"] forState:UIControlStateNormal];
        [self addSubview:_safeProtocolBtn];
        [_safeProtocolBtn addTarget:self action:@selector(safeProtocolAction) forControlEvents:UIControlEventTouchUpInside];
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

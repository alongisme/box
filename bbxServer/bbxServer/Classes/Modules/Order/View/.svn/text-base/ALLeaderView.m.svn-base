//
//  ALLeaderView.m
//  bbxServer
//
//  Created by along on 2017/9/1.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALLeaderView.h"
#import "ALOrderModel.h"

@interface ALLeaderView ()
@property (nonatomic, strong) UIImageView *headIV;
@property (nonatomic, strong) ALLabel *nameLab;
@property (nonatomic, strong) UIImageView *leadIV;
@property (nonatomic, strong) UIButton *callBtn;
@property (nonatomic, strong) ALMyDoingOrderModel *model;
@end

@implementation ALLeaderView

- (instancetype)initWithFrame:(CGRect)frame model:(ALMyDoingOrderModel *)model {
    if(self = [super initWithFrame:frame]) {
        
        _model = model;
        
        [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(48, 48));
        }];
        
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.headIV.mas_right).offset(15);
        }];
        
        [self.callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(@-13);
        }];
        //领队
        if([model.orderInfo.myPosition integerValue] == 1) {
            [self.headIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,model.clientInfo.clientIcon)] placeholderImage:[UIImage imageNamed:@"huantouxiang_moren"]];
            self.nameLab.text = model.clientInfo.clientNickName;
        } else {
            NSArray *arr = model.orderInfo.securityList;
            for (ALSecurityModel *securityModel in arr) {
                if([securityModel.isLeader integerValue] == 1) {
                    [self.headIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,securityModel.icon)] placeholderImage:[UIImage imageNamed:@"huantouxiang_moren"]];
                    self.nameLab.text = securityModel.realName;
                }
            }
            [self.leadIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self.nameLab.mas_right).offset(20);
            }];
        }
    }
    return self;
}

- (void)callButtonAction {
    if([_model.orderInfo.myPosition integerValue] == 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ALStringFormat(@"tel://%@",_model.orderInfo.contactsPhone)]];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *arr = _model.orderInfo.securityList;
            for (ALSecurityModel *securityModel in arr) {
                if([securityModel.isLeader integerValue] == 1) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ALStringFormat(@"tel://%@",securityModel.phone)]];
                    break;
                }
            }
        });
    }
}

#pragma mark lazy load
- (UIImageView *)headIV {
    if(!_headIV) {
        _headIV = [[UIImageView alloc] init];
        _headIV.contentMode = UIViewContentModeScaleAspectFill;
        _headIV.layer.masksToBounds = YES;
        _headIV.layer.cornerRadius = 24;
        [self addSubview:_headIV];
    }
    return _headIV;
}

- (ALLabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [[ALLabel alloc] init];
        _nameLab.text = @"用户名";
        [self addSubview:_nameLab];
    }
    return _nameLab;
}

- (UIImageView *)leadIV {
    if(!_leadIV) {
        _leadIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_leader"]];
        [self addSubview:_leadIV];
    }
    return _leadIV;
}

- (UIButton *)callBtn {
    if(!_callBtn) {
        _callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_callBtn setBackgroundImage:[UIImage imageNamed:@"btn-contact"] forState:UIControlStateNormal];
        [_callBtn addTarget:self action:@selector(callButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_callBtn];
    }
    return _callBtn;
}
@end

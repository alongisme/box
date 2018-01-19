//
//  ALStatusView.m
//  bbxServer
//
//  Created by along on 2017/8/29.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALStatusView.h"

@interface ALStatusView ()
@property (nonatomic, strong) ALLabel *titleLab;
@property (nonatomic, strong) ALLabel *subLab;
@property (nonatomic, strong) UIImageView *IV;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@end

@implementation ALStatusView

- (instancetype)initWithFrame:(CGRect)frame status:(ALAuthStatus)status {
    if(self = [super initWithFrame:frame]) {
        if(status == ALAuthStatusing) {
            _imageName = @"In authentication";
            _title = @"认证中...";
            _subTitle = AL_MyAppDelegate.authModel.authMsg;
        } else if (status == ALAuthStatusSuccess) {
            _imageName = @"renzhengchenggong";
            _title = @"认证成功";
            _subTitle = @"您已成功认证，好好经营您的订单吧~";
        } else if (status == ALAuthStatusFaild) {
            _imageName = @"Authentication failed";
            _title = @"认证失败...";
            self.titleLab.textColor = [UIColor colorWithRGB:0xF8504F];
            _subTitle = AL_MyAppDelegate.authModel.authMsg;
        }

        [self.IV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.titleLab.mas_top).offset(-30);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        [self.subLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        }];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame sourceDic:(NSDictionary *)sourceDic {
    if(self = [super initWithFrame:frame]) {
        if([sourceDic[@"authStatus"] isEqualToString:UserAuthStatusFirst]) {
            _imageName = @"yishenzhong";
            [self.IV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
            }];
        } else if([sourceDic[@"authStatus"] isEqualToString:UserAuthStatusSecond]) {
            _imageName = @"ershenzhong";
            [self.IV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
            }];
        } else if([sourceDic[@"authStatus"] isEqualToString:UserAuthStatusThird]) {
            _imageName = @"sanshenzhong";
            [self.IV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
            }];
        } else if([sourceDic[@"authStatus"] isEqualToString:UserAuthStatusFirstReject] || [sourceDic[@"authStatus"] isEqualToString:UserAuthStatusSecondReject] || [sourceDic[@"authStatus"] isEqualToString:UserAuthStatusThirdReject]) {
            
            _title = @"认证失败";
            self.titleLab.textColor = [UIColor colorWithRGB:0xF8504F];
            _subTitle = sourceDic[@"authMsg"];
            
            [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
            }];
            
            [self.subLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self.titleLab.mas_bottom).offset(10);
            }];
            
            _imageName = @"Authentication failed";
            [self.IV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.bottom.equalTo(self.titleLab.mas_top).offset(-30);
            }];
        } else if([sourceDic[@"authStatus"] isEqualToString:UserAuthStatusSuccess]) {
            _subTitle = @"您还没有开始接单哟~";
            
            [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
            }];
            
            [self.subLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self.titleLab.mas_bottom).offset(10);
            }];
            
            _imageName = @"Waiting for orders";
            [self.IV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.bottom.equalTo(self.titleLab.mas_top).offset(-30);
            }];
        }
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title subTitle:(NSString *)subTitle {
    if(self = [super initWithFrame:frame]) {
        _imageName = imageName;
        _title = title;
        _subTitle = subTitle;
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        [self.subLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        }];
        
        [self.IV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.titleLab.mas_top).offset(-30);
        }];
    }
    return self;
}

#pragma mark lazy load
- (ALLabel *)titleLab {
    if(!_titleLab) {
        _titleLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _titleLab.font = ALMediumTitleFont(18);
        _titleLab.textColor = [UIColor colorWithRGBA:ALThemeColor];
        _titleLab.text = _title;
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

- (ALLabel *)subLab {
    if(!_subLab) {
        _subLab = [[ALLabel alloc] init];
        _subLab.text = _subTitle;
        [self addSubview:_subLab];
    }
    return _subLab;
}

- (UIImageView *)IV {
    if(!_IV) {
        _IV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageName]];
        [self addSubview:_IV];
    }
    return _IV;
}
@end

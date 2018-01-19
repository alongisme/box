//
//  ALRequestStatusView.m
//  bbxServer
//
//  Created by along on 2017/9/13.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALRequestStatusView.h"

@interface ALRequestStatusView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) ALLabel *messageLab;
@property (nonatomic, strong) UIButton *reloadBtn;
@property (nonatomic, assign) ALRequestStatus status;
@end

@implementation ALRequestStatusView

- (instancetype)initWithFrame:(CGRect)frame status:(ALRequestStatus)status {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _status = status;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.messageLab.mas_top).offset(-30);
    }];
    
    [self.reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@110);
        make.height.equalTo(@40);
        make.centerX.equalTo(self);
        make.top.equalTo(self.messageLab.mas_bottom).offset(18);
    }];
}

#pragma mark lazy load
- (UIImageView *)imageView {
    if(!_imageView) {
        if(_status == ALRequestStatusNoNetwork) {
            _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"No network"]];
        } else if (_status == ALRequestStatusDataError) {
            _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shujudiushi"]];
        }
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (ALLabel *)messageLab {
    if(!_messageLab) {
        _messageLab = [[ALLabel alloc] init];
        _messageLab.font = ALThemeFont(15);
        if(_status == ALRequestStatusNoNetwork) {
            _messageLab.text = @"网络异常请稍后再试～";
        } else if (_status == ALRequestStatusDataError) {
            _messageLab.text = @"数据错误啦，您在等等吧～";
        }
        [self addSubview:_messageLab];
    }
    return _messageLab;
}

- (UIButton *)reloadBtn {
    if(!_reloadBtn) {
        _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [_reloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_reloadBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGBA:ALThemeColor]] forState:UIControlStateNormal];
        _reloadBtn.titleLabel.font = ALThemeFont(14);
        [self addSubview:_reloadBtn];
        _reloadBtn.layer.masksToBounds = YES;
        _reloadBtn.layer.cornerRadius = 6;
        
        AL_WeakSelf(self);
        [_reloadBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if(weakSelf.reloadDataBlock) {
                weakSelf.reloadDataBlock();
            }
        }];
    }
    return _reloadBtn;
}
@end

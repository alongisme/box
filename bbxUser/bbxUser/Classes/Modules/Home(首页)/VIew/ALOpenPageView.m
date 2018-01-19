//
//  ALOpenPageView.m
//  bbxUser
//
//  Created by xlshi on 2017/12/5.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALOpenPageView.h"

@interface ALOpenPageView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *jumpBtn;
@property (nonatomic, strong) UILabel *timeValueLab;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ALOpenPageView {
    NSUInteger timeInterval;
}

- (instancetype)initWithFrame:(CGRect)frame url:(NSString *)url {
    if(self = [super initWithFrame:frame]) {
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
        [self.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@30);
            make.right.equalTo(@-30);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        
        if([url isVaild]) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        } else {
            self.imageView.image = [UIImage imageNamed:@"initopenPage"];
        }
    }
    return self;
}

- (void)show {
    [ALKeyWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    AL_WeakSelf(self);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"跳过\n %ld s",2 - timeInterval)];
        attString.yy_font = ALThemeFont(12);
        attString.yy_color = [UIColor whiteColor];
        attString.yy_lineSpacing = 1.5;
        [attString yy_setFont:ALThemeFont(11) range:NSMakeRange(@"跳过\n 3 s".length - 3, 3)];
        [_jumpBtn setAttributedTitle:attString forState:UIControlStateNormal];
        
        if(timeInterval == 2) {
            [weakSelf.timer timeInterval];
            weakSelf.timer = nil;
            [weakSelf remove];
        }

        timeInterval++;
    } repeats:YES];
}

- (void)remove {
    
    if(self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if(self.removeFromWindowBlock) {
        self.removeFromWindowBlock();
    }
    
    [UIView animateWithDuration:0.6 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark lazy load
- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)jumpBtn {
    if(!_jumpBtn) {
        _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _jumpBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_jumpBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        _jumpBtn.backgroundColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:0.70];
        [self addSubview:_jumpBtn];
        _jumpBtn.layer.masksToBounds = YES;
        _jumpBtn.layer.cornerRadius = 44/2.0;
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"跳过\n 3 s"];
        attString.yy_font = ALThemeFont(12);
        attString.yy_color = [UIColor whiteColor];
        attString.yy_lineSpacing = 1.5;
        [attString yy_setFont:ALThemeFont(11) range:NSMakeRange(@"跳过\n 3 s".length - 3, 3)];
        [_jumpBtn setAttributedTitle:attString forState:UIControlStateNormal];
    }
    return _jumpBtn;
}

- (UILabel *)timeValueLab {
    if(!_timeValueLab) {
        _timeValueLab = [[UILabel alloc] init];
    }
    return _timeValueLab;
}
@end

//
//  ALMainPageBootPicView.m
//  bbxUser
//
//  Created by xlshi on 2017/10/13.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMainPageBootPicView.h"

@implementation ALMainPageBootPicView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainPageBootPic"]];
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [self addSubview:closeBtn];
        
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            CGFloat mul = ALScreenHeight * 0.1385;
            make.bottom.mas_equalTo(-mul);
        }];
        
        AL_WeakSelf(self);
        [closeBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf removeFromSuperview];
            if(weakSelf.viewClickRemove) {
                weakSelf.viewClickRemove();
            }
        }];
    }
    return self;
}

@end

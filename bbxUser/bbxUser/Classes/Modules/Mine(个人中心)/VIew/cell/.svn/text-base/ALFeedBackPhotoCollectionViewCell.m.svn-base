//
//  ALFeedBackPhotoCollectionViewCell.m
//  bbxUser
//
//  Created by along on 2017/8/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALFeedBackPhotoCollectionViewCell.h"

@interface ALFeedBackPhotoCollectionViewCell ()
@property (nonatomic, strong) UIImageView *photoIV;
@end

@implementation ALFeedBackPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self.photoIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        [self.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeZero radius:1];

    }
    return self;
}

- (void)setImg:(UIImage *)img {
    _img = img;
    _photoIV.image = img;
}

#pragma mark lzy load
- (UIImageView *)photoIV {
    if(!_photoIV) {
        _photoIV = [[UIImageView alloc] init];
        [self addSubview:_photoIV];
    }
    return _photoIV;
}
@end

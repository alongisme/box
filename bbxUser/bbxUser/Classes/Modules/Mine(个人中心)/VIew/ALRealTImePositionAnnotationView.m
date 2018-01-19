//
//  ALRealTImePositionAnnotationVIew.m
//  bbxUser
//
//  Created by along on 2017/8/25.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALRealTImePositionAnnotationView.h"

@implementation ALRealTImePositionAnnotationView

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBounds:CGRectMake(0.f, 0.f, 48.f, 54.f)];

        [self setBackgroundColor:[UIColor clearColor]];
        
        _annotationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 42, 42)];
        _annotationImageView.contentMode = UIViewContentModeScaleAspectFill;
        _annotationImageView.layer.masksToBounds = YES;
        _annotationImageView.layer.cornerRadius = 21;
        [self addSubview:_annotationImageView];
        
        UIImageView *bgIV = [[UIImageView alloc] initWithFrame:self.bounds];
        bgIV.image = [UIImage imageNamed:@"baobiaoweizhi"];
        [self addSubview:bgIV];
    }
    return self;
}

@end

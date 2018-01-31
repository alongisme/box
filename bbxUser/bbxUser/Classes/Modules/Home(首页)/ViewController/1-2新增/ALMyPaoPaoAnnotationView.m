//
//  ALMyPaoPaoAnnotationView.m
//  bbxUser
//
//  Created by xlshi on 2018/1/30.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALMyPaoPaoAnnotationView.h"

@implementation ALMyPaoPaoAnnotationView
- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setCustomView:(UIView *)customView {
    _customView = customView;
    
    [self addSubview:customView];
}
@end

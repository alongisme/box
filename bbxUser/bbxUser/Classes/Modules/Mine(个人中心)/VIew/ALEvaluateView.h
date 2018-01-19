//
//  ALEvaluateView.h
//  bbxUser
//
//  Created by along on 2017/8/8.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALShadowView.h"
#import "WSStarRatingView.h"
#import "ALOrderModel.h"

@interface ALEvaluateView : ALShadowView
@property (nonatomic, assign) float score;
@property (nonatomic, strong) IQTextView *textView;
@property (nonatomic, copy) NSString *tagString;
- (instancetype)initWithFrame:(CGRect)frame securityModel:(ALSecurityModel *)securityModel titleDataArray:(NSArray *)titleDataArray index:(unsigned int)index;
@end

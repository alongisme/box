//
//  ALGoodBusinessView.h
//  bbxUser
//
//  Created by along on 2017/8/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALShadowView.h"
#import "ALCustomTagView.h"
//#import "ClickedLabelView.h"

@interface ALGoodBusinessView : ALShadowView
//@property (nonatomic, weak) ClickedLabelView *clickedLabelView;
@property (nonatomic, weak) ALCustomTagView *customTagView;
- (instancetype)initWithFrame:(CGRect)frame tag:(NSString *)tag;
@end

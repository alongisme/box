//
//  ALServerTagView.h
//  bbxServer
//
//  Created by along on 2017/8/30.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALShadowView.h"
//#import "ClickedLabelView.h"
#import "ALCustomTagsView.h"

@protocol ALServerTagDelegate <NSObject>
- (void)clickedLabVievUpdate:(NSUInteger)value;
@end

@interface ALServerTagView : ALShadowView
@property (nonatomic, weak) id<ALServerTagDelegate> delegate;
//@property (nonatomic, strong) ClickedLabelView *clickedLabelView;
@property (nonatomic, strong) ALCustomTagsView *customTagsView;
@end

//
//  ClickedLabelView.h
//  bbxUser
//
//  Created by along on 2017/8/9.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClickedLabelView : UIView
//最大的y值
@property (nonatomic, assign) CGFloat maxY;

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray startMargin:(CGFloat)startMargin;
//获取所有选择的标签
- (NSString *)getSelectedTagString;
@end

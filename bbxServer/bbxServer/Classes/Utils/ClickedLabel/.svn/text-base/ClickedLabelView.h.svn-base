//
//  ClickedLabelView.h
//  bbxUser
//
//  Created by along on 2017/8/9.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClickedLabelView : UIView
//只显示
@property (nonatomic, assign) BOOL onlyShow;
//最大的y值
@property (nonatomic, assign) CGFloat maxY;
//是否保安评价 如果是默认选择前三个
@property (nonatomic, assign) BOOL securityEva;
//评价界面
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray startMargin:(CGFloat)startMargin;
//有阴影圆角
- (instancetype)initWithShadowFrame:(CGRect)frame dataArray:(NSArray *)dataArray;
- (instancetype)initWithShadowFrame:(CGRect)frame dataArray:(NSArray *)dataArray startMargin:(CGFloat)startMargin;
//获取所有选择的标签
- (NSString *)getSelectedTagString;

//获取所有选择的服务标签
- (NSString *)getSelectedServerTagString;
@end

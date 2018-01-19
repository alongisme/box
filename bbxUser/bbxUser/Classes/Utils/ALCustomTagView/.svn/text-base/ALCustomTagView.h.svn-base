//
//  ALCustomTagView.h
//  bbxUser
//
//  Created by along on 2017/9/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALCommentTagModel.h"

@interface ALCustomTagView : UIView
//选中标签数组
@property (nonatomic, strong) NSArray *selectedTagArray;
//全选
@property (nonatomic, assign) BOOL selectedAll;
//是否保安评价 如果是默认选择前三个
@property (nonatomic, assign) BOOL securityEva;
//蓝色底色
@property (nonatomic, assign) BOOL showEva;
//带阴影圆角的初始化
- (instancetype)initWithShadowFrame:(CGRect)frame tagArray:(NSArray *)tagArray startOffsetX:(CGFloat)startOffsetX space:(CGFloat)space expandHeight:(CGFloat)expandHeight selected:(BOOL)selected;
//默认初始化
- (instancetype)initWithFrame:(CGRect)frame tagArray:(NSArray *)tagArray startOffsetX:(CGFloat)startOffsetX space:(CGFloat)space expandHeight:(CGFloat)expandHeight selected:(BOOL)selected;
//获取所有选择的标签
- (NSString *)getSelectedTagString;
@end

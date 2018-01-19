//
//  ALCustomTagView.m
//  bbxUser
//
//  Created by along on 2017/9/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCustomTagView.h"

@interface ALCustomTagView ()
@property (nonatomic, strong) NSArray *tagArray;
@property (nonatomic, strong) NSMutableArray *tagButtonArray;
@end

@implementation ALCustomTagView

- (instancetype)initWithShadowFrame:(CGRect)frame tagArray:(NSArray *)tagArray startOffsetX:(CGFloat)startOffsetX space:(CGFloat)space expandHeight:(CGFloat)expandHeight selected:(BOOL)selected {
    ALCustomTagView *customView = [self initWithFrame:frame tagArray:tagArray startOffsetX:startOffsetX space:space expandHeight:expandHeight selected:selected];
    customView.backgroundColor = [UIColor whiteColor];
    customView.layer.cornerRadius = 5;
    [customView.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeZero radius:1];
    return customView;
}

- (instancetype)initWithFrame:(CGRect)frame tagArray:(NSArray *)tagArray startOffsetX:(CGFloat)startOffsetX space:(CGFloat)space expandHeight:(CGFloat)expandHeight selected:(BOOL)selected {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _tagArray = tagArray;
        _tagButtonArray = [NSMutableArray array];
        
        CGFloat tagWidth = (frame.size.width - 2 * startOffsetX - 2 * space) / 3.0f;
        CGFloat tagHeight = 26;
        
        for (unsigned int i = 0; i < tagArray.count; i++) {
            ALCommentTagModel *model = tagArray[i];

            UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
            tagButton.frame = CGRectMake(startOffsetX + i % 3 * (tagWidth + space), i / 3 * tagHeight + (i / 3 + 1) * expandHeight, tagWidth, tagHeight);
            tagButton.userInteractionEnabled = selected;
            tagButton.layer.masksToBounds = YES;
            tagButton.layer.cornerRadius = tagHeight / 2.0;
            tagButton.layer.borderColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00].CGColor;
            [tagButton setTitleColor:[UIColor colorWithRGBA:ALLabelTextColor] forState:UIControlStateNormal];
            tagButton.layer.borderWidth = 1;
            tagButton.backgroundColor = [UIColor clearColor];
            tagButton.titleLabel.font = ALThemeFont(12);
            [tagButton setTitle:model.commentTagDes forState:UIControlStateNormal];
            [tagButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:tagButton];
            [_tagButtonArray addObject:tagButton];
        }
    }
    return self;
}

- (void)handleButton:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        button.backgroundColor = [UIColor colorWithRGBA:ALThemeColor];
        button.layer.borderColor = [UIColor colorWithRGBA:ALThemeColor].CGColor;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        if(!_showEva) {
            button.layer.borderColor = [UIColor colorWithRGBA:ALThemeColor].CGColor;
            [button setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor clearColor];
        } else {
            button.layer.borderColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00].CGColor;
            button.backgroundColor = [UIColor clearColor];
            [button setTitleColor:[UIColor colorWithRGBA:ALLabelTextColor] forState:UIControlStateNormal];
        }
    }
}

- (void)setSelectedTagArray:(NSArray *)selectedTagArray {
    _selectedTagArray = selectedTagArray;
    
    for (UIButton *btn in self.tagButtonArray) {
        for (NSString *tagString in selectedTagArray) {
            if([btn.titleLabel.text isEqualToString:tagString]) {
                [self handleButton:btn];
            }
        }
    }
}

- (void)setSelectedAll:(BOOL)selectedAll {
    _selectedAll = selectedAll;
    if(selectedAll) {
        for (UIButton *btn in _tagButtonArray) {
            [self handleButton:btn];
        }
    }
}

- (void)setSecurityEva:(BOOL)securityEva {
    _securityEva = securityEva;
    
    if(securityEva) {
        UIButton *btn1 = _tagButtonArray[0];
        UIButton *btn2 = _tagButtonArray[1];
        UIButton *btn3 = _tagButtonArray[2];
        [self handleButton:btn1];
        [self handleButton:btn2];
        [self handleButton:btn3];
    }
}

- (NSString *)getSelectedTagString {
    NSString *tagString = @"";
    for (UIButton *btn in _tagButtonArray) {
        if(btn.isSelected) {
            for (ALCommentTagModel *model in _tagArray) {
                if([model.commentTagDes isEqualToString:btn.titleLabel.text]) {
                    if([model.commentTag isVaild]) {
                        tagString = [tagString stringByAppendingString:model.commentTag];
                    } else {
                        tagString = [tagString stringByAppendingString:model.commentTagDes];
                    }
                    tagString = [tagString stringByAppendingString:@","];
                }
            }
        }
    }
    return [tagString substringToIndex:tagString.length - 1];
}

- (void)setShowEva:(BOOL)showEva {
    _showEva  = showEva;
        for (UIButton *btn in _tagButtonArray) {
            btn.layer.borderColor = [UIColor colorWithRGBA:ALThemeColor].CGColor;
            [btn setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateNormal];
            if(showEva)
                [btn removeTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        }
}


@end

//
//  ClickedLabelView.m
//  bbxUser
//
//  Created by along on 2017/8/9.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ClickedLabelView.h"

@interface ClickedLabelView ()
@property (nonatomic, strong) NSMutableArray *subsArray;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ClickedLabelView

- (instancetype)initWithShadowFrame:(CGRect)frame dataArray:(NSArray *)dataArray {
    ClickedLabelView *view = [self initWithFrame:frame dataArray:dataArray startMargin:0];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5;
    [view.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeZero radius:1];
    
    return view;
}

- (instancetype)initWithShadowFrame:(CGRect)frame dataArray:(NSArray *)dataArray startMargin:(CGFloat)startMargin {
    ClickedLabelView *view = [self initWithFrame:frame dataArray:dataArray startMargin:startMargin];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5;
    [view.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeZero radius:1];
    
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray {
    ClickedLabelView *view = [self initWithFrame:frame dataArray:dataArray startMargin:0];
    view.backgroundColor = [UIColor whiteColor];    
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray startMargin:(CGFloat)startMargin {
    if(self = [super initWithFrame:frame]) {
        _subsArray = [NSMutableArray array];
        _dataArray = dataArray;
        self.backgroundColor = [UIColor whiteColor];
        int width = 0;
        int height = 0;
        int number = 0;
        int han = startMargin;
        int margin = 20;
        
        //创建button
        for (int i = 0; i < dataArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 300 + i;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_subsArray addObject:button];
            
            ALCommentTagModel *model = dataArray[i];
            
            CGSize titleSize = [model.commentTagDes boundingRectWithSize:CGSizeMake(999, 24) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ALThemeFont(12)} context:nil].size;
            if(startMargin == 15) {
                titleSize.width += 35;
            } else if(startMargin == 10) {
                if(ALScreenWidth == 320) {
                    titleSize.width += 35;
                    margin = 15;
                } else {
                    titleSize.width += 40;
                }
            } else {
                if(ALScreenWidth == 320) {
                    titleSize.width += 35;
                } else {
                    titleSize.width += 40;
                }
                margin = 10;
            }
            
            //自动的折行
            han = han + titleSize.width + margin;
            if (han > frame.size.width + margin) {
                han = startMargin;
                han = han + titleSize.width;
                height++;
                width = 0;
                width = width + titleSize.width;
                number = 0;
                button.frame = CGRectMake(startMargin, 10 + 32 * height, titleSize.width, 24);
            }else{
                button.frame = CGRectMake(startMargin + width + (number * margin), 10 + 32 * height, titleSize.width, 24);
                width = width + titleSize.width;
            }
            
            _maxY = CGRectGetMaxY(button.frame);
            
            number++;
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 12;
            button.layer.borderColor = [UIColor colorWithRGBA:ALThemeColor].CGColor;
            button.layer.borderWidth = 1;
            button.backgroundColor = [UIColor clearColor];
            button.titleLabel.font = ALThemeFont(14);
            [button setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateNormal];
            [button setTitle:model.commentTagDes forState:UIControlStateNormal];
            [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    return self;
}

- (void)handleButton:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        button.backgroundColor = [UIColor colorWithRGBA:ALThemeColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateNormal];
    }
}

- (void)setSecurityEva:(BOOL)securityEva {
    _securityEva = securityEva;
    
    if(securityEva) {
        UIButton *btn1 = _subsArray[0];
        UIButton *btn2 = _subsArray[1];
        UIButton *btn3 = _subsArray[2];
        [self handleButton:btn1];
        [self handleButton:btn2];
        [self handleButton:btn3];
    }
}

- (void)setOnlyShow:(BOOL)onlyShow {
    _onlyShow = onlyShow;
    
    if(onlyShow) {
        for (UIButton *btn in _subsArray) {
            btn.layer.borderColor = [UIColor colorWithRGBA:ALThemeColor].CGColor;
            [btn setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateNormal];
            [btn removeTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (NSString *)getSelectedTagString {
    NSString *tagString = @"";
    for (UIButton *btn in _subsArray) {
        if(btn.isSelected) {
            for (ALCommentTagModel *model in _dataArray) {
                if([model.commentTagDes isEqualToString:btn.titleLabel.text]) {
                    tagString = [tagString stringByAppendingString:model.commentTag];
                    tagString = [tagString stringByAppendingString:@","];
                }
            }
        }
    }
    return tagString;
}

- (NSString *)getSelectedServerTagString {
    NSString *tagString = @"";
    for (UIButton *btn in _subsArray) {
        if(btn.isSelected) {
            for (ALCommentTagModel *model in _dataArray) {
                if([model.commentTagDes isEqualToString:btn.titleLabel.text]) {
                    tagString = [tagString stringByAppendingString:model.commentTagDes];
                    tagString = [tagString stringByAppendingString:@","];
                }
            }
        }
    }
    if(tagString.length > 0) {
        tagString = [tagString substringToIndex:tagString.length - 1];
    }
    return tagString;
}
@end

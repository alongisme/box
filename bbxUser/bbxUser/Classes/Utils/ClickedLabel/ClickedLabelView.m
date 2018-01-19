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
@property (nonatomic, strong) NSMutableArray *gouArray;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ClickedLabelView
- (instancetype)initWithShadowFrame:(CGRect)frame dataArray:(NSArray *)dataArray startMargin:(CGFloat)startMargin {
    ClickedLabelView *view = [self initWithFrame:frame dataArray:dataArray startMargin:startMargin];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5;
    [view.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeZero radius:1];
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
            
            NSString *titleString = dataArray[i];
            
            CGSize titleSize = [titleString boundingRectWithSize:CGSizeMake(999, 30) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ALThemeFont(12)} context:nil].size;
                titleSize.width += 25;
            
            //自动的折行
            han = han + titleSize.width + margin;
            if (han > frame.size.width + margin) {
                han = startMargin;
                han = han + titleSize.width;
                height++;
                width = 0;
                width = width + titleSize.width;
                number = 0;
                button.frame = CGRectMake(startMargin, 10 + 32 * height, titleSize.width, 30);
            }else{
                button.frame = CGRectMake(startMargin + width + (number * margin), 10 + 32 * height, titleSize.width, 30);
                width = width + titleSize.width;
            }
            
            _maxY = CGRectGetMaxY(button.frame);
            
            number++;
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 5;
            button.layer.borderColor = [UIColor colorWithRGBA:ALLabelTextColor].CGColor;
            button.layer.borderWidth = 1;
            button.backgroundColor = [UIColor clearColor];
            button.titleLabel.font = ALThemeFont(12);
            [button setTitleColor:[UIColor colorWithRGBA:ALLabelTextColor] forState:UIControlStateNormal];
            [button setTitle:titleString forState:UIControlStateNormal];
            [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            UIImageView *gouIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gou"]];
            gouIV.frame = CGRectMake(CGRectGetMaxX(button.frame) - 10, 0, 20, 20);
            gouIV.hidden = YES;
            [self addSubview:gouIV];
            
            [self.gouArray addObject:gouIV];
        }
    }
    return self;
}

- (void)handleButton:(UIButton *)button {
    NSUInteger tagIndex = button.tag - 300;
    UIImageView *gouIV = _gouArray[tagIndex];
    if(button.selected) {
        gouIV.hidden = YES;
    } else {
        gouIV.hidden = NO;
    }
    button.selected = !button.selected;
}

- (NSString *)getSelectedTagString {
    NSString *tagString = @"";
    for (UIButton *btn in _subsArray) {
        if(btn.isSelected) {
            for (NSString *string in _dataArray) {
                if([string isEqualToString:btn.titleLabel.text]) {
                    tagString = [tagString stringByAppendingString:string];
                    tagString = [tagString stringByAppendingString:@","];
                }
            }
        }
    }
    if([tagString isEqualToString:@""]) {
        return @"";
    }
    return [tagString substringToIndex:tagString.length - 1];
}

- (NSMutableArray *)gouArray {
    if(!_gouArray) {
        _gouArray = [NSMutableArray array];
    }
    return _gouArray;
}
@end

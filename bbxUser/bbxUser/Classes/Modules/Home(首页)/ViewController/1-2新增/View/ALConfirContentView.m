//
//  ALConfirContentView.m
//  bbxUser
//
//  Created by xlshi on 2018/1/22.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALConfirContentView.h"

@interface ALConfirContentView()
@property (nonatomic, strong) ALLabel *contentLab;
@property (nonatomic, strong) NSString *content;
@end

@implementation ALConfirContentView

- (instancetype)initWithFrame:(CGRect)frame content:(NSString *)content {
    if(self = [super initWithFrame:frame]) {
        self.content = content;
        
        [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(14, 14, 14, 14));
        }];
    }
    return self;
}

- (CGFloat)contentHeight {
    return [self.contentLab.text heightForFont:self.contentLab.font width:ALScreenWidth - 28 - 28];
}

- (ALLabel *)contentLab {
    if(!_contentLab) {
        _contentLab = [[ALLabel alloc] init];
        _contentLab.font = ALThemeFont(15);
        _contentLab.textColor = [UIColor colorWithRGB:0x333333];
        _contentLab.textAlignment = NSTextAlignmentRight;
        _contentLab.numberOfLines = 0;

        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[self.content isVaild] ? [NSString stringWithFormat:@"备注：%@",self.content] : @""];
        attStr.yy_lineSpacing = 4;
        _contentLab.attributedText = attStr;
        [self addSubview:_contentLab];
    }
    return _contentLab;
}
@end

//
//  ALGoodBusinessView.m
//  bbxUser
//
//  Created by along on 2017/8/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALGoodBusinessView.h"
#import "ALCommentTagModel.h"

@interface ALGoodBusinessView ()
@property (nonatomic, strong) ALLabel *commentLab;
@property (nonatomic, strong) UIView *hLineView;
@property (nonatomic, copy) NSString *labTag;
@end

@implementation ALGoodBusinessView
- (instancetype)initWithFrame:(CGRect)frame tag:(NSString *)tag {
    if(self = [super initWithFrame:frame]) {
        _labTag = tag;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(@14);
        }];

        [self.hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commentLab.mas_bottom).offset(8);
            make.left.right.equalTo(@0);
            make.height.equalTo(@1);
        }];
        
        UIView *whiteBgView = [[UIView alloc] init];
        whiteBgView.backgroundColor = [UIColor clearColor];
        [self addSubview:whiteBgView];
        
        [whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.top.equalTo(self.hLineView.mas_bottom);
        }];
        
        [self layoutIfNeeded];
        
        NSArray *tagArr = [tag componentsSeparatedByString:@","];
        NSMutableArray *comnetTagArray = [NSMutableArray array];
        for (NSString *tagString in tagArr) {
            if([tagString isVaild]) {
                ALCommentTagModel *commentTagModel = [ALCommentTagModel new];
                commentTagModel.commentTagDes = tagString;
                [comnetTagArray addObject:commentTagModel];
            }
        }
        
        ALCustomTagView *customTagView = [[ALCustomTagView alloc] initWithFrame:CGRectMake(14, 0, self.frame.size.width - 28,  ([self formatLabelArray].count / 3 + 1) * (20 + 10) + 10) tagArray:[self formatLabelArray] startOffsetX:0 space:10 expandHeight:10 selected:NO];
        customTagView.showEva = YES;
        [whiteBgView addSubview:customTagView];
        self.customTagView = customTagView;

//        ClickedLabelView *clickedLabView = [[ClickedLabelView alloc] initWithFrame:CGRectMake(14, 0, self.frame.size.width - 28, CGRectGetHeight(whiteBgView.frame) - 12) dataArray:[self formatLabelArray] startMargin:0];
//        clickedLabView.onlyShow = YES;
//        [whiteBgView addSubview:clickedLabView];
//        self.clickedLabelView = clickedLabView;
//
//        clickedLabView.frame = CGRectMake(14, 0, self.frame.size.width - 28,clickedLabView.maxY );
    }
    return self;
}

- (NSArray *)formatLabelArray {
    NSMutableArray *comnetTagArray = [NSMutableArray array];
    for (NSString *tagString in [_labTag componentsSeparatedByString:@","]) {
        if([tagString isVaild]) {
            ALCommentTagModel *commentTagModel = [ALCommentTagModel new];
            commentTagModel.commentTagDes = tagString;
            [comnetTagArray addObject:commentTagModel];
        }
    }
    return comnetTagArray;
}

#pragma mark lazy load
- (ALLabel *)commentLab {
    if(!_commentLab) {
        _commentLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _commentLab.text = @"擅长业务";
    [self addSubview:_commentLab];
}
    return _commentLab;
}

- (UIView *)hLineView {
    if(!_hLineView) {
        _hLineView = [[UIView alloc] init];
        _hLineView.backgroundColor = [UIColor colorWithRGBA:0xF5F6FAFF];
        [self addSubview:_hLineView];
    }
    return _hLineView;
}
@end

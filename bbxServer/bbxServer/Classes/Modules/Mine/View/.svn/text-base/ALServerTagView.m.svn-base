//
//  ALServerTagView.m
//  bbxServer
//
//  Created by along on 2017/8/30.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALServerTagView.h"
#import "ALUserInfoModel.h"
#import "ALCommentTagModel.h"

@interface ALServerTagView ()
@property (nonatomic, strong) ALLabel *titleLab;
@property (nonatomic, strong) UIView *hLineView;
@end

@implementation ALServerTagView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@14);
    }];
    
    [self.hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(self.titleLab.mas_bottom).offset(8);
    }];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (ALSkillTagListModel *skillModel in AL_MyAppDelegate.userModel.userInfoModel.skillTagList) {
        ALCommentTagModel *tagModel = [[ALCommentTagModel alloc] init];
        tagModel.commentTagDes = skillModel.skillTagDes;
        [arr addObject:tagModel];
    }
    
    [self layoutIfNeeded];
    
    ALCustomTagsView *customTagsView = [[ALCustomTagsView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.hLineView.frame), self.frame.size.width, (arr.count / 3 + 1) * (20 + 10) + 10) tagArray:arr startOffsetX:14 space:10 expandHeight:10 selected:NO];
    customTagsView.showEva = YES;
    [self addSubview:customTagsView];
    self.customTagsView = customTagsView;
//    self.clickedLabelView.frame = CGRectMake(0, CGRectGetMaxY(self.hLineView.frame), self.frame.size.width, _clickedLabelView.maxY + 10);
    
    if([self.delegate respondsToSelector:@selector(clickedLabVievUpdate:)]) {
        [self.delegate clickedLabVievUpdate:CGRectGetMaxY(self.customTagsView.frame)];
    }
}

#pragma mark lazy load 
- (ALLabel *)titleLab {
    if(!_titleLab) {
        _titleLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _titleLab.text = @"服务标签";
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

- (UIView *)hLineView {
    if(!_hLineView) {
        _hLineView = [[UIView alloc] init];
        _hLineView.backgroundColor = [UIColor colorWithRGBA:ALVCbgColor];
        [self addSubview:_hLineView];
    }
    return _hLineView;
}

//- (ClickedLabelView *)clickedLabelView {
//    if(!_clickedLabelView) {
//        [self layoutIfNeeded];
//        NSMutableArray *arr = [NSMutableArray array];
//        for (ALSkillTagListModel *skillModel in AL_MyAppDelegate.userModel.userInfoModel.skillTagList) {
//            ALCommentTagModel *tagModel = [[ALCommentTagModel alloc] init];
//            tagModel.commentTagDes = skillModel.skillTagDes;
//            [arr addObject:tagModel];
//        }
//
//        _clickedLabelView = [[ClickedLabelView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.hLineView.frame), self.frame.size.width, 100) dataArray:arr startMargin:14];
//        _clickedLabelView.onlyShow = YES;
//        [self addSubview:_clickedLabelView];
//    }
//    return _clickedLabelView;
//}
@end

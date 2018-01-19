//
//  ALServerTagViewController.m
//  bbxUser
//
//  Created by along on 2017/9/20.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALServerTagViewController.h"
//#import "ClickedLabelView.h"
#import "ALCustomTagView.h"

@interface ALServerTagViewController ()
@property (nonatomic, strong) ALLabel *msgLab;
@property (nonatomic, strong) ALActionButton *okBtn;
//@property (nonatomic, strong) ClickedLabelView *clickedLabelView;
@property (nonatomic, strong) ALCustomTagView *customTagView;
@end

@implementation ALServerTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"服务类型";
    
    [self initSubviews];
}

- (void)initSubviews {
    [self.msgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.top.equalTo(@108);
    }];
    
    [self.view layoutIfNeeded];
    
    _customTagView = [[ALCustomTagView alloc] initWithShadowFrame:CGRectMake(14, CGRectGetMaxY(self.msgLab.frame) + 10, CGRectGetWidth(self.view.bounds) - 28, (_tagArray.count / 3 + 1) * (20 + 10)) tagArray:_tagArray startOffsetX:10 space:10 expandHeight:10 selected:YES];
    _customTagView.showEva = NO;
    [self.view addSubview:_customTagView];
//    _clickedLabelView = [[ClickedLabelView alloc] initWithShadowFrame:CGRectMake(14, CGRectGetMaxY(self.msgLab.frame) + 10, CGRectGetWidth(self.view.bounds) - 28, 0) dataArray:_tagArray startMargin:10];
//    [self.view addSubview:_clickedLabelView];
//
//    _clickedLabelView.frame = CGRectMake(14, CGRectGetMaxY(self.msgLab.frame) + 10, CGRectGetWidth(self.view.bounds) - 28, _clickedLabelView.maxY + 10);
    
//    _clickedLabelView.selectedTagArray = [_tagString componentsSeparatedByString:@","];
    _customTagView.selectedTagArray = [_tagString componentsSeparatedByString:@","];
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.bottom.equalTo(@-15);
    }];
}

- (void)okButtonAction {
    NSString *tagString = [_customTagView getSelectedTagString];
    if(![tagString isVaild]) {
        [ALKeyWindow showHudError:@"请选择服务类型～"];
        return;
    }
    if([self.delegate respondsToSelector:@selector(getAllSelectedTag:)]) {
        [self.delegate getAllSelectedTag:tagString];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark lazy load
- (ALLabel *)msgLab {
    if(!_msgLab) {
        _msgLab = [[ALLabel alloc] init];
        _msgLab.numberOfLines = 0;
        _msgLab.textAlignment = NSTextAlignmentLeft;
        _msgLab.text = @"请选择服务标签，我们将根据您的需求，为您挑选合适的保安";
        [self.view addSubview:_msgLab];
    }
    return _msgLab;
}

- (ALActionButton *)okBtn {
    if(!_okBtn) {
        _okBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        [_okBtn addTarget:self action:@selector(okButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.view addSubview:_okBtn];
    }
    return _okBtn;
}
@end

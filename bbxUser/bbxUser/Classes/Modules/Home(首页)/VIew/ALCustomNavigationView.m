//
//  ALCustomNavigationView.m
//  bbxUser
//
//  Created by xlshi on 2017/11/6.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCustomNavigationView.h"
#import "ALMineViewController.h"
#import "ALInstructionsViewController.h"

@interface ALCustomNavigationView ()
@property (nonatomic, strong) UIButton *instructionsBtn;
@property (nonatomic, strong) UIButton *mineBtn;
@property (nonatomic, strong) ALLabel *titleLab;
@end

@implementation ALCustomNavigationView

- (instancetype)init {
    if(self = [super init]) {
        self.backgroundColor = [UIColor colorWithRGBA:ALThemeColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.instructionsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        if(ALScreenHeight == 812) {
            make.top.equalTo(@45);
        } else {
            make.top.equalTo(@30);
        }
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.instructionsBtn);
    }];
    
    [self.mineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-14);
        make.centerY.equalTo(self.instructionsBtn);
    }];
    
    [self.segmentedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(212, 26));
        make.bottom.equalTo(@-11);
    }];
}

- (void)instructionButtonAction {
    [MobClick event:ALMobEventID_B3];
    [ALKeyWindow.currentViewController.navigationController pushViewController:[ALInstructionsViewController new] animated:YES];
}

- (void)mineButtonAction {
    if(AL_MyAppDelegate.userModel.idModel.userId) {
        [MobClick event:ALMobEventID_B4];
        ALBaseNavigationController *navigationC = [[ALBaseNavigationController alloc] initWithRootViewController:[[ALMineViewController alloc] init]];
        [ALKeyWindow.currentViewController presentViewController:navigationC animated:YES completion:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:ReSetToLoginModule object:nil];
    }
}


#pragma mark lazy load
- (UIButton *)instructionsBtn {
    if(!_instructionsBtn) {
        _instructionsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_instructionsBtn setBackgroundImage:[UIImage imageNamed:@"icon-shiyonggonglue"] forState:UIControlStateNormal];
        [_instructionsBtn addTarget:self action:@selector(instructionButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_instructionsBtn];
    }
    return _instructionsBtn;
}

- (UIButton *)mineBtn {
    if(!_mineBtn) {
        _mineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mineBtn setBackgroundImage:[UIImage imageNamed:@"icon-Personal Center"] forState:UIControlStateNormal];
        [_mineBtn addTarget:self action:@selector(mineButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_mineBtn];
    }
    return _mineBtn;
}

- (ALLabel *)titleLab {
    if(!_titleLab) {
        _titleLab = [[ALLabel alloc] init];
        _titleLab.text = @"镖镖";
        _titleLab.font = ALMediumTitleFont(17);
        _titleLab.textColor = [UIColor whiteColor];
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

- (ALSegmentedView *)segmentedView {
    if(!_segmentedView) {
        _segmentedView = [[ALSegmentedView alloc] initWithFrame:CGRectZero style:ALSegmentedStyleMainPage];
        [self addSubview:_segmentedView];
    }
    return _segmentedView;
}
@end

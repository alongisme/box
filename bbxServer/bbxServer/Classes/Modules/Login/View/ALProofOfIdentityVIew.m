//
//  ALProofOfIdentityVIew.m
//  bbxServer
//
//  Created by along on 2017/8/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALProofOfIdentityVIew.h"

@implementation ALProofOfIdentityVIew

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        AL_WeakSelf(self);
        UIImageView *correctSideIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhengmian"]];
        correctSideIV.userInteractionEnabled = YES;
        [self addSubview:correctSideIV];
        
        UIImageView *oppositeSideIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fanmian"]];
        oppositeSideIV.userInteractionEnabled = YES;
        [self addSubview:oppositeSideIV];
        
        UIImageView *holdIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shouchi"]];
        holdIV.userInteractionEnabled = YES;
        [self addSubview:holdIV];
    
        [@[correctSideIV,oppositeSideIV,holdIV] mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
        
        [@[correctSideIV,oppositeSideIV,holdIV] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self).multipliedBy(0.5);
            make.centerX.equalTo(self);
        }];
        
        UIButton *correctSideDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        correctSideDeleteBtn.hidden = YES;
        [correctSideDeleteBtn setBackgroundImage:[UIImage imageNamed:@"icon-delete photo"] forState:UIControlStateNormal];
        [self addSubview:correctSideDeleteBtn];
        
        [correctSideDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(22, 23));
            make.right.equalTo(correctSideIV.mas_right).offset(11);
            make.top.equalTo(correctSideIV.mas_top).offset(-11.5);
        }];
        
        UIButton *oppositeSideDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        oppositeSideDeleteBtn.hidden = YES;
        [oppositeSideDeleteBtn setBackgroundImage:[UIImage imageNamed:@"icon-delete photo"] forState:UIControlStateNormal];
        [self addSubview:oppositeSideDeleteBtn];
        
        [oppositeSideDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(22, 23));
            make.right.equalTo(oppositeSideIV.mas_right).offset(11);
            make.top.equalTo(oppositeSideIV.mas_top).offset(-11.5);
        }];
        
        UIButton *holdDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        holdDeleteBtn.hidden = YES;
        [holdDeleteBtn setBackgroundImage:[UIImage imageNamed:@"icon-delete photo"] forState:UIControlStateNormal];
        [self addSubview:holdDeleteBtn];
        
        [holdDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(22, 23));
            make.right.equalTo(holdIV.mas_right).offset(11);
            make.top.equalTo(holdIV.mas_top).offset(-11.5);
        }];
        
        
        //action
        
        UITapGestureRecognizer *correctSideTap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [ALAlertViewController showAlertOnlyCancelButton:AL_MyAppDelegate.window.rootViewController title:nil message:nil style:UIAlertControllerStyleActionSheet alertArray:@[@"从相册选择",@"拍照"] clickBlock:^(int index) {
                [ALImagePickerController ImagePickerWithDelegate:AL_MyAppDelegate.window.rootViewController SourceType:index == 0 ? UIImagePickerControllerSourceTypePhotoLibrary : UIImagePickerControllerSourceTypeCamera Edit:NO choseImageBlcok:^(UIImage *image, NSDictionary *info) {
                    correctSideIV.image = image;
                    correctSideIV.userInteractionEnabled = NO;
                    correctSideDeleteBtn.hidden = NO;
                    weakSelf.zhengmianImage = image;
                } cannelBlock:nil];
            }];
        }];
        [correctSideIV addGestureRecognizer:correctSideTap];
        
        UITapGestureRecognizer *oppositeSideTap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [ALAlertViewController showAlertOnlyCancelButton:AL_MyAppDelegate.window.rootViewController title:nil message:nil style:UIAlertControllerStyleActionSheet alertArray:@[@"从相册选择",@"拍照"] clickBlock:^(int index) {
                [ALImagePickerController ImagePickerWithDelegate:AL_MyAppDelegate.window.rootViewController SourceType:index == 0 ? UIImagePickerControllerSourceTypePhotoLibrary : UIImagePickerControllerSourceTypeCamera Edit:NO choseImageBlcok:^(UIImage *image, NSDictionary *info) {
                    oppositeSideIV.image = image;
                    oppositeSideIV.userInteractionEnabled = NO;
                    oppositeSideDeleteBtn.hidden = NO;
                    weakSelf.fanmianImage = image;
                } cannelBlock:nil];
            }];
        }];
        [oppositeSideIV addGestureRecognizer:oppositeSideTap];
        
        UITapGestureRecognizer *holdTap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [ALAlertViewController showAlertOnlyCancelButton:AL_MyAppDelegate.window.rootViewController title:nil message:nil style:UIAlertControllerStyleActionSheet alertArray:@[@"从相册选择",@"拍照"] clickBlock:^(int index) {
                [ALImagePickerController ImagePickerWithDelegate:AL_MyAppDelegate.window.rootViewController SourceType:index == 0 ? UIImagePickerControllerSourceTypePhotoLibrary : UIImagePickerControllerSourceTypeCamera Edit:NO choseImageBlcok:^(UIImage *image, NSDictionary *info) {
                    holdIV.image = image;
                    holdIV.userInteractionEnabled = NO;
                    holdDeleteBtn.hidden = NO;
                    weakSelf.shouchiImage = image;
                } cannelBlock:nil];
            }];
        }];
        [holdIV addGestureRecognizer:holdTap];
        
        [correctSideDeleteBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            correctSideIV.image = [UIImage imageNamed:@"zhengmian"];
            sender.hidden = YES;
            correctSideIV.userInteractionEnabled = YES;
            weakSelf.zhengmianImage = nil;
        }];
        
        [oppositeSideDeleteBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            oppositeSideIV.image = [UIImage imageNamed:@"fanmian"];
            sender.hidden = YES;
            oppositeSideIV.userInteractionEnabled = YES;
            weakSelf.fanmianImage = nil;
        }];
        
        [holdDeleteBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            holdIV.image = [UIImage imageNamed:@"shouchi"];
            sender.hidden = YES;
            holdIV.userInteractionEnabled = YES;
            weakSelf.shouchiImage = nil;
        }];
    }
    return self;
}

@end

//
//  ALIdentityInformationView.m
//  bbxServer
//
//  Created by along on 2017/8/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALIdentityInformationView.h"
#import "ALProofOfIdentityVIew.h"

@interface ALIdentityInformationView ()
@property (nonatomic, strong) ALLabel *headInfoLab;
@property (nonatomic, strong) ALShadowView *headView;

@property (nonatomic, strong) ALLabel *identityInfoLab;
@property (nonatomic, strong) ALShadowView *identityView;

@property (nonatomic, strong) ALLabel *photoLab;
@property (nonatomic, strong) ALProofOfIdentityVIew *proofOfIdentityView;

@property (nonatomic, strong) ALActionButton *nextBtn;
@end

@implementation ALIdentityInformationView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self.headInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@12);
        }];
        
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self).offset(-28);
            make.centerX.equalTo(self);
            make.height.equalTo(@84);
            make.top.equalTo(self.headInfoLab.mas_bottom).offset(10);
        }];
        
        [self.identityInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_bottom).offset(12);
            make.left.equalTo(self.headInfoLab);
        }];
        
        [self.identityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(self.headView);
            make.height.equalTo(@91);
            make.top.equalTo(self.identityInfoLab.mas_bottom).offset(10);
        }];
        
        [self.photoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headInfoLab);
            make.top.equalTo(self.identityView.mas_bottom).offset(12);
        }];
        
        [self.proofOfIdentityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(self.headView);
            make.height.equalTo(@444);
            make.top.equalTo(self.photoLab.mas_bottom).offset(12);
        }];
        
        [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self).offset(-24);
            make.centerX.equalTo(self);
            make.top.equalTo(self.proofOfIdentityView.mas_bottom).offset(15);
        }];
        
        [self bindAction];
    }
    return self;
}

- (void)bindAction {
    AL_WeakSelf(self);
    self.headView.clickBlock = ^{
        [ALAlertViewController showAlertOnlyCancelButton:AL_MyAppDelegate.window.rootViewController title:nil message:nil style:UIAlertControllerStyleActionSheet alertArray:@[@"从相册选择",@"拍照"] clickBlock:^(int index) {
            [ALImagePickerController ImagePickerWithDelegate:AL_MyAppDelegate.window.rootViewController SourceType:index == 0 ? UIImagePickerControllerSourceTypePhotoLibrary : UIImagePickerControllerSourceTypeCamera Edit:NO choseImageBlcok:^(UIImage *image, NSDictionary *info) {
                weakSelf.headView.leftImage = image;
                
            } cannelBlock:nil];
        }];
    };
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentSize = CGSizeMake(0, CGRectGetMaxY(self.nextBtn.frame) + 10);
}

- (NSArray *)identiftyInfoArray {
    return @[
             self.headView.leftImage ? self.headView.leftImage : @"",
             self.identityView.vName,
             self.identityView.vCode,
             self.proofOfIdentityView.zhengmianImage ? self.proofOfIdentityView.zhengmianImage : @"",
             self.proofOfIdentityView.fanmianImage ? self.proofOfIdentityView.fanmianImage : @"",
             self.proofOfIdentityView.shouchiImage ? self.proofOfIdentityView.shouchiImage : @""
             ];
}

#pragma mark lazy load
- (ALLabel *)headInfoLab {
    if(!_headInfoLab) {
        _headInfoLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _headInfoLab.text = @"头像信息";
        _headInfoLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
        [self addSubview:_headInfoLab];
    }
    return _headInfoLab;
}

- (ALShadowView *)headView {
    if(!_headView) {
        _headView = [[ALShadowView alloc] initWithHeadView:CGRectZero];
        [self addSubview:_headView];
    }
    return _headView;
}

- (ALLabel *)identityInfoLab {
    if(!_identityInfoLab) {
        _identityInfoLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _identityInfoLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
        [self addSubview:_identityInfoLab];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"身份信息（审核通过后不能修改）"];
        [attributedString yy_setColor:[UIColor colorWithRGBA:ALLabelTextColor] range:NSMakeRange(0, 4)];
        [attributedString yy_setColor:[UIColor colorWithRGB:0xF55254] range:NSMakeRange(4, attributedString.length - 4)];
        [attributedString yy_setFont:ALThemeFont(14) range:NSMakeRange(4, attributedString.length - 4)];
        _identityInfoLab.attributedText = attributedString;
    }
    return _identityInfoLab;
}

- (ALShadowView *)identityView {
    if(!_identityView) {
        _identityView = [[ALShadowView alloc] initWithAccount:CGRectZero titleArray:@[@"真实姓名",@"身份证号"] placeholderArray:@[@"请输入身份证上的姓名",@"请输入身份证上的号码"]];
        [self addSubview:_identityView];
    }
    return _identityView;
}

- (ALLabel *)photoLab {
    if(!_photoLab) {
        _photoLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _photoLab.textColor = [UIColor colorWithRGBA:ALLabelTextColor];
        [self addSubview:_photoLab];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"身份证照片（请保证身份信息清晰，否则无法通过审核）"];
        [attributedString yy_setColor:[UIColor colorWithRGBA:ALLabelTextColor] range:NSMakeRange(0, 5)];
        [attributedString yy_setColor:[UIColor colorWithRGB:0xF55254] range:NSMakeRange(5, attributedString.length - 5)];
        [attributedString yy_setFont:ALThemeFont(12) range:NSMakeRange(5, attributedString.length - 5)];
        
        _photoLab.attributedText = attributedString;
    }
    return _photoLab;
}

- (ALProofOfIdentityVIew *)proofOfIdentityView {
    if(!_proofOfIdentityView) {
        _proofOfIdentityView = [[ALProofOfIdentityVIew alloc] initWithFrame:CGRectZero];
        [self addSubview:_proofOfIdentityView];
    }
    return _proofOfIdentityView;
}

- (ALActionButton *)nextBtn {
    if(!_nextBtn) {
        _nextBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _nextBtn.enabled = YES;
        [self addSubview:_nextBtn];
        
        AL_WeakSelf(self);
        [_nextBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if(weakSelf.nextStepAction) {
                weakSelf.nextStepAction();
            }
        }];
    }
    return _nextBtn;
}
@end

//
//  ALFeedBackViewController.m
//  bbxUser
//
//  Created by along on 2017/8/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALFeedBackViewController.h"
#import "ALFeedBackPhotoView.h"
#import "ALFeedBackApi.h"
#import "ALMultiImageUploadApi.h"

@interface ALFeedBackViewController ()
@property (nonatomic, strong) ALShadowView *textView;
@property (nonatomic, strong) ALShadowView *textFiledView;
@property (nonatomic, strong) ALFeedBackPhotoView *feedBackPhotoView;
@property (nonatomic, strong) ALActionButton *submitBtn;
@property (nonatomic, strong) ALMultiImageUploadApi *multiImageUploadApi;
@end

@implementation ALFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    
    [self initSubviews];
    
    [self bindAction];
}

- (void)initSubviews {
    self.navigationItem.rightBarButtonItem = [self createButtonItemWithImageName:@"icon_kefu" selector:@selector(kehuAction)];
    
    UILabel *questionLab = [[UILabel alloc] init];
    questionLab.text = @"问题和建议";
    questionLab.font = ALMediumTitleFont(12);
    questionLab.textColor = [UIColor colorWithRGB:0x666666];
    [self.view addSubview:questionLab];
    
    [questionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@27);
        make.top.equalTo(@76);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(questionLab.mas_bottom).offset(10);
        make.right.equalTo(@-14);
        make.height.equalTo(@97);
    }];
    
    UILabel *contactLab = [[UILabel alloc] init];
    contactLab.text = @"联系方式（选填）";
    contactLab.font = ALMediumTitleFont(12);
    contactLab.textColor = [UIColor colorWithRGB:0x666666];
    [self.view addSubview:contactLab];
    
    [contactLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(10);
        make.left.equalTo(questionLab);
    }];
    
    [self.textFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.textView);
        make.height.equalTo(@45);
        make.top.equalTo(contactLab.mas_bottom).offset(8);
    }];
    
    UILabel *photoLab = [[UILabel alloc] init];
    photoLab.text = @"图片（选填）";
    photoLab.font = ALMediumTitleFont(12);
    photoLab.textColor = [UIColor colorWithRGB:0x666666];
    [self.view addSubview:photoLab];
    
    [photoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFiledView.mas_bottom).offset(15);
        make.left.equalTo(questionLab);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.bottom.equalTo(@-20);
    }];
    
    [self.feedBackPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoLab.mas_bottom).offset(8);
        make.left.right.equalTo(self.textFiledView);
        make.bottom.equalTo(self.submitBtn.mas_top).offset(-20);
    }];
}

- (void)kehuAction {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4001066964"]];
    });
}

- (void)bindAction {
    AL_WeakSelf(self);
    [self.textView addObserverBlockForKeyPath:@"submitEnable" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
        NSString *val = ALStringFormat(@"%@", newVal);
        weakSelf.submitBtn.enabled = val.boolValue;
    }];
    
    [self.submitBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if(weakSelf.feedBackPhotoView.dataArray.count > 1) {
            NSArray *uploadArray = [weakSelf.feedBackPhotoView.dataArray subarrayWithRange:NSMakeRange(0, weakSelf.feedBackPhotoView.dataArray.count - 1)];

            weakSelf.multiImageUploadApi = [[ALMultiImageUploadApi alloc] initWithMultiImageUploadStart:uploadArray Success:^(NSString *filePathString) {
                ALFeedBackApi *feedBackApi = [[ALFeedBackApi alloc] initWithFeedBackApi:weakSelf.textView.textString contactWay:weakSelf.textFiledView.textString picUrls:filePathString];
                
                [feedBackApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    [ALKeyWindow hideHudInWindow];
                    [ALKeyWindow showHudSuccess:@"提交成功～"];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                    [ALKeyWindow hideHudInWindow];
                    [ALKeyWindow showHudError:@"提交失败～"];
                }];
            } failure:^{
                [ALKeyWindow hideHudInWindow];
                [ALKeyWindow showHudError:@"提交失败～"];
            }];
        }
    }];
}

#pragma mark lazy load
- (ALShadowView *)textView {
    if(!_textView) {
        _textView = [[ALShadowView alloc] initWithTextView:CGRectZero placeholder:@"请描述您的建议或遇到的问题~~" type:ALShadowStyleTextView];
        [self.view addSubview:_textView];
    }
    return _textView;
}

- (ALShadowView *)textFiledView {
    if(!_textFiledView) {
        _textFiledView = [[ALShadowView alloc] initWithFrame:CGRectZero placeholder:@"请留下您的QQ/微信/手机号，方便联系到您。" type:ALShadowStyleTextFiled];
        [self.view addSubview:_textFiledView];
    }
    return _textFiledView;
}

- (ALFeedBackPhotoView *)feedBackPhotoView {
    if(!_feedBackPhotoView) {
        _feedBackPhotoView = [[ALFeedBackPhotoView alloc] init];
        _feedBackPhotoView.delegate = self;
        [self.view addSubview:_feedBackPhotoView];
    }
    return _feedBackPhotoView;
}

- (ALActionButton *)submitBtn {
    if(!_submitBtn) {
        _submitBtn = [ALActionButton buttonWithType:UIButtonTypeCustom arc:NO];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"btn-Sign out pressed"] forState:UIControlStateDisabled];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = 5;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.enabled = NO;
        [self.view addSubview:_submitBtn];
    }
    return _submitBtn;
}

- (void)dealloc {
    self.feedBackPhotoView.delegate = nil;
}
@end

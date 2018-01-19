//
//  ALSecurityInfoViewController.m
//  bbxUser
//
//  Created by along on 2017/8/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSecurityInfoViewController.h"
#import "ALSecurityView.h"
#import "ALCommentDisplayView.h"
#import "ALGoodBusinessView.h"
#import "ALEvaluateListViewController.h"
#import "ALSecurityInfoApi.h"
#import "ALEvaluateListViewController.h"

@interface ALSecurityInfoViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ALSecurityView *securityView;
@property (nonatomic, strong) ALShadowView *sexAgeView;
@property (nonatomic, strong) ALShadowView *addressView;
@property (nonatomic, strong) ALCommentDisplayView *commentDisplayView;
@property (nonatomic, strong) ALGoodBusinessView *goodBusinessView;
@property (nonatomic, strong) ALSecurityInfoApi *securityInfoApi;
@end

@implementation ALSecurityInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.title = @"镖师详情";
}

- (void)viewDidAppear:(BOOL)animated {
    [self loadData];
}

- (void)loadData {
    _securityInfoApi = [[ALSecurityInfoApi alloc] initWithSecurityInfoApi:_securityId];
    AL_WeakSelf(self);
    [_securityInfoApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf initSubviews];
        [weakSelf bindAction];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

    }];
    
    _securityInfoApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _securityInfoApi.dataErrorBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusDataError];
    };
}

- (void)reloadData {
    [self loadData];
}

- (void)initSubviews {
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.securityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@-64);
        make.centerX.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.equalTo(@269);
    }];
    
    [self.sexAgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@91);
        make.centerX.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView).offset(-28);
        make.centerY.equalTo(self.securityView.mas_bottom);
    }];

    
//    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.scrollView);
//        make.width.equalTo(self.sexAgeView);
//        make.top.equalTo(self.sexAgeView.mas_bottom).offset(10);
//        make.height.equalTo(@41);
//    }];
    
    CGFloat lastViewMaxY = 0;
    
    if([self.securityInfoApi.securityInfoModel.commentList isVaild]) {
        [self.commentDisplayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_scrollView);
            make.width.equalTo(_sexAgeView);
            make.top.equalTo(_sexAgeView.mas_bottom).offset(10);
            if(self.securityInfoApi.securityInfoModel.commentList.count == 1) {
                make.height.equalTo(@131);
            } else {
                make.height.equalTo(@226);
            }
        }];
        [self.view layoutIfNeeded];

        lastViewMaxY = CGRectGetMaxY(_commentDisplayView.frame);
    } else {
        [self.view layoutIfNeeded];

        lastViewMaxY = CGRectGetMaxY(_sexAgeView.frame);
    }
    
    if([self.securityInfoApi.securityInfoModel.tag isVaild]) {
        _goodBusinessView = [[ALGoodBusinessView alloc] initWithFrame:CGRectMake(14, lastViewMaxY + 10, CGRectGetWidth(_sexAgeView.frame), 184) tag:self.securityInfoApi.securityInfoModel.tag];
        [_scrollView addSubview:_goodBusinessView];
        
        _goodBusinessView.frame = CGRectMake(14, lastViewMaxY + 10, CGRectGetWidth(_sexAgeView.frame), _goodBusinessView.customTagView.frame.size.height + 47);
        
        lastViewMaxY = CGRectGetMaxY(_goodBusinessView.frame);
    }
    
    _scrollView.contentSize = CGSizeMake(0, lastViewMaxY + 10);
}

- (void)bindAction {
    AL_WeakSelf(self);
    _commentDisplayView.clickBlock = ^{

    };
    
    _commentDisplayView.moreCommentClick = ^{
        ALEvaluateListViewController *evaluateListVC = [[ALEvaluateListViewController alloc] init];
        evaluateListVC.securityId = weakSelf.securityId;
        [weakSelf.navigationController pushViewController:evaluateListVC animated:YES];
    };
}

#pragma mark lazy load
- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor colorWithRGBA:ALVCbgColor];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (ALSecurityView *)securityView {
    if(!_securityView) {
        _securityView = [[ALSecurityView alloc] initWithFrame:CGRectZero model:self.securityInfoApi.securityInfoModel];
        [self.scrollView addSubview:_securityView];
    }
    return _securityView;
}

- (ALShadowView *)sexAgeView {
    if(!_sexAgeView) {
        _sexAgeView = [[ALShadowView alloc] initWithFrame:CGRectZero titleArray:@[@"性别",@"年龄"] contentArray:@[
                                                                                                              [self.securityInfoApi.securityInfoModel.sex integerValue] == 1 ? @"男" : @"女",
                                                                                                              ALStringFormat(@"%@岁",self.securityInfoApi.securityInfoModel.age)
                                                                                                              ] rightView:NO];
        [self.scrollView addSubview:_sexAgeView];
    }
    return _sexAgeView;
}

//- (ALShadowView *)addressView {
//    if(!_addressView) {
//        _addressView = [[ALShadowView alloc] initWithFrame:CGRectZero titleArray:@[@"家乡"] contentArray:@[
//                                                                                                                              self.securityInfoApi.securityInfoModel.hometown,
//                                                                                                                              ] rightView:NO];
//        [self.scrollView addSubview:_addressView];
//    }
//    return _addressView;
//}

- (ALCommentDisplayView *)commentDisplayView {
    if(!_commentDisplayView) {
        _commentDisplayView = [[ALCommentDisplayView alloc] initWithFrame:CGRectZero model:self.securityInfoApi.securityInfoModel];
        [self.scrollView addSubview:_commentDisplayView];
    }
    return _commentDisplayView;
}

- (ALGoodBusinessView *)goodBusinessView {
    if(!_goodBusinessView) {
        _goodBusinessView = [[ALGoodBusinessView alloc] init];
        [self.scrollView addSubview:_goodBusinessView];
    }
    return _goodBusinessView;
}

- (void)dealloc {
    [_securityInfoApi stop];
}
@end

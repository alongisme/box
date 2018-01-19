//
//  ALEvaluateViewController.m
//  bbxUser
//
//  Created by along on 2017/8/8.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALEvaluateViewController.h"
#import "ALEvaluateView.h"
#import "ALCommentTagApi.h"
#import "ALSubmitOrderCommentApi.h"
#import "ALOrderViewController.h"

@interface ALEvaluateViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *evaluateBtn;
@property (nonatomic, strong) ALCommentTagApi *commentTagApi;
@property (nonatomic, strong) ALSubmitOrderCommentApi *submitOrderCommentApi;
@property (nonatomic, strong) NSMutableArray *evaluateArray;
@end

@implementation ALEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    _evaluateArray = [NSMutableArray array];
    
    [self loadTitleData];
}

- (void)loadTitleData {
    _commentTagApi = [[ALCommentTagApi alloc] initWithCommentTagApi];
    
    AL_WeakSelf(self);
    [_commentTagApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf initSubviews];
        [weakSelf removeRequestStatusView];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [ALKeyWindow showHudError:@"获取评价失败～"];
    }];
    
    _commentTagApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _commentTagApi.dataErrorBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusDataError];
    };
}

- (void)reloadData {
    [self loadTitleData];
}

- (void)initSubviews {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self.view);
        make.top.equalTo(@0);
        make.height.mas_equalTo(ALScreenHeight - 64);
    }];
    
    [self.view layoutIfNeeded];
    
    NSArray *arr = self.orderModel.securityList;
    
    ALEvaluateView *lastView = nil;
    
    for (unsigned int i = 0; i < arr.count; i++) {
        ALEvaluateView *evaluateView = [[ALEvaluateView alloc] initWithFrame:CGRectMake(14, i * 378 + 10 * (i + 1), ALScreenWidth - 28, 378) securityModel:arr[i] titleDataArray:self.commentTagApi.commentTagList index:i];
        [_evaluateArray addObject:evaluateView];
        [self.scrollView addSubview:evaluateView];
        lastView = evaluateView;
    }
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(lastView.frame) + 75);
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
        make.height.equalTo(@70);
    }];
    
    [bottomView addSubview:self.evaluateBtn];
    
    [self.evaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.centerY.equalTo(bottomView);
    }];
}

//评论内容转json
- (NSString *)submitOrderCommentReturnJsonString {
    NSMutableDictionary *commentListDic = [NSMutableDictionary dictionary];
    NSMutableArray *listArray = [NSMutableArray array];
    
    for (unsigned int i = 0; i < self.evaluateArray.count; i++) {
        ALEvaluateView *evaluateView = self.evaluateArray[i];
        ALSecurityModel *model = self.orderModel.securityList[i];
        NSMutableDictionary *evaluteDic = [NSMutableDictionary dictionary];
        [evaluteDic setObject:model.securityId forKey:@"securityId"];
        [evaluteDic setObject:evaluateView.textView.text forKey:@"comment"];
        [evaluteDic setObject:@(evaluateView.score) forKey:@"rank"];
        [evaluteDic setObject:evaluateView.tagString forKey:@"commentTag"];
        [listArray addObject:evaluteDic];
        
        if(evaluateView.score == 0) {
            [ALKeyWindow showHudError:@"请对各位镖镖侠进行星级评价哦～"];
            return nil;
        }
        
    }
    [commentListDic setObject:listArray forKey:@"commentList"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:commentListDic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *commentJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return commentJson;
}

#pragma mark Action
- (void)evaluateButtonAction {
    NSString *jsonString = [self submitOrderCommentReturnJsonString];
    if(jsonString) {
        _submitOrderCommentApi = [[ALSubmitOrderCommentApi alloc] initWithSubmitOrderCommentApi:self.orderModel.orderId commentJson:[self submitOrderCommentReturnJsonString]];
        AL_WeakSelf(self);
        [_submitOrderCommentApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [MobClick event:ALMobEventID_F2];
            [weakSelf.navigationController popViewControllerAnimated:YES];
//            for (unsigned int i = 0; i < weakSelf.navigationController.viewControllers.count; i++) {
//                if([weakSelf.navigationController.viewControllers[i] isKindOfClass:[ALOrderViewController class]]) {
//                    [weakSelf.navigationController popToViewController:weakSelf.navigationController.viewControllers[i] animated:YES];
//                }
//            }
            
            if([weakSelf.delegate respondsToSelector:@selector(EvaluateFinished)]) {
                [weakSelf.delegate EvaluateFinished];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:ChangeListIndexStatus object:@{@"commond" : @"orderToPayEvaSuccess",@"index":@(weakSelf.indexPath)}];
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [ALKeyWindow showHudError:@"评价失败～"];
        }];
    }
}

#pragma mark lazy load
- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIButton *)evaluateBtn {
    if(!_evaluateBtn) {
        _evaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_evaluateBtn setBackgroundImage:[UIImage imageNamed:@"btn-pingjia"] forState:UIControlStateNormal];
        [_evaluateBtn addTarget:self action:@selector(evaluateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaluateBtn;
}

- (void)dealloc {
    [_submitOrderCommentApi stop];
    [_commentTagApi stop];
}
@end

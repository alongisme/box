//
//  ALNoReusltTableView.m
//  bbxUser
//
//  Created by along on 2017/8/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALNoReusltTableView.h"
#import "ALNoResultView.h"
#import "ALOrderListTableViewCell.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface ALNoReusltTableView () <UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) ALNoResultView *noResultView;
@end

@implementation ALNoReusltTableView

- (instancetype)init {
    if(self = [super init]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {

}

- (void)setHeadRefreshBlock:(MJRefreshComponentRefreshingBlock)headRefreshBlock {
    _headRefreshBlock = headRefreshBlock;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:headRefreshBlock];
}

- (void)setFootRefreshBlock:(MJRefreshComponentRefreshingBlock)footRefreshBlock {
    _footRefreshBlock = footRefreshBlock;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:footRefreshBlock];
    [footer setTitle:@"没有更多订单了～" forState:MJRefreshStateNoMoreData];
    footer.ignoredScrollViewContentInsetBottom = -50;
    footer.stateLabel.font = ALThemeFont(14);
    footer.stateLabel.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
    self.tableView.mj_footer = footer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.noResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (void)setIsNoResult:(BOOL)isNoResult {
    _isNoResult = isNoResult;
    
    self.noResultView.hidden = !isNoResult;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 145;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}

#pragma mark  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noresutlIdentifier"];
    if(cell == nil) {
        cell = [[ALOrderListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"noresutlIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell bindModel:self.dataArray[indexPath.row]];
    
    AL_WeakSelf(self);
    cell.actionBlock = ^(NSUInteger index) {
        if([weakSelf.delegate respondsToSelector:@selector(didActionButtonSelectedAtIndexPath:model:type:)]) {
            [weakSelf.delegate didActionButtonSelectedAtIndexPath:indexPath.row model:self.dataArray[indexPath.row] type:index];
        }
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(didSelectedAtIndexPath:model:)]) {
        [self.delegate didSelectedAtIndexPath:indexPath.row model:self.dataArray[indexPath.row]];
    }
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if(AL_MyAppDelegate.netWorkstatus == -1 || AL_MyAppDelegate.netWorkstatus == 0) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"网络异常请稍后再试～"];
        [attString setYy_font:ALThemeFont(13)];
        return attString;
    }
    return [[NSMutableAttributedString alloc] init];
}

//#pragma mark - DZNEmptyDataSetDelegate
//
//- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
//    return self.dataArray == nil || self.dataArray.count == 0;
//}
//
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
//    if([self.delegate respondsToSelector:@selector(emptyDataAndReloadDataSource)]) {
//        [self.delegate emptyDataAndReloadDataSource];
//    }
//}
//
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
//    if(AL_MyAppDelegate.netWorkstatus == -1 || AL_MyAppDelegate.netWorkstatus == 0) {
//        return [UIImage imageNamed:@"meiyouwangluo"];
//    }
//    if(self.dataArray == nil || self.dataArray.count == 0) {
//        return [UIImage imageNamed:@"meiyoudingdan"];
//    }
//    return nil;
//}
//
//- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    if(AL_MyAppDelegate.netWorkstatus == -1 || AL_MyAppDelegate.netWorkstatus == 0) {
//        return [UIImage imageNamed:@"btn-jiazai"];
//    }
//    return nil;
//}
//
//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
//    return 25;
//}
//
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
//    return -40;
//}

#pragma mark lazy load
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithRGB:0xF5F6FA];
        _tableView.tableFooterView = [[UIView alloc] init];
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (ALNoResultView *)noResultView {
    if(!_noResultView) {
        _noResultView = [[ALNoResultView alloc] initWithFrame:CGRectZero style:1];
        _noResultView.backgroundColor = [UIColor colorWithRGBA:ALVCbgColor];
        _noResultView.hidden = YES;
        [self addSubview:_noResultView];
    }
    return _noResultView;
}

#pragma mark dealloc
- (void)dealloc {
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    _tableView.emptyDataSetDelegate = nil;
    _tableView.emptyDataSetSource = nil;
}
@end

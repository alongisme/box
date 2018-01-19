//
//  ALBalanceRecordViewController.m
//  bbxServer
//
//  Created by along on 2017/9/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBalanceRecordViewController.h"
#import "ALBalanceRecordTableViewCell.h"
#import "ALMyProfitListApi.h"

@interface ALBalanceRecordViewController ()
@property (nonatomic, assign) NSUInteger pageIndex;
@property (nonatomic, strong) ALMyProfitListApi *myProfitListApi;
@end

@implementation ALBalanceRecordViewController

- (void)viewDidLoad {
    self.title = @"余额记录";
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.tableStyle = ALTableStyleMoney;
    self.emptyDataTitle = @"您还没有余额记录哦～";
    self.shouldPullToRefresh = YES;
    self.shouldPullDownLoadMore = YES;
    [self addRefresh];
    self.myTableView.separatorColor = [UIColor colorWithRGB:0xF5F6FA];
    [self.myTableView registerClass:[ALBalanceRecordTableViewCell class] forCellReuseIdentifier:@"ALBalanceRecordIdentifier"];
    [self loadDataSource];
}

- (void)loadDataSource {
    _pageIndex = 1;
    AL_WeakSelf(self);
    _myProfitListApi = [[ALMyProfitListApi alloc] initMyProfitListApi:@"1"];
    [_myProfitListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        weakSelf.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        ALProfitModel *model = weakSelf.myProfitListApi.profitModel;
        weakSelf.dataSource = @[model.profitList];
        [weakSelf reload];
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        if([model.hasNextPage integerValue] == 0) {
            [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf removeRequestStatusView];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.myTableView.mj_header endRefreshing];
    }];
    
    _myProfitListApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _myProfitListApi.dataErrorBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusDataError];
    };
}

- (void)loadMoreDataSource {
    _pageIndex++;
    AL_WeakSelf(self);
    _myProfitListApi = [[ALMyProfitListApi alloc] initMyProfitListApi:ALStringFormat(@"%lu",(unsigned long)_pageIndex)];
    [_myProfitListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSMutableArray *currentArr = [[weakSelf.dataSource firstObject] mutableCopy];
        ALProfitModel *model = weakSelf.myProfitListApi.profitModel;
        [currentArr addObjectsFromArray:model.profitList];
        weakSelf.dataSource = @[currentArr];
        [weakSelf reload];
        if([model.hasNextPage integerValue] == 1) {
            [weakSelf.myTableView.mj_footer endRefreshing];
        } else {
            [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.myTableView.mj_footer endRefreshing];
        weakSelf.pageIndex--;
    }];
}

- (void)reloadData {
    [self loadDataSource];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 77;
}

#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    ALBalanceRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALBalanceRecordIdentifier" forIndexPath:indexPath];
    return cell;
}
@end

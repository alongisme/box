//
//  ALMyMessageViewController.m
//  bbxUser
//
//  Created by along on 2017/8/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMyMessageViewController.h"
#import "ALMyMessageTableViewCell.h"
#import "ALMyMessageListApi.h"
#import "ALNewsDetailViewController.h"

@interface ALMyMessageViewController ()
@property (nonatomic, assign) NSUInteger pageIndex;
@property (nonatomic, strong) ALMyMessageListApi *myMessageListApi;
@end

@implementation ALMyMessageViewController

- (void)viewDidLoad {
    self.title = @"我的消息";
    
    _pageIndex = 1;
    
    self.emptyDataTitle = @"您还没有消息喔～";
    self.tableStyle = ALTableStyleMyMessage;
    self.shouldPullToRefresh = YES;
    self.shouldPullDownLoadMore = YES;
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.myTableView.separatorColor = [UIColor colorWithRGB:0xF5F6FA];
    [self.myTableView registerClass:[ALMyMessageTableViewCell class] forCellReuseIdentifier:@"ALMyMessageTableViewIdentifier"];
    
    
    [self loadDataSource];
}

- (void)loadDataSource {
    _pageIndex = 1;
    AL_WeakSelf(self);
    _myMessageListApi = [[ALMyMessageListApi alloc] initWithMyMessageListApi:@"1"];
    [_myMessageListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        ALMyMessageModel *model = weakSelf.myMessageListApi.myMessageModel;
        weakSelf.dataSource = @[model.noticeList];
        [weakSelf reload];
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        if([model.hasNextPage integerValue] == 0) {
            [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf removeRequestStatusView];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [ALKeyWindow showHudError:@"获取数据失败～"];
    }];
    
    _myMessageListApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _myMessageListApi.dataErrorBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusDataError];
    };
}

- (void)reloadData {
    [self loadDataSource];
}

- (void)loadMoreDataSource {
    _pageIndex++;
    AL_WeakSelf(self);
    _myMessageListApi = [[ALMyMessageListApi alloc] initWithMyMessageListApi:ALStringFormat(@"%lu",(unsigned long)_pageIndex)];
    [_myMessageListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSMutableArray *currentArr = [[weakSelf.dataSource firstObject] mutableCopy];
        ALMyMessageModel *model = weakSelf.myMessageListApi.myMessageModel;
        [currentArr addObjectsFromArray:model.noticeList];
        weakSelf.dataSource = @[currentArr];
        [weakSelf reload];
        if([model.hasNextPage integerValue] == 1) {
            [weakSelf.myTableView.mj_footer endRefreshing];
        } else {
            [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.myTableView.mj_footer endRefreshing];
        [ALKeyWindow showHudError:@"获取数据失败～"];
    }];
}

#pragma mark emptyDataSet
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self loadDataSource];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    ALMyMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALMyMessageTableViewIdentifier" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ALNoticeModel *model = [self.dataSource firstObject][indexPath.row];
    if([model.isNews isEqualToString:@"1"]) {
        ALNewsDetailViewController *newsDetailVC = [[ALNewsDetailViewController alloc] init];
        newsDetailVC.newsId = model.newsId;
        [self.navigationController pushViewController:newsDetailVC animated:YES];
    }
}

- (void)dealloc {
    [_myMessageListApi stop];
}
@end

//
//  ALOrderListViewController.m
//  bbxServer
//
//  Created by along on 2017/8/29.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALOrderListViewController.h"
#import "ALMyOrderListApi.h"
#import "ALOrderListTableViewCell.h"
#import "ALOrderDetailViewController.h"

@interface ALOrderListViewController ()
@property (nonatomic, strong) ALMyOrderListApi *myOrderListApi;

@property (nonatomic, assign) NSUInteger nowPage;
@end

@implementation ALOrderListViewController

- (void)viewDidLoad {
    self.title = @"我的订单";
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    _nowPage = 1;
    self.tableStyle = ALTableStyleOrder;
    self.emptyDataTitle = @"您还没有订单哦～";
    self.shouldPullToRefresh = YES;
    self.shouldPullDownLoadMore = YES;
    [self addRefresh];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myTableView registerClass:[ALOrderListTableViewCell class] forCellReuseIdentifier:@"OrderListViewCellIdentifier"];
    [self loadDataSource];
}

- (void)loadDataSource {
    _nowPage = 1;
    
    _myOrderListApi = [[ALMyOrderListApi alloc] initMyOrderListApi:ALStringFormat(@"%lu",_nowPage)];
    AL_WeakSelf(self);
    [_myOrderListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        weakSelf.dataSource = @[weakSelf.myOrderListApi.orderListModel.orderList];
        [weakSelf reload];
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        if([weakSelf.myOrderListApi.orderListModel.hasNextPage integerValue] == 0) {
            [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
        }

        [weakSelf removeRequestStatusView];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
    _myOrderListApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _myOrderListApi.dataErrorBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusDataError];
    };
}

- (void)reloadData {
    [self loadDataSource];
}

- (void)loadMoreDataSource {
    _nowPage++;
    
    _myOrderListApi = [[ALMyOrderListApi alloc] initMyOrderListApi:ALStringFormat(@"%lu",_nowPage)];
    AL_WeakSelf(self);
    [_myOrderListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ALOrderListModel *listModel = weakSelf.myOrderListApi.orderListModel;
        
        NSMutableArray *orderArr = [weakSelf.dataSource mutableCopy];
        [orderArr addObjectsFromArray:listModel.orderList];
        
        weakSelf.dataSource = orderArr;
        
        [weakSelf reload];
        [weakSelf.myTableView.mj_footer endRefreshing];
        
        if([listModel.hasNextPage integerValue] == 0) {
            [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}

#pragma mark emptyDataSet
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self loadDataSource];
}

#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    ALOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListViewCellIdentifier" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ALOrderModel *orderModel = self.dataSource[indexPath.section][indexPath.row];
    ALOrderDetailViewController *orderDetailVC = [[ALOrderDetailViewController alloc] init];
    orderDetailVC.orderId = orderModel.orderId;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

- (void)dealloc {
    [_myOrderListApi stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

//
//  ALOrderViewController.m
//  bbxUser
//
//  Created by along on 2017/8/8.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALOrderViewController.h"
#import "ALSegmentedView.h"
#import "ALOrderListTableViewCell.h"
#import "ALNoResultView.h"
#import "ALOrderInfoViewController.h"
#import "ALEvaluateViewController.h"
#import "ALMyUndoneOrderListApi.h"
#import "ALMyDoneOrderList.h"
#import "ALNoReusltTableView.h"

@interface ALOrderViewController () <ALNoResultTableViewDelegate>
@property (nonatomic, strong) ALSegmentedView *segmentedView;
@property (nonatomic, strong) ALNoReusltTableView *unfinishedTableView;
@property (nonatomic, strong) ALNoReusltTableView *finishedTableView;

@property (nonatomic, assign) NSUInteger unfinishedIndex;
@property (nonatomic, assign) NSUInteger finishedIndex;

@property (nonatomic, assign) BOOL isFirstLoad;

@property (nonatomic, strong) ALMyDoneOrderList *myDoneOrderListApi;
@property (nonatomic, strong) ALMyUndoneOrderListApi *myUndoneOrderListApi;
@end

@implementation ALOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    [self initSubviews];
    [self selectedIndex:0];
    [self bindAction];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeListIndexStatus:) name:ChangeListIndexStatus object:nil];
}

- (void)changeListIndexStatus:(NSNotification *)notification {
    NSDictionary *objectDic = notification.object;
    NSUInteger index = [objectDic[@"index"] integerValue];
    NSString *commond = objectDic[@"commond"];
    
    if([commond isEqualToString:@"orderToPayEvaSuccess"]) {
        ALOrderModel *model = self.finishedTableView.dataArray[index];
        model.isCommented = @"1";
        [self.finishedTableView.tableView reloadData];
    } else if([commond isEqualToString:@"secondPaySuccess"]) {
        ALOrderModel *model = self.unfinishedTableView.dataArray[index];
        model.orderStatus = OrderStatusFinished;
        model.orderStatus = @"已完成";
        [self.finishedTableView.dataArray insertObject:model atIndex:0];
        [self.finishedTableView.tableView reloadData];
        
        [self.unfinishedTableView.dataArray removeObjectAtIndex:index];
        [self.unfinishedTableView.tableView reloadData];
        
        [self selectedIndex:1];
        
    } else {
        ALOrderModel *model = self.unfinishedTableView.dataArray[index];
        if([commond isEqualToString:@"orderToCancel"]) {
            model.orderStatus = OrderStatusCancel;
            model.orderStatus = @"已取消";
        } else if([commond isEqualToString:@"orderToPaySuccess"]) {
            model.orderStatus = OrderStautsAllocating;
            model.orderStatusDes = @"派单中";
        } else if([commond isEqualToString:@"orderToPayTimeOut"]) {
            model.orderStatus = OrderStatusTimeOut;
            model.orderStatusDes = @"交易关闭";
        }
        [self.unfinishedTableView.tableView reloadData];
    }
}

- (void)initSubviews {
    [self.segmentedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ALNavigationBarHeight);
        make.centerX.width.equalTo(self.view);
        make.height.equalTo(@36);
    }];
    
    [self.unfinishedTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(self.view);
        make.top.equalTo(self.segmentedView.mas_bottom);
        make.bottom.equalTo(@0);
    }];
    
    [self.finishedTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(self.view);
        make.top.equalTo(self.segmentedView.mas_bottom);
        make.bottom.equalTo(@0);
    }];
    
}

- (void)loadData:(BOOL)isRefresh {
    AL_WeakSelf(self);
    
    if(isRefresh) {
        if(self.unfinishedTableView.isHidden) {
            self.finishedTableView.dataArray = nil;
        } else {
            self.unfinishedTableView.dataArray = nil;
        }
    }
    
    if(self.unfinishedTableView.isHidden && ![self.finishedTableView.dataArray isVaild]) {
        
        if(isRefresh) [self.finishedTableView.tableView.mj_header beginRefreshing];
        
        _finishedIndex = 1;
        _myDoneOrderListApi = [[ALMyDoneOrderList alloc] initWithDoneOrderListApi:@"1"];
        
        [_myDoneOrderListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            ALOrderListModel *listModel = weakSelf.myDoneOrderListApi.orderListModel;
            if(![listModel.orderList isVaild]) {
                weakSelf.finishedTableView.isNoResult = YES;
            } else {
                weakSelf.finishedTableView.dataArray = [listModel.orderList mutableCopy];
                weakSelf.finishedTableView.isNoResult = NO;
            }
            [weakSelf.finishedTableView.tableView reloadData];
            if(isRefresh) [weakSelf.finishedTableView.tableView.mj_header endRefreshing];
            
            if([listModel.hasNextPage integerValue] == 0) {
                [weakSelf.finishedTableView.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [weakSelf removeRequestStatusView];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [ALKeyWindow showHudError:@"订单获取失败～"];
            if(isRefresh) [weakSelf.finishedTableView.tableView.mj_header endRefreshing];
        }];
    } else if(self.finishedTableView.isHidden && ![self.unfinishedTableView.dataArray isVaild]){
        
        if(isRefresh) [self.unfinishedTableView.tableView.mj_header beginRefreshing];
        
        _unfinishedIndex = 1;
        _myUndoneOrderListApi = [[ALMyUndoneOrderListApi alloc] initWithUndoneOrderListApi:@"1"];
        
        [_myUndoneOrderListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            ALOrderListModel *listModel = weakSelf.myUndoneOrderListApi.orderListModel;
            
            if(![listModel.orderList isVaild]) {
                weakSelf.unfinishedTableView.isNoResult = YES;
            } else {
                weakSelf.unfinishedTableView.dataArray = [listModel.orderList mutableCopy];
                weakSelf.unfinishedTableView.isNoResult = NO;
            }
            
            [weakSelf.unfinishedTableView.tableView reloadData];
            if(isRefresh) [weakSelf.unfinishedTableView.tableView.mj_header endRefreshing];

            if([listModel.hasNextPage integerValue] == 0) {
                [weakSelf.unfinishedTableView.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [weakSelf removeRequestStatusView];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [ALKeyWindow showHudError:@"订单获取失败～"];
            if(isRefresh) [weakSelf.unfinishedTableView.tableView.mj_header endRefreshing];
        }];
    }
    _myDoneOrderListApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _myDoneOrderListApi.dataErrorBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusDataError];
    };
    
    _myUndoneOrderListApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _myUndoneOrderListApi.dataErrorBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusDataError];
    };
}

- (void)reloadData {
    [self loadData:NO];
}

- (void)loadMoreData {
    
    AL_WeakSelf(self);
    
    if(self.unfinishedTableView.isHidden) {
        [self.finishedTableView.tableView.mj_footer beginRefreshing];
        
        _unfinishedIndex++;
        _myDoneOrderListApi = [[ALMyDoneOrderList alloc] initWithDoneOrderListApi:ALStringFormat(@"%lu",(unsigned long)_unfinishedIndex)];
        
        [_myDoneOrderListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            ALOrderListModel *listModel = weakSelf.myDoneOrderListApi.orderListModel;
            
            NSMutableArray *orderArr = [weakSelf.finishedTableView.dataArray mutableCopy];
            [orderArr addObjectsFromArray:listModel.orderList];
            
            weakSelf.finishedTableView.dataArray = orderArr;
            
            [weakSelf.finishedTableView.tableView reloadData];
            [weakSelf.finishedTableView.tableView.mj_footer endRefreshing];
            
            if([listModel.hasNextPage isEqualToString:@"0"]) {
                [weakSelf.finishedTableView.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [ALKeyWindow showHudError:@"订单获取失败～"];
            [weakSelf.finishedTableView.tableView.mj_header endRefreshing];
        }];
    } else {
        
        [self.unfinishedTableView.tableView.mj_footer beginRefreshing];
        
        _unfinishedIndex++;
        _myUndoneOrderListApi = [[ALMyUndoneOrderListApi alloc] initWithUndoneOrderListApi:ALStringFormat(@"%lu",(unsigned long)_unfinishedIndex)];
        
        [_myUndoneOrderListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            ALOrderListModel *listModel = weakSelf.myUndoneOrderListApi.orderListModel;
            
            NSMutableArray *orderArr = [weakSelf.unfinishedTableView.dataArray mutableCopy];
            [orderArr addObjectsFromArray:listModel.orderList];
            
            weakSelf.unfinishedTableView.dataArray = orderArr;
            
            [weakSelf.unfinishedTableView.tableView reloadData];
             [weakSelf.unfinishedTableView.tableView.mj_footer endRefreshing];
            
            if([listModel.hasNextPage isEqualToString:@"0"]) {
                [weakSelf.unfinishedTableView.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [ALKeyWindow showHudError:@"订单获取失败～"];
            [weakSelf.unfinishedTableView.tableView.mj_footer endRefreshing];
        }];
    }
}

- (void)bindAction {
    AL_WeakSelf(self);
    self.unfinishedTableView.headRefreshBlock = ^{
        [weakSelf loadData:YES];
    };
    
    self.finishedTableView.headRefreshBlock = ^{
        [weakSelf loadData:YES];
    };
    
    self.unfinishedTableView.footRefreshBlock = ^{
        [weakSelf loadMoreData];
    };
    
    self.finishedTableView.footRefreshBlock = ^{
        [weakSelf loadMoreData];
    };
    
    self.segmentedView.segemtedDidValueChanged = ^(NSUInteger index) {
        [weakSelf selectedIndex:index];
    };
}

//segemented selected
-(void)selectedIndex:(NSUInteger)index {
    if(index == 1) {
        self.finishedTableView.hidden = NO;
        self.unfinishedTableView.hidden = YES;
    } else {
        self.finishedTableView.hidden = YES;
        self.unfinishedTableView.hidden = NO;
    }
    [self loadData:NO];
}

#pragma mark ALNoResultTableViewDelegate
- (void)didActionButtonSelectedAtIndexPath:(NSUInteger)indexPath model:(ALOrderModel *)model type:(NSUInteger)type {
    //type 1 待支付  2 评价
    [self didSelectedAtIndexPath:indexPath model:model];
}

- (void)didSelectedAtIndexPath:(NSUInteger)indexPath model:(ALOrderModel *)model {
    ALOrderInfoViewController *orderInfoVC = [[ALOrderInfoViewController alloc] init];
    orderInfoVC.indexPath = indexPath;
    orderInfoVC.orderModel = model;
    [self.navigationController pushViewController:orderInfoVC animated:YES];
}

- (void)emptyDataAndReloadDataSource {
    [self loadData:NO];
}

#pragma mark lazy load
- (ALSegmentedView *)segmentedView {
    if(!_segmentedView) {
        _segmentedView = [[ALSegmentedView alloc] initWithFrame:CGRectZero style:ALSegmentedStyleOrderList];
        [self.view addSubview:_segmentedView];
    }
    return _segmentedView;
}

- (ALNoReusltTableView *)unfinishedTableView {
    if(!_unfinishedTableView) {
        _unfinishedTableView = [[ALNoReusltTableView alloc] init];
        _unfinishedTableView.delegate = self;
        [self.view addSubview:_unfinishedTableView];
    }
    return _unfinishedTableView;
}

- (ALNoReusltTableView *)finishedTableView {
    if(!_finishedTableView) {
        _finishedTableView = [[ALNoReusltTableView alloc] init];
        _finishedTableView.delegate = self;
        [self.view addSubview:_finishedTableView];
    }
    return _finishedTableView;
}

- (void)dealloc {
    [_myDoneOrderListApi stop];
    [_myUndoneOrderListApi stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

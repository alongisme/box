//
//  ALBaseTableViewController.m
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseTableViewController.h"

static NSString * const BaseTableViewCellIdentifier = @"BaseTableViewCellIdentifier";

@implementation ALBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.shouldPullToRefresh) {
        self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadDataSource];
        }];
    }
    
    if(self.shouldPullDownLoadMore) {
        self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self loadMoreDataSource];
        }];
    }
}

//加载数据
- (void)loadDataSource {}

//加载更多数据
- (void)loadMoreDataSource {}

- (void)reload {
    if(self.dataSource.count == 0) {
        self.myTableView.tableHeaderView.hidden = YES;
    } else {
        self.myTableView.tableHeaderView.hidden = NO;
    }
    [self.myTableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    [cell bindModel:object];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource ? self.dataSource.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id itemArray = self.dataSource[section];
    if(![itemArray isVaild]) return 0;
    NSParameterAssert([itemArray isKindOfClass:[NSArray class]]);
    return [(NSArray *)itemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:BaseTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    id object = self.dataSource[indexPath.section][indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section >= self.sectionIndexTitles.count) return nil;
    return self.sectionIndexTitles[section];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if(_emptyDataTitle && _emptyDataTitle.length > 0 && self.dataSource.count == 0) return [[NSAttributedString alloc] initWithString:_emptyDataTitle];
    
    if(AL_MyAppDelegate.netWorkstatus == -1 || AL_MyAppDelegate.netWorkstatus == 0) {
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return [[NSAttributedString alloc] initWithString:@"没网还想调戏窝？"];
    } else {
        return [[NSAttributedString alloc] initWithString:@"正在加载..."];
    }
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.dataSource == nil || self.dataSource.count == 0;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if(AL_MyAppDelegate.netWorkstatus == -1 || AL_MyAppDelegate.netWorkstatus == 0) {
        return [UIImage imageNamed:@"meiyouwangluo"];
    }
    if(self.dataSource == nil || self.dataSource.count == 0) {
        if(_tableStyle == ALTableStyleOrder) {
            return [UIImage imageNamed:@"meiyoudingdan"];
        } else if(_tableStyle == ALTableStyleRedEnvelope) {
            return [UIImage imageNamed:@"meiyouhongbao"];
        }
    }
    return nil;
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if(AL_MyAppDelegate.netWorkstatus == -1 || AL_MyAppDelegate.netWorkstatus == 0) {
        return [UIImage imageNamed:@"btn-jiazai"];
    }
    return nil;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 25;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 0;
}

#pragma mark lazy load
- (UITableView *)myTableView {
    if(!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.emptyDataSetSource = self;
        _myTableView.emptyDataSetDelegate = self;
        [self.view addSubview:_myTableView];
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BaseTableViewCellIdentifier];

        [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.width.equalTo(self.view);
            make.centerX.equalTo(self.view);
            make.height.mas_equalTo(self.view.bounds.size.height - ALTabBarHeight);
        }];
    }
    return _myTableView;
}

#pragma mark dealloc
- (void)dealloc {
    _myTableView.dataSource = nil;
    _myTableView.delegate = nil;
    _myTableView.emptyDataSetDelegate = nil;
    _myTableView.emptyDataSetSource = nil;
}
@end

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
    AL_WeakSelf(self);
    if(self.shouldPullToRefresh) {
        self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadDataSource];
        }];
    }
    
    if(self.shouldPullDownLoadMore) {
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreDataSource];
        }];
        footer.stateLabel.font = ALThemeFont(14);
        footer.stateLabel.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
        if(_tableStyle ==  ALTableStyleOrder) {
            [footer setTitle:@"没有更多订单了～" forState:MJRefreshStateNoMoreData];
        } else if(_tableStyle ==  ALTableStyleEvaluate) {
            [footer setTitle:@"没有更多评价了～" forState:MJRefreshStateNoMoreData];
        } else if(_tableStyle ==  ALTableStyleMyMessage) {
            [footer setTitle:@"没有更多消息了～" forState:MJRefreshStateNoMoreData];
        } else if(_tableStyle ==  ALTableStyleRedEnvelope) {
            [footer setTitle:@"没有更多红包了～" forState:MJRefreshStateNoMoreData];
        }
        self.myTableView.mj_footer = footer;
    }
    
}

//加载数据
- (void)loadDataSource {}

//加载更多数据
- (void)loadMoreDataSource {}

- (void)reload {
    if([self dataSourceIsEmpty]) {
        self.myTableView.tableHeaderView.hidden = YES;
    } else {
        self.myTableView.tableHeaderView.hidden = NO;
    }
    [self.myTableView reloadData];
}

//判断数据源是否为空
- (BOOL)dataSourceIsEmpty {
    BOOL isempty = YES;
    for (NSArray *array in self.dataSource) {
        if(array.count > 0) {
            isempty = NO;
            if(_tableStyle == ALTableStyleMyMessage) {
                self.myTableView.separatorColor = [UIColor colorWithRGB:0xF5F6FA];
            }
        }
    }
    return isempty;
}

//空数据提示文字
- (NSMutableAttributedString *)emptyTitleString:(NSString *)titie {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:titie];
    [attString setYy_font:ALThemeFont(14)];
    [attString setYy_color:[UIColor colorWithRGBA:ALLabelTextColor]];
    return attString;
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
    
    if([_emptyDataTitle isVaild] && [self dataSourceIsEmpty]) {
        return [self emptyTitleString:_emptyDataTitle];
    }
    
    if(AL_MyAppDelegate.netWorkstatus == -1 || AL_MyAppDelegate.netWorkstatus == 0) {
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return [self emptyTitleString:@"网络异常请稍后再试～"];
    } else {
        return [[NSAttributedString alloc] init];
    }
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return [self dataSourceIsEmpty];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if(AL_MyAppDelegate.netWorkstatus == -1 || AL_MyAppDelegate.netWorkstatus == 0) {
        if(_tableStyle == ALTableStyleMyMessage) {self.myTableView.separatorColor = [UIColor clearColor];}
        return [UIImage imageNamed:@"meiyouwangluo"];
    }
    if([self dataSourceIsEmpty]) {
        self.myTableView.separatorColor = [UIColor clearColor];
        if(_tableStyle == ALTableStyleOrder) {
            return [UIImage imageNamed:@"meiyoudingdan"];
        } else if(_tableStyle == ALTableStyleRedEnvelope) {
            return [UIImage imageNamed:@"meiyouhongbao"];
        } else if(_tableStyle == ALTableStyleMyMessage) {
            return [UIImage imageNamed:@"wuxiaoxi"];
        } else if(_tableStyle == ALTableStyleEvaluate) {
            return [UIImage imageNamed:@"wupingjia"];
        }
    } else {
        
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
            make.height.mas_equalTo(self.view.bounds.size.height - ALTabBarHeight - ALNavigationBarHeight);
        }];
    }
    return _myTableView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.preservesSuperviewLayoutMargins = NO;
}

- (void)viewDidLayoutSubviews {
    [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
    [self.myTableView setLayoutMargins:UIEdgeInsetsZero];
}

#pragma mark dealloc
- (void)dealloc {
    _myTableView.dataSource = nil;
    _myTableView.delegate = nil;
    _myTableView.emptyDataSetDelegate = nil;
    _myTableView.emptyDataSetSource = nil;
}
@end

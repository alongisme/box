//
//  ALBaseTableViewController.h
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"
#import <MJRefresh.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

typedef NS_ENUM(NSUInteger, ALTableStyle) {
    ALTableStyleOrder = 1,
    ALTableStyleRedEnvelope = 2,
    ALTableStyleMyMessage = 3,
    ALTableStyleEvaluate = 4,
};

@interface ALBaseTableViewController : ALBaseViewController <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, assign) ALTableStyle tableStyle;
//列表
@property (nonatomic, strong) UITableView *myTableView;
//标题
@property (nonatomic, copy) NSArray *sectionIndexTitles;
//数据源
@property (nonatomic, copy) NSArray *dataSource;
//分页
@property (nonatomic, assign) NSUInteger nextPage;
//分页大小
@property (nonatomic, assign) NSUInteger pageSize;
//上下拉刷新加载开关
@property (nonatomic, assign) BOOL shouldPullToRefresh;
@property (nonatomic, assign) BOOL shouldPullDownLoadMore;
//没有数据时 提示的文字
@property (nonatomic, strong) NSString *emptyDataTitle;
//刷新
- (void)reload;
//加载数据
- (void)loadDataSource;
//加载更多数据
- (void)loadMoreDataSource;
//初始化cell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
//自定义数据绑定
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
@end

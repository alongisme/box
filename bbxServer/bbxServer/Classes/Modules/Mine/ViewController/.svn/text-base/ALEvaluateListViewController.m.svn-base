//
//  ALEvaluateListViewController.m
//  bbxUser
//
//  Created by along on 2017/8/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALEvaluateListViewController.h"
#import "ALCommentTableViewCell.h"
//#import "ClickedLabelView.h"
#import "ALSecurityCommentListApi.h"
#import "ALCommentTagModel.h"
#import "ALCustomTagsView.h"

@interface ALEvaluateListViewController ()
@property (nonatomic, strong) ALSecurityCommentListApi *securityCommentListApi;
@property (nonatomic, assign) NSUInteger nowPage;
@end

@implementation ALEvaluateListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.title = @"我的评价";
    self.emptyDataTitle = @"暂无评价～";
    self.tableStyle = ALTableStyleEvaluate;
    self.shouldPullToRefresh = YES;
    self.shouldPullDownLoadMore = YES;
    [self addRefresh];
    [self initSubviews];
    [self loadDataSource];
}

- (void)loadDataSource {
    _nowPage = 1;
    _securityCommentListApi = [[ALSecurityCommentListApi alloc] initWithSecurityCommentListApi:_securityId nowPage:ALStringFormat(@"%lu",(unsigned long)_nowPage)];
    AL_WeakSelf(self);
    [_securityCommentListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ALSecurityEvaluateModel *model = weakSelf.securityCommentListApi.securityEvaluateModel;
        [weakSelf initStatistics];
        weakSelf.dataSource = @[weakSelf.securityCommentListApi.securityEvaluateModel.commentList];
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
    
    _securityCommentListApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _securityCommentListApi.dataErrorBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusDataError];
    };
}

- (void)reloadData {
    [self loadDataSource];
}

- (void)loadMoreDataSource {
    _nowPage++;
    _securityCommentListApi = [[ALSecurityCommentListApi alloc] initWithSecurityCommentListApi:_securityId nowPage:ALStringFormat(@"%lu",(unsigned long)_nowPage)];
    AL_WeakSelf(self);
    [_securityCommentListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf initStatistics];
        NSMutableArray *currentArr = [[weakSelf.dataSource firstObject] mutableCopy];
        ALSecurityEvaluateModel *model = weakSelf.securityCommentListApi.securityEvaluateModel;
        [currentArr addObjectsFromArray:model.commentList];
        weakSelf.dataSource = @[currentArr];
        [weakSelf reload];
        if([model.hasNextPage integerValue] == 1) {
            [weakSelf.myTableView.mj_footer endRefreshing];
        } else {
            [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.myTableView.mj_footer endRefreshing];
        weakSelf.nowPage--;
    }];
}

- (void)initSubviews {
    self.myTableView.backgroundColor = [UIColor colorWithRGB:0xF5F6FA];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myTableView registerClass:[ALCommentTableViewCell class] forCellReuseIdentifier:@"commtenIdentifier"];
    [self.myTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
}

- (void)initStatistics {
    
    //标签数据
    NSArray *statisticasArr = self.securityCommentListApi.securityEvaluateModel.statisticsList;
    if(statisticasArr.count > 0) {
        NSMutableArray *tagArr = [NSMutableArray array];
        for (ALStatisticsListModel *statisticsListModel in statisticasArr) {
            ALCommentTagModel *commentTagModel = [[ALCommentTagModel alloc] init];
            commentTagModel.commentTagDes = statisticsListModel.statisticsDes;
            [tagArr addObject:commentTagModel];
        }
        //标签
//        ClickedLabelView *clikedLabView = [[ClickedLabelView alloc] initWithFrame:CGRectMake(14, 0, self.view.frame.size.width - 28, 114) dataArray:tagArr];
//        clikedLabView.onlyShow = YES;
//        clikedLabView.backgroundColor = [UIColor clearColor];
        
        ALCustomTagsView *customTagView = [[ALCustomTagsView alloc] initWithFrame:CGRectMake(14, 0, self.view.frame.size.width - 28, 114) tagArray:tagArr startOffsetX:0 space:10 expandHeight:10 selected:NO];
        customTagView.selectedAll = YES;
        customTagView.backgroundColor = [UIColor clearColor];
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 114)];
        headView.backgroundColor = [UIColor clearColor];
        [headView addSubview:customTagView];
        
        self.myTableView.tableHeaderView = headView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    ALCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commtenIdentifier" forIndexPath:indexPath];
    return cell;
}

- (void)dealloc {
    [_securityCommentListApi stop];
}
@end

//
//  ALRedEnvlopeViewController.m
//  bbxUser
//
//  Created by along on 2017/8/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALRedEnvlopeViewController.h"
#import "ALExchangeCouponViewController.h"
#import "ALMyCouponListApi.h"
#import "ALRedEnvelopeTableViewCell.h"
#import "ALStepOneViewController.h"
#import "ALMainPageViewController.h"

@interface ALRedEnvlopeViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ALMyCouponListApi *myCouponListApi;

@end

@implementation ALRedEnvlopeViewController

- (void)viewDidLoad {

    [self initNavigationOption];
    
    self.tableStyle = ALTableStyleRedEnvelope;
    self.emptyDataTitle = @"您还没有优惠券哦~";
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myTableView registerClass:[ALRedEnvelopeTableViewCell class] forCellReuseIdentifier:@"redEnvelopeIdentifier"];
    self.myTableView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0);
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadDataSource];
}

#pragma mark emptyDataSet
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self loadDataSource];
}

#pragma mark ConfigureNavigation
- (void)initNavigationOption {
    self.title = @"我的优惠券";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"兑换券码" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark Action
- (void)rightAction {
    [self.navigationController pushViewController:[[ALExchangeCouponViewController alloc] init] animated:YES];
}

- (void)loadDataSource {
    _myCouponListApi = [[ALMyCouponListApi alloc] initWithMyCouponList];
    
    AL_WeakSelf(self);
    [_myCouponListApi ALHudStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        weakSelf.dataSource = @[weakSelf.myCouponListApi.couponList];
        [weakSelf reload];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf reload];
    }];
    
    _myCouponListApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _myCouponListApi.dataErrorBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusDataError];
    };
}

- (void)reloadData {
    [self loadDataSource];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 102;
}

#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    ALRedEnvelopeTableViewCell *cell = [[ALRedEnvelopeTableViewCell alloc] initWithListStyle:UITableViewCellStyleValue1 reuseIdentifier:@"redEnvelopeIdentifier"];
    
    cell.selectedBlock = ^(NSUInteger index) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ALBaseNavigationController *baseVavigationC = (ALBaseNavigationController *)AL_MyAppDelegate.window.rootViewController;
            ALMainPageViewController *mainPageVC = (ALMainPageViewController *)baseVavigationC.topViewController;
            [mainPageVC emergencyCallAction];
        });
        [ALKeyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
    };
    
    [cell bindModel:[self.dataSource firstObject][indexPath.row]];
    return cell;
}

- (void)dealloc {
    [_myCouponListApi stop];
}

@end

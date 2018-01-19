//
//  ALRedEnvelopeViewController.m
//  bbxUser
//
//  Created by along on 2017/8/3.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALRedEnvelopeViewController.h"
#import "ALRedEnvelopeTableViewCell.h"
#import "ALExchangeCouponViewController.h"
#import "ALAvailableCouponListApi.h"

@interface ALRedEnvelopeViewController ()
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) ALLabel *redEnvelopeLab;
@property (nonatomic, strong) ALShadowView *noUsedRedEnvelopeView;
@property (nonatomic, strong) ALAvailableCouponListApi *availableCouponListApi;
@end

@implementation ALRedEnvelopeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    [self initNavigationOption];
    [self initSubviews];
    [self bindAction];
}

- (void)viewDidAppear:(BOOL)animated {
    [self loadDataSource];
}

- (void)initSubviews {
    [self.noUsedRedEnvelopeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.equalTo(@10);
        make.height.equalTo(@45);
    }];
    
    [self.myTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.noUsedRedEnvelopeView.mas_bottom).offset(10);
        make.width.centerX.equalTo(self.view);
        make.bottom.equalTo(@0);
    }];
    
    self.myTableView.tableHeaderView = self.headView;
    self.myTableView.tableHeaderView.hidden = YES;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myTableView registerClass:[ALRedEnvelopeTableViewCell class] forCellReuseIdentifier:@"redEnvelopeIdentifier"];
}

- (void)bindAction {
    AL_WeakSelf(self);
    self.noUsedRedEnvelopeView.rightImageClickBlock = ^{
        weakSelf.noUsedRedEnvelopeView.dontUseRedEnv = YES;
        for (ALRedEnvelopoModel *model in weakSelf.dataSource.firstObject) {
            model.isSelected = @0;
        }
        [weakSelf.myTableView reloadData];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        if([weakSelf.redEvelopeDelegate respondsToSelector:@selector(didSelectedWithIndex:model:)]) {
            [weakSelf.redEvelopeDelegate didSelectedWithIndex:-1 model:nil];
        }
    };
}

- (void)loadDataSource {
    _availableCouponListApi = [[ALAvailableCouponListApi alloc] initWithAvailableCouponListApi:_orderId];
    AL_WeakSelf(self);
    [_availableCouponListApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {

        if(weakSelf.selectedIndex == -1) {
            weakSelf.noUsedRedEnvelopeView.dontUseRedEnv = YES;
        }
        for (unsigned int i = 0; i < weakSelf.availableCouponListApi.couponList.count; i++) {
            if(i == weakSelf.selectedIndex - 1) {
                weakSelf.availableCouponListApi.couponList[i].isSelected = @1;
            }
        }
        
        weakSelf.dataSource = @[weakSelf.availableCouponListApi.couponList];
        [weakSelf setRedEvelope];
        [weakSelf reload];
        
        [weakSelf removeRequestStatusView];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [ALKeyWindow showHudError:@"红包列表获取失败～"];
    }];
    
    _availableCouponListApi.noNetworkBlock = ^{
        [weakSelf showRequestStauts:ALRequestStatusNoNetwork];
    };
    
    _availableCouponListApi.dataErrorBlock = ^{
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
    ALRedEnvelopeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"redEnvelopeIdentifier" forIndexPath:indexPath];
    [cell bindModel:[self.dataSource firstObject][indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.noUsedRedEnvelopeView.dontUseRedEnv = NO;
    NSMutableArray *sectionArray = [self.dataSource firstObject];
    for (unsigned int i = 0; i < sectionArray.count; i++) {
        ALRedEnvelopoModel *model = sectionArray[i];
        if(i == indexPath.row) {
            model.isSelected = @1;
        } else {
            model.isSelected = @0;
        }
    }
    [self reload];
    [self.navigationController popViewControllerAnimated:YES];
    
    if([self.redEvelopeDelegate respondsToSelector:@selector(didSelectedWithIndex:model:)]) {
        [self.redEvelopeDelegate didSelectedWithIndex:(int)indexPath.row + 1 model:[self.dataSource firstObject][indexPath.row]];
    }
}

#pragma mark ConfigureNavigation
- (void)initNavigationOption {
    self.title = @"使用优惠券";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"兑换券码" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark Action
- (void)rightAction {
    [self.navigationController pushViewController:[[ALExchangeCouponViewController alloc] init] animated:YES];
}

- (void)setRedEvelope {
    NSMutableAttributedString *resultAttr = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"有 %lu 个红包可用",[[self.dataSource firstObject] count])];
    resultAttr.yy_font = ALThemeFont(13);
    [resultAttr yy_setColor:[UIColor colorWithRGB:0xF8504F] range:NSMakeRange(2, 1)];
    _redEnvelopeLab.attributedText = resultAttr;
}

#pragma mark lazy load
- (ALShadowView *)noUsedRedEnvelopeView {
    if(!_noUsedRedEnvelopeView) {
        _noUsedRedEnvelopeView = [[ALShadowView alloc] initWithFrame:CGRectZero title:@"不使用红包" imageName:@"select_nor" type:ALShadowStyleLabelImage];
        [self.view addSubview:_noUsedRedEnvelopeView];
    }
    return _noUsedRedEnvelopeView;
}

- (UIView *)headView {
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ALScreenWidth, 25)];
    _headView.backgroundColor = [UIColor clearColor];
    _redEnvelopeLab = [[ALLabel alloc] init];
    _redEnvelopeLab.font = ALThemeFont(13);
    [_headView addSubview:_redEnvelopeLab];
    
    [_redEnvelopeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headView);
        make.left.equalTo(@15);
    }];
    
    if([[self.dataSource firstObject] count] == 0) {
        _redEnvelopeLab.text = @"无红包可用";
    } else {
        [self setRedEvelope];
    }
    return _headView;
}

- (void)dealloc {
    [_availableCouponListApi stop];
}
@end

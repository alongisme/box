//
//  ALChoseAddressViewController.m
//  AnyHelp
//
//  Created by along on 2017/7/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALChoseAddressViewController.h"
#import "ALSearchBarView.h"
#import "ALNoResultView.h"
#import "ALSearchResultCell.h"

@interface ALChoseAddressViewController ()<ALSearchResultDelegate,UITableViewDelegate,UITableViewDataSource,BMKPoiSearchDelegate> {
    BMKPointAnnotation *locationPointAnnotation;
}
@property (nonatomic, strong) ALNoResultView *noResultView;
@property (nonatomic, strong) ALSearchBarView *searchBarView;
@property (nonatomic, strong) BMKPoiSearch *poiSearch;
@property (nonatomic, strong) UITableView *resultTV;
@property (nonatomic, strong) NSArray *geoArray;
@property (nonatomic, strong) UIImageView *centerIV;
@property (nonatomic, assign) BOOL isSearchMode;

@property (nonatomic, strong) UITableView *poiTV;
@property (nonatomic, strong) NSMutableArray *poiArray;
@property (nonatomic, assign) int pageIndex;
@property (nonatomic, assign) int pageCapacity;
@property (nonatomic, assign) BOOL isPullRefresh;
@end

@implementation ALChoseAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择地址";
    
    _pageIndex = 0;
    _pageCapacity = 20;
    _poiArray = [NSMutableArray array];
    _geoArray = [NSMutableArray array];

    //初始化控件
    [self initsubviews];
    
    [self initFooterFrefresh];
}

- (void)initFooterFrefresh {
    AL_WeakSelf(self);
    self.poiTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isPullRefresh = YES;
        [weakSelf searchResultWithKeyWord:weakSelf.searchBarView.searchBar.text];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.poiSearch.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.poiSearch.delegate = nil;
}

- (void)backAction {
    if(_isSearchMode) {
        self.poiTV.hidden = YES;
        self.noResultView.hidden = YES;
        [self.searchBarView endEditing:YES];
        _isSearchMode = NO;
        self.searchBarView.searchBar.text = @"";
        [self.view hideHud];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)initsubviews {
    
    UIView *seachBarV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ALScreenWidth - 60, 30)];
    [seachBarV addSubview:self.searchBarView];
    self.navigationItem.titleView = seachBarV;
    
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.bottom.equalTo(@-19);
    }];
    
    [self.resultTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
        make.height.equalTo(@250);
    }];
    
    [self.mapView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@64);
        make.bottom.equalTo(self.resultTV.mas_top);
    }];
    
    [self.centerIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mapView);
        make.centerY.equalTo(self.mapView).offset(-12);
    }];
    
    [self.poiTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@64);
    }];
    
    [self.noResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@64);
    }];
}

- (void)loacationStopWithcoor:(CLLocationCoordinate2D)coor {;
    [self startReverseGeoCodeWithGeoPoint:coor];
    if(locationPointAnnotation) {
        [self.mapView removeAnnotation:locationPointAnnotation];
    }
    locationPointAnnotation = [[BMKPointAnnotation alloc]init];
    locationPointAnnotation.coordinate = coor;
    [self.mapView addAnnotation:locationPointAnnotation];
}

#pragma mark BMKGeoCodeSearchDelegate
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    self.geoArray = result.poiList;
    [self.resultTV reloadData];
}

#pragma mark BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    CLLocationCoordinate2D centerCoor = [mapView convertPoint:self.centerIV.center toCoordinateFromView:mapView];
    [self startReverseGeoCodeWithGeoPoint:centerCoor];
}

#pragma mark BMKPoiSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    [self.view hideHud];
    NSMutableArray *resultArray = [NSMutableArray array];
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        resultArray = [poiResult.poiInfoList mutableCopy];
    } else if (errorCode == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR) {
        
    } else if (errorCode == BMK_SEARCH_RESULT_NOT_FOUND) {
        
    }
    [self.searchBarView endEditing:YES];
    self.isSearchMode = YES;
    self.poiTV.hidden = NO;
    if(_isPullRefresh) {
        self.noResultView.hidden = YES;
        
        if(resultArray.count == 0) {
            [self.poiTV.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.poiArray addObjectsFromArray:resultArray];
            [self.poiTV reloadData];
            [self.poiTV.mj_footer endRefreshing];
            self.pageIndex--;
        }
    } else {
        if(resultArray.count == 0) {
            self.noResultView.hidden = NO;
        } else {
            self.poiArray = [NSMutableArray arrayWithArray:resultArray];
            [self.poiTV reloadData];
        }
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    if(annotation == locationPointAnnotation) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        
        //设置标注的颜色
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        
        //设置标注的动画效果
        newAnnotationView.animatesDrop = NO;
        newAnnotationView.selected = YES;
        //自定义标注的图像
        newAnnotationView.image = [UIImage imageNamed:@"dangqianweizhi"];
        newAnnotationView.centerOffset = CGPointMake(0, 3);
        return newAnnotationView;
    }
    return nil;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BMKPoiInfo *resultModel = nil;
    if(tableView == self.poiTV) {
        resultModel = self.poiArray[indexPath.row];
    } else {
        resultModel = self.geoArray[indexPath.row];
    }
    
    if([self.choseAddressDelegate respondsToSelector:@selector(getServerAddressInLocation:)]) {
        [self.choseAddressDelegate getServerAddressInLocation:resultModel];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView == self.poiTV ? self.poiArray.count : self.geoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *geoIdentifier = @"geoIdentifier";
    static NSString *poiIdentifier = @"poiIdentifier";
    
    NSString *identifier = tableView == self.poiTV ? poiIdentifier : geoIdentifier;
    NSArray *dataArray = tableView == self.poiTV ? self.poiArray : self.geoArray;
    
    ALSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[ALSearchResultCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    ALSearchResultModel *model = dataArray[indexPath.row];
    if(indexPath.row == 0) {
        cell.isFirst = YES;
    } else {
        cell.isFirst = NO;
    }
    cell.model = model;
    return cell;
}

#pragma mark ALSearchResultDelegate
- (void)searchResultWithKeyWord:(NSString *)keyWord {
    [self.view hideHud];
    [self.view showHud];
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    if(self.isPullRefresh) {
        _pageIndex++;
    } else {
        _pageIndex = 0;
    }
    citySearchOption.pageIndex = _pageIndex;
    citySearchOption.pageCapacity = _pageCapacity;
    citySearchOption.city= @"上海";
    citySearchOption.keyword = keyWord;
    BOOL flag = [self.poiSearch poiSearchInCity:citySearchOption];
    if(flag) {
        NSLog(@"城市内检索发送成功");
    } else {
        NSLog(@"城市内检索发送失败");
        [self.poiTV.mj_footer endRefreshing];
        [self.view hideHud];
    }
}

- (void)startNewSearch {
    self.isPullRefresh = NO;
}

#pragma mark lazy load

- (ALSearchBarView *)searchBarView {
    if(!_searchBarView) {
        _searchBarView = [[ALSearchBarView alloc] initWithFrame:CGRectMake(15, 0, ALScreenWidth - 75, 30)];
        _searchBarView.resultDelegate = self;
    }
    return _searchBarView;
}

- (ALNoResultView *)noResultView {
    if(!_noResultView) {
        _noResultView = [[ALNoResultView alloc] init];
        _noResultView.hidden = YES;
        [self.view addSubview:_noResultView];
    }
    return _noResultView;
}

- (BMKPoiSearch *)poiSearch {
    if(!_poiSearch) {
        _poiSearch = [[BMKPoiSearch alloc] init];
    }
    return _poiSearch;
}

- (UITableView *)resultTV {
    if(!_resultTV) {
        _resultTV = [[UITableView alloc] init];
        _resultTV.delegate = self;
        _resultTV.dataSource = self;
        [self.view addSubview:_resultTV];
        [_resultTV registerClass:[ALSearchResultCell class] forCellReuseIdentifier:@"resultIdentifier"];
    }
    return _resultTV;
}

- (UIImageView *)centerIV {
    if(!_centerIV) {
        _centerIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_moveLocation"]];
        [self.mapView addSubview:_centerIV];
    }
    return _centerIV;
}

- (UITableView *)poiTV {
    if(!_poiTV) {
        _poiTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _poiTV.delegate = self;
        _poiTV.dataSource = self;
        _poiTV.hidden = YES;
        [self.view addSubview:_poiTV];
    }
    return _poiTV;
}

@end

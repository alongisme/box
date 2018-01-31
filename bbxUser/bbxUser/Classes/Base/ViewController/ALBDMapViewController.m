//
//  ALBDMapViewController.m
//  bbxUser
//
//  Created by along on 2017/8/2.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBDMapViewController.h"

@interface ALBDMapViewController () 

@end

@implementation ALBDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化搜索
    _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(ALNavigationBarHeight, 0, 0, 0));
    }];
    
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.bottom.equalTo(@-19);
    }];
    
    //开始定位
    [self startLocation];    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locationService.delegate = self;
    _geoCodeSearch.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locationService.delegate = nil;
    _geoCodeSearch.delegate = nil;
}

#pragma mark Action
- (void)rightAction {
    NSLog(@"userCenter click");
}

- (void)startLocation {
    if(!_locationService) {
        _locationService = [[BMKLocationService alloc] init];
        _mapView.showsUserLocation = NO;
    }
    [_locationService startUserLocationService];
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView.showsUserLocation = NO;
}

- (void)locationBtnAction {
    [self startLocation];
}

- (void)startReverseGeoCodeWithGeoPoint:(CLLocationCoordinate2D)coor {
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = coor;
    BOOL flag2 = [_geoCodeSearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag2) {
        NSLog(@"反geo检索发送成功");
    } else {
        NSLog(@"反geo检索发送失败");
    }
}

//自定义精度圈
- (void)customLocationAccuracyCircle:(BOOL)isMainPage {
//    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
//    param.isAccuracyCircleShow = NO;
//    param.locationViewImgName = isMainPage ? @"shouye-dangqianweizhi" : @"dangqianweizhi";//mapapi.bundle/Image/xxx
//    [self.mapView updateLocationViewWithParam:param];
}

- (void)loacationStopWithcoor:(CLLocationCoordinate2D)coor {}

#pragma mark BMKMapViewDelegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
        
    [_locationService stopUserLocationService];
    
    BMKMapStatus *status = [[BMKMapStatus alloc] init];
    status.fLevel = 15;
    status.targetGeoPt = userLocation.location.coordinate;
    [_mapView setMapStatus:status withAnimation:YES];
    
    [self loacationStopWithcoor:userLocation.location.coordinate];
}

- (void)setLocationService:(BMKLocationService *)locationService {}

/**
 *定位失败后，会调用此函数
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

#pragma mark lazy load 
- (BMKMapView *)mapView {
    if(!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectZero];
        _mapView.buildingsEnabled = NO;
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

- (UIButton *)locationBtn {
    if(!_locationBtn) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationBtn setBackgroundImage:[UIImage imageNamed:@"icon_current location"] forState:UIControlStateNormal];
        [_locationBtn addTarget:self action:@selector(locationBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.mapView addSubview:_locationBtn];
    }
    return _locationBtn;
}
@end

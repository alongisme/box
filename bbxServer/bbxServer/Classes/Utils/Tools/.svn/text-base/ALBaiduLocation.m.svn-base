//
//  ALBaiduLocation.m
//  bbxServer
//
//  Created by along on 2017/9/5.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaiduLocation.h"
#import "ALSecurityLocationApi.h"

@interface ALBaiduLocation () <BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate> {
    UILabel *lab;
}
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) ALSecurityLocationApi *securityLocationApi;
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;
@end

@implementation ALBaiduLocation

static ALBaiduLocation *_baiduLocation = nil;

+ (instancetype)shardInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _baiduLocation = [[self alloc] init];
    });
    return _baiduLocation;
}

- (void)initLocationService {
    _locService = [[BMKLocationService alloc] init];
    _locService.allowsBackgroundLocationUpdates = YES;
    _locService.pausesLocationUpdatesAutomatically = NO;
    _locService.distanceFilter = 200;
    
    _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
}

- (void)startUserLocationService {
    _locService.delegate = self;
    _geoCodeSearch.delegate = self;
    [_locService startUserLocationService];
}

- (void)stopUserLocationService {
    _locService.delegate = nil;
    _geoCodeSearch.delegate = nil;
    [_locService stopUserLocationService];
}

- (void)didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"didFailToLocateUserWithError : %@",error);
}

#pragma mark BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [_geoCodeSearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag) {
        NSLog(@"反geo检索发送成功");
    } else {
        NSLog(@"反geo检索发送失败");
    }
}

#pragma mark BMKGeoCodeSearchDelegate
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if([result.address isVaild]) {
        if(_securityLocationApi.isExecuting) {
            [_securityLocationApi stop];
        }
        
        _securityLocationApi = [[ALSecurityLocationApi alloc] initSecurityLocation:ALStringFormat(@"%f,%f",result.location.longitude,result.location.latitude) address:result.address];
        
        [_securityLocationApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    }
}

@end

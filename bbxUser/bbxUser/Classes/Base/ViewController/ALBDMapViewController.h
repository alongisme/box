//
//  ALBDMapViewController.h
//  bbxUser
//
//  Created by along on 2017/8/2.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface ALBDMapViewController : ALBaseViewController <BMKLocationServiceDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate> {
    BMKGeoCodeSearch *_geoCodeSearch;
}

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, strong) UIButton *locationBtn;
//@property (nonatomic, assign) int flag; // 1 镖师动态匹配镖师 2镖师动态等待受理

//定位停止调用
- (void)loacationStopWithcoor:(CLLocationCoordinate2D)coor;

//自定义定位圈
- (void)customLocationAccuracyCircle:(BOOL)isMainPage;

//开始解析经纬度
- (void)startReverseGeoCodeWithGeoPoint:(CLLocationCoordinate2D)coor;
@end

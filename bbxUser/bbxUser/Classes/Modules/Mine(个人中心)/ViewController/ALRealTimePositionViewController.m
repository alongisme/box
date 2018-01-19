//
//  ALRealTimePositionViewController.m
//  bbxUser
//
//  Created by along on 2017/8/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALRealTimePositionViewController.h"
#import "ALRealTImePositionAnnotationView.h"
#import "ALOrderSecurityLocationApi.h"
#import "ALSecurityInfoViewController.h"

@interface ALRealTimePositionViewController ()
@property (nonatomic, strong) NSTimer *locationTimer;
@property (nonatomic, strong) ALOrderSecurityLocationApi *orderSecurityLocationApi;
@end

@implementation ALRealTimePositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"保镖实时位置";
    
    //移除定位按钮
    [self.locationBtn removeFromSuperview];
    self.locationBtn = nil;
    
    self.locationTimer = [NSTimer timerWithTimeInterval:30.0f target:self selector:@selector(locationReloadAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.locationTimer forMode:NSRunLoopCommonModes];
}

- (void)backAction {
    [self.locationTimer invalidate];
    self.locationTimer = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.locationTimer setFireDate:[NSDate distantPast]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.locationTimer setFireDate:[NSDate distantFuture]];
}

- (void)locationReloadAction {
    if(_orderSecurityLocationApi.isExecuting) {
        [_orderSecurityLocationApi stop];
    }
    
    [self loadData];
}

- (void)loadData {
    _orderSecurityLocationApi = [[ALOrderSecurityLocationApi alloc] initOrderSecurityLocation:_orderId];
    
    AL_WeakSelf(self);
    [_orderSecurityLocationApi ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [weakSelf.mapView removeAnnotations:weakSelf.mapView.annotations];
        
        for (ALSecurityLocationModel *model in weakSelf.orderSecurityLocationApi.poiListArray) {
            BMKPointAnnotation *animatedAnnotation = [[BMKPointAnnotation alloc]init];
            animatedAnnotation.coordinate = CLLocationCoordinate2DMake([model.latitude floatValue], [model.longitude floatValue]);
            animatedAnnotation.subtitle = model.securityId;
            [weakSelf.mapView addAnnotation:animatedAnnotation];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    NSString *AnnotationViewID = @"AnimatedAnnotation";
    ALRealTImePositionAnnotationView *annotationView = nil;
    if (annotationView == nil) {
        annotationView = [[ALRealTImePositionAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        annotationView.canShowCallout = NO;
    }
    for (ALSecurityLocationModel *model in self.orderSecurityLocationApi.poiListArray) {
        if([model.securityId isEqualToString:annotation.subtitle]) {
            [annotationView.annotationImageView sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@",model.icon)] placeholderImage:[UIImage imageNamed:@"touxiang_weidenglu"]];
        }
    }
    return annotationView;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    for (ALSecurityLocationModel *model in self.orderSecurityLocationApi.poiListArray) {
        if([model.securityId isEqualToString:view.annotation.subtitle]) {
            ALSecurityInfoViewController *securityInfoVC = [[ALSecurityInfoViewController alloc] init];
            securityInfoVC.securityId = view.annotation.subtitle;
            [self.navigationController pushViewController:securityInfoVC animated:YES];
            break;
        }
    }
}

- (void)dealloc {
    [_orderSecurityLocationApi stop];
}
@end

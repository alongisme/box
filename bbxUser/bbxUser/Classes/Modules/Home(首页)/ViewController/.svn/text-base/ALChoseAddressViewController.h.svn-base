//
//  ALChoseAddressViewController.h
//  AnyHelp
//
//  Created by along on 2017/7/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"
#import "ALSearchResultModel.h"

@protocol ALChoseAddressDelegate <NSObject>

- (void)getServerAddressInLocation:(BMKPoiInfo *)model;
@end

@interface ALChoseAddressViewController : ALBDMapViewController
@property (nonatomic, weak) id<ALChoseAddressDelegate> choseAddressDelegate;
@end

//
//  ALStepTwoViewController.h
//  AnyHelp
//
//  Created by along on 2017/7/27.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"

@interface ALStepTwoViewController : ALBaseViewController
@property (nonatomic, copy) NSString *serviceAddress;
@property (nonatomic, copy) NSString *contactsName;
@property (nonatomic, copy) NSString *contactsPhone;
@property (nonatomic, strong) NSNumber *contactsSex;
@property (nonatomic) CLLocationCoordinate2D pt;
@end

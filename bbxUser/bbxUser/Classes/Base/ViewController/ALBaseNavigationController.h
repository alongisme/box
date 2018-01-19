//
//  ALBaseNavigationController.h
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALCustomNavigationView.h"

@interface ALBaseNavigationController : UINavigationController
@property (nonatomic, strong) ALCustomNavigationView *customNavigationView;
@end

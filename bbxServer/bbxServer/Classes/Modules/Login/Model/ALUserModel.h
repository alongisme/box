//
//  ALUserModel.h
//  AnyHelp
//
//  Created by along on 2017/7/19.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALUserIDModel.h"
#import "ALUserInfoModel.h"

@interface ALUserModel : JSONModel
@property (nonatomic, strong) ALUserIDModel *idModel;
@property (nonatomic, strong) ALUserInfoModel *userInfoModel;
@end

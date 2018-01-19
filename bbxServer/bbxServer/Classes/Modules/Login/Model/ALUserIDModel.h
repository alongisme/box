//
//  ALUserIDModel.h
//  bbxUser
//
//  Created by along on 2017/8/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ALUserIDModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *uuid;
@property (nonatomic, copy) NSString<Optional> *userId;
@end

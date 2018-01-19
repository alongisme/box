//
//  ALUserInfoModel.h
//  bbxUser
//
//  Created by along on 2017/8/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ALUserInfoModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *icon;
@property (nonatomic, copy) NSString<Optional> *nickName;
@property (nonatomic, copy) NSString<Optional> *phone;
@property (nonatomic, copy) NSNumber<Optional> *neMessage;
@end

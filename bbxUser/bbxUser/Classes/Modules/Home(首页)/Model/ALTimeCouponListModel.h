//
//  ALTimeCouponListModel.h
//  bbxUser
//
//  Created by xlshi on 2017/11/22.
//  Copyright © 2017年 along. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ALTimeCouponListModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *discount;
@property (nonatomic, copy) NSString<Optional> *limitPrice;
@property (nonatomic, copy) NSString<Optional> *expireTimeDes;
@end

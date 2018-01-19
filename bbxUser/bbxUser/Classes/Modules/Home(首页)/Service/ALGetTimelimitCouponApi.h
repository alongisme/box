//
//  ALGetTimelimitCouponApi.h
//  bbxUser
//
//  Created by xlshi on 2017/11/22.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALTimeCouponListModel.h"

@interface ALGetTimelimitCouponApi : ALHttpRequest
@property (nonatomic, strong) NSArray<ALTimeCouponListModel *> *timeCouponList;
- (instancetype)initGetTimelimitCouponApi;
@end

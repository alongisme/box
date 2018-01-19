//
//  ALMyCouponListApi.h
//  bbxUser
//
//  Created by along on 2017/8/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALRedEnvelopoModel.h"

@interface ALMyCouponListApi : ALHttpRequest

@property (nonatomic, strong) NSArray<ALRedEnvelopoModel *> *couponList;

- (instancetype)initWithMyCouponList;
@end

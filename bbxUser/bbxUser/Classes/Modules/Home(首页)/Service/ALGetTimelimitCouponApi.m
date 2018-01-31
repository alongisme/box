//
//  ALGetTimelimitCouponApi.m
//  bbxUser
//
//  Created by xlshi on 2017/11/22.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALGetTimelimitCouponApi.h"

@implementation ALGetTimelimitCouponApi
- (instancetype)initGetTimelimitCouponApi {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_Four_GetTimelimitCoupon;
}

- (id)requestArgument {
    if([AL_MyAppDelegate.userModel.idModel.userId isVaild]) {
        return @{
                 UserID_CommonParams
             };
    } else {
        return @{};
    }
}

- (NSArray<ALTimeCouponListModel *> *)timeCouponList {
    if(!_timeCouponList) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in self.data[@"timeCouponList"]) {
            ALTimeCouponListModel *timeCouponListModel = [[ALTimeCouponListModel alloc] initWithDictionary:dic error:nil];
            [arr addObject:timeCouponListModel];
        }
        _timeCouponList = [arr copy];
    }
    return _timeCouponList;
}
@end

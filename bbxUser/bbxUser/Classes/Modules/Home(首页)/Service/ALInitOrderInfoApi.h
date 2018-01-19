//
//  ALInitOrderInfoApi.h
//  bbxUser
//
//  Created by along on 2017/8/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALServiceLengthModel.h"

@interface ALInitOrderInfoApi : ALHttpRequest
@property (nonatomic, strong) NSArray<ALServiceLengthModel *> *serviceLengthModelArray;

- (instancetype)initOrderInfoApi;
@end

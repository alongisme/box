//
//  ALQueryBannerListApi.h
//  bbxUser
//
//  Created by xlshi on 2017/11/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALBannerListModel.h"

@interface ALQueryBannerListApi : ALHttpRequest

@property (nonatomic, strong) NSArray<ALBannerListModel *> *bannerListArray;

- (instancetype)initQueryBannerListApi;

@end

//
//  ALMyProfitListApi.h
//  bbxServer
//
//  Created by along on 2017/9/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALProfitModel.h"

@interface ALMyProfitListApi : ALHttpRequest
@property (nonatomic, strong) ALProfitModel *profitModel;
- (instancetype)initMyProfitListApi:(NSString *)nowPage;
@end

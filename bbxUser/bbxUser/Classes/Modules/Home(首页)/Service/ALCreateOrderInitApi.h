//
//  ALCreateOrderInitApi.h
//  bbxUser
//
//  Created by along on 2017/9/20.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALCommentTagModel.h"
#import "ALOptionListModel.h"

@interface ALCreateOrderInitApi : ALHttpRequest
@property (nonatomic, strong) NSArray<ALOptionListModel *> *optionList;
@property (nonatomic, strong) NSArray<ALServiceLengthModel *> *serviceLengthModelArray;
@property (nonatomic, strong) NSArray<ALCommentTagModel *> *skillTagListArray;
@property (nonatomic, strong) NSArray *exRequireList;
- (instancetype)initCreateOrderInitApi;
@end

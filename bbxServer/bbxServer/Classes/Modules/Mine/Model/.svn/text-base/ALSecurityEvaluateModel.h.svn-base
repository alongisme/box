//
//  ALSecurityEvaluateModel.h
//  bbxUser
//
//  Created by along on 2017/8/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ALSecurityInfoModel.h"

@protocol ALStatisticsListModel
@end

@interface ALSecurityEvaluateModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *pageSize;
@property (nonatomic, copy) NSString<Optional> *hasNextPage;
@property (nonatomic, copy) NSString<Optional> *size;
@property (nonatomic, copy) NSArray<Optional,ALCommentModel> *commentList;
@property (nonatomic, copy) NSArray<Optional,ALStatisticsListModel> *statisticsList;
@end

@interface ALStatisticsListModel : JSONModel
@property (nonatomic, copy) NSString *statisticsDes;
@end

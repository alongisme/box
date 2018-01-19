//
//  ALProfitModel.h
//  bbxServer
//
//  Created by along on 2017/9/21.
//  Copyright © 2017年 along. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ALProfitListModel
@end

@interface ALProfitModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *size;
@property (nonatomic, copy) NSString<Optional> *paegSize;
@property (nonatomic, copy) NSString<Optional> *hasNextPage;
@property (nonatomic, strong) NSArray<Optional,ALProfitListModel> *profitList;
@end

@interface ALProfitListModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *tradeMoney;
@property (nonatomic, copy) NSString<Optional> *createTime;
@property (nonatomic, copy) NSString<Optional> *profitType;
@property (nonatomic, copy) NSString<Optional> *tradeType;
@end

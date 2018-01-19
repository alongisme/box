//
//  ALMyMessageModel.h
//  bbxUser
//
//  Created by along on 2017/8/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ALNoticeModel
@end

@interface ALMyMessageModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *pageSize;
@property (nonatomic, copy) NSString<Optional> *hasNextPage;
@property (nonatomic, copy) NSString<Optional> *size;
@property (nonatomic, strong) NSArray<Optional,ALNoticeModel> *noticeList;
@end

@interface ALNoticeModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *noticeId;
@property (nonatomic, copy) NSString<Optional> *noticeInfo;
@property (nonatomic, copy) NSString<Optional> *isNews;
@property (nonatomic, copy) NSString<Optional> *pusher;
@property (nonatomic, copy) NSString<Optional> *pushTime;
@property (nonatomic, copy) NSString<Optional> *newsId;
@end

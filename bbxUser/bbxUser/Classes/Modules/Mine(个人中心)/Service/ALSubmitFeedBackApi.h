//
//  ALSubmitFeedBackApi.h
//  AnyHelp
//
//  Created by along on 2017/7/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALSubmitFeedBackApi : ALHttpRequest


/**
 提交意见反馈接口

 @param content 意见内容
 @param contactWay 联系方式
 @param pickUrls 图片链接，逗号隔开
 @return self
 */
- (instancetype)initWithSubmitFeedBackApi:(NSString *)content
                               contactWay:(NSString *)contactWay
                                  picUrls:(NSString *)pickUrls;

+ (instancetype)SubmitFeedBackApi:(NSString *)content
                       contactWay:(NSString *)contactWay
                          picUrls:(NSString *)pickUrls;
@end

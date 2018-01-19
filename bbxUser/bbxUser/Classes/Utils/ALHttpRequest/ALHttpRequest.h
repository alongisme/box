//
//  ALHttpRequest.h
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALUrlArgumentsFilter.h"

@interface ALHttpRequest : YTKBaseRequest
NS_ASSUME_NONNULL_BEGIN
@property (nonatomic, copy) NSDictionary *result;
@property (nonatomic, copy) NSDictionary *data;
@property (nonatomic, copy) void (^noNetworkBlock)();
@property (nonatomic, copy) void (^dataErrorBlock)();
NS_ASSUME_NONNULL_END

//自定义开始方法 做消息处理
- (void)ALStartWithCompletionBlockWithSuccess:(nullable YTKRequestCompletionBlock)success
                                      failure:(nullable YTKRequestCompletionBlock)failure;

//带toast请求
- (void)ALHudStartWithCompletionBlockWithSuccess:(nullable YTKRequestCompletionBlock)success
                                      failure:(nullable YTKRequestCompletionBlock)failure;

//带错误返回请求
- (void)ALCustomHudStartWithErrorBlock:(void (^_Nonnull)(NSString * _Nullable message))errorBlock CompletionBlockWithSuccess:(nullable YTKRequestCompletionBlock)success failure:(nullable YTKRequestCompletionBlock)failure;
@end


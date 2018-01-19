//
//  ALMultiImageUploadApi.h
//  bbxUser
//
//  Created by along on 2017/8/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKBatchRequest.h>

@interface ALMultiImageUploadApi : NSObject
+ (instancetype)multiImageUploadStart:(NSArray *)imageArray Success:(void (^)(NSString *filePathString))success failure:(void (^)())failure;

- (instancetype)initWithMultiImageUploadStart:(NSArray *)imageArray Success:(void (^)(NSString *filePathString))success failure:(void (^)())failure;
@end

//
//  ALMultiImageUploadApi.m
//  bbxUser
//
//  Created by along on 2017/8/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMultiImageUploadApi.h"
#import "ALUploadApi.h"

@interface ALMultiImageUploadApi ()
@property (nonatomic, copy) NSString *filePathString;
@end

@implementation ALMultiImageUploadApi

+ (instancetype)multiImageUploadStart:(NSArray *)imageArray Success:(void (^)(NSString *filePathString))success failure:(void (^)())failure {
    return [[self alloc] initWithMultiImageUploadStart:imageArray Success:success failure:failure];
}

- (instancetype)initWithMultiImageUploadStart:(NSArray *)imageArray Success:(void (^)(NSString *filePathString))success failure:(void (^)())failure {
    if(self = [super init]) {
        [ALKeyWindow showHudInWindow];
        [self uploadImageWithArray:imageArray index:0 Success:success failure:failure];
    }
    return self;
}

- (void)uploadImageWithArray:(NSArray *)array index:(NSUInteger)index Success:(void (^)(NSString *filePathString))success failure:(void (^)())failure {
    UIImage *image = array[index];
    ALUploadApi *uploadApi = [[ALUploadApi alloc] initWithImage:image];
    
    AL_WeakSelf(self);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [uploadApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"upload Image success : %@",[uploadApi resonseImageFilePath]);
        weakSelf.filePathString = [weakSelf.filePathString stringByAppendingString:[uploadApi resonseImageFilePath]];
        if(index == array.count - 1) {
            if(success) {
                success(weakSelf.filePathString);
            }
        } else {
            weakSelf.filePathString = [weakSelf.filePathString stringByAppendingString:@","];
            [weakSelf uploadImageWithArray:array index:index+1 Success:success failure:failure];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if(failure) {
            failure();
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [ALKeyWindow hideHudInWindow];
    }];
}

- (NSString *)filePathString {
    if(!_filePathString) {
        _filePathString = @"";
    }
    return _filePathString;
}
@end

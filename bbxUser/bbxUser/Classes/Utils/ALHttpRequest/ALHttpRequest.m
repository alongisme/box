//
//  ALHttpRequest.m
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"
#import "ALLoginViewController.h"

@implementation ALHttpRequest

- (NSDictionary *)result {
    return [self.responseJSONObject objectForKey:@"result"];
}

- (NSDictionary *)data {
    return [self.responseJSONObject objectForKey:@"data"];
}

- (void)ALStartWithCompletionBlockWithSuccess:(nullable YTKRequestCompletionBlock)success
                                      failure:(nullable YTKRequestCompletionBlock)failure {
    
    [self ALCustomHudStartWithErrorBlock:nil CompletionBlockWithSuccess:success failure:failure];
}

- (void)ALHudStartWithCompletionBlockWithSuccess:(nullable YTKRequestCompletionBlock)success
                                         failure:(nullable YTKRequestCompletionBlock)failure {
    [ALKeyWindow showHudInWindow];
    [self ALStartWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [ALKeyWindow hideHudInWindow];
        if(success) {
            success(request);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [ALKeyWindow hideHudInWindow];
        if(failure) {
            failure(request);
        }
    }];
}

//带自定义Hud请求
- (void)ALCustomHudStartWithErrorBlock:(void (^)(NSString *message))errorBlock CompletionBlockWithSuccess:(nullable YTKRequestCompletionBlock)success failure:(nullable YTKRequestCompletionBlock)failure {
    double startTime = CFAbsoluteTimeGetCurrent();
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AL_WeakSelf(self);
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"---URL Request:\n url:%@\n params%@\n ---URL Response:\n%@\n ---Response time: %lf\n-----------------------------------------------------------",ALStringFormat(@"%@%@",URL_Domain,request.requestUrl),ALStringFormat(@"%@",request.requestArgument),[weakSelf switchResonseObject:request.responseJSONObject],CFAbsoluteTimeGetCurrent() - startTime);
        
        if([weakSelf.result[@"code"] integerValue] != 200) {
            if([weakSelf.result[@"code"] integerValue] == 610) {
                [[NSNotificationCenter defaultCenter] postNotificationName:ReSetToLoginModule object:@"tokenTimeOut"];
            } else if([weakSelf.result[@"code"] integerValue] == 600) {
                if([weakSelf.result[@"msg"] isEqualToString:@"fail"]) {
                    [ALKeyWindow showHudError:@"数据异常，请联系客服～"];
                    if(weakSelf.dataErrorBlock) {
                        weakSelf.dataErrorBlock();
                    }
                } else {
                    if(errorBlock) {
                        errorBlock(weakSelf.result[@"msg"]);
                    } else {
                        [ALKeyWindow showHudError:weakSelf.result[@"msg"]];
                    }
                }
            } else {
                if(failure)
                    failure(request);
            }
        } else {
            if(success) {
                success(request);
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(AL_MyAppDelegate.netWorkstatus == AFNetworkReachabilityStatusNotReachable || AL_MyAppDelegate.netWorkstatus == AFNetworkReachabilityStatusUnknown) {
            [ALKeyWindow showHudError:@"当前无网络～"];
            if(weakSelf.noNetworkBlock) {
                weakSelf.noNetworkBlock();
            }
            return;
        }
        
        if(request.error) {
            NSLog(@"---URL Request:\n url:%@\n params%@\n ---URL Response error:\n%@\n ---Response time: %lf\n-----------------------------------------------------------",ALStringFormat(@"%@%@",URL_Domain,request.requestUrl),ALStringFormat(@"%@",request.requestArgument),request.error,CFAbsoluteTimeGetCurrent() - startTime);
            if(request.error.code == -1001) {
                if(weakSelf.noNetworkBlock) {
                    weakSelf.noNetworkBlock();
                }
            }
        }
        
        if(failure) {
            failure(request);
        }
    }];
}

//返回数据类型
- (YTKResponseSerializerType)responseSerializerType {
    return YTKResponseSerializerTypeJSON;
}

//请求类型
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

//超时时间
- (NSTimeInterval)requestTimeoutInterval {
    return 30;
}

- (NSString *)switchResonseObject:(id)object {
    NSString *logString = nil;
    @try {
        NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
        logString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } @catch (NSException *exception) {
        NSString *reason = [NSString stringWithFormat:@"reason:%@",exception.reason];
        logString = [NSString stringWithFormat:@"转换失败:\n%@,\n转换终止,输出如下:\n%@",reason,self.description];
    } @finally {
        
    }
    return logString;
}

@end

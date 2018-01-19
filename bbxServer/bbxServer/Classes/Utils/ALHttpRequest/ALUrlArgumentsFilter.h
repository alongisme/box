//
//  ALUrlArgumentsFilter.h
//  AnyHelp
//
//  Created by along on 2017/7/19.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALUrlArgumentsFilter : NSObject <YTKUrlFilterProtocol>
/**
 统一添加参数

 @param arguments 参数
 @return filter
 */
+ (ALUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;
@end

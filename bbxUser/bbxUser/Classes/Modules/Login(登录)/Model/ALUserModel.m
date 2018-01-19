//
//  ALUserModel.m
//  AnyHelp
//
//  Created by along on 2017/7/19.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALUserModel.h"

@implementation ALUserModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"newMessage":@"neMessage"}];
}
@end

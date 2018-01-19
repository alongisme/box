//
//  ALUserInfoModel.m
//  bbxUser
//
//  Created by along on 2017/8/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALUserInfoModel.h"

@implementation ALUserInfoModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"neMessage" : @"newMessage"}];
}
@end

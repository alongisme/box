//
//  NSObject+ALUserDefault.m
//  HealthJiaYuan
//
//  Created by along on 2016/12/30.
//  Copyright © 2016年 along. All rights reserved.
//

#import "NSObject+ALUserDefault.h"

@implementation NSObject (NSObject_ALUserDefault)
/**
 *  保存
 *
 *  @param localKey key
 */
- (void)AL_saveLocalWithLocalKey:(NSString *)localKey {
    if([localKey isEqualToString:@""]) {
        return;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    if(data) {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:localKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

/**
 *  保存
 */
+ (void)AL_saveLocalWithObject:(id)object localKey:(NSString *)localKey {
    [object AL_saveLocalWithLocalKey:localKey];
}


/**
 *  获取data
 *
 *  @param key key
 *
 *  @return obj
 */
+ (id)AL_localObjWithKey:(NSString *)key {
    if(![key isEqualToString:@""]) {
        id data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return nil;
}

/**
 *  清除
 *
 *  @param localKey key
 */
+ (void)AL_clearDataWithLocalKey:(NSString *)localKey {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:localKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end

//
//  NSObject+ALUserDefault.h
//  HealthJiaYuan
//
//  Created by along on 2016/12/30.
//  Copyright © 2016年 along. All rights reserved.
//

@interface NSObject (NSObject_ALUserDefault)
/**
 *  保存
 *
 *  @param localKey key
 */
- (void)AL_saveLocalWithLocalKey:(NSString *)localKey;

/**
 *  保存
 */
+ (void)AL_saveLocalWithObject:(id)object localKey:(NSString *)localKey;

/**
 *  获取data
 *
 *  @param key key
 *
 *  @return obj
 */
+ (id)AL_localObjWithKey:(NSString *)key;

/**
 *  清除
 *
 *  @param localKey key
 */
+ (void)AL_clearDataWithLocalKey:(NSString *)localKey;
@end

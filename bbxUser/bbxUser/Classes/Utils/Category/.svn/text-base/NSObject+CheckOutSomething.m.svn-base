//
//  NSObject+CheckOutSomething.m
//  bbxUser
//
//  Created by along on 2017/8/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import "NSObject+CheckOutSomething.h"

@implementation NSObject (CheckOutSomething)
- (BOOL)isVaild {
    
    if(self == nil) {
        NSLog(@"object is nil");
        return NO;
    }
    
    if([self isEqual:[NSNull null]]) {
        NSLog(@"object is equal [NSNull null]");
        return NO;
    }
    
    if([self isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)self;
        if([str isEqualToString:@""]) {
            NSLog(@"object is equal [NSString class] and value == """);
            return NO;
        }
        if([str isEqualToString:@"<null>"]) {
            NSLog(@"object is equal [NSString class] and value == <null>");
            return NO;
        }
    }
    
    if([self isKindOfClass:[NSArray class]]) {
        NSArray *arr = (NSArray *)self;
        if(arr.count == 0) {
            NSLog(@"object is equal [NSArray class] and count == 0");
            return NO;
        }
    }
    
    if([self isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)self;
        if(dic.count == 0) {
            NSLog(@"object is equal [NSDictionary class] and count == 0");
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)nickNameVerify {
    if([self isKindOfClass:[NSString class]] && [self isVaild]) {
        NSString *pattern = @"^[a-zA-Z0-9\u4e00-\u9fa5]+$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
        return ![pred evaluateWithObject:pattern];
    }
    return NO;
}

- (BOOL)mobileVerifty {
    if([self isKindOfClass:[NSString class]] && [self isVaild]) {
        NSString *mobile = (NSString *)self;
        if(mobile.length == 11 && [[mobile substringToIndex:1] isEqualToString:@"1"]) {
            return YES;
        }
    }
    return NO;
}

- (int)countWord {
    
    if([self isKindOfClass:[NSString class]]) {
        NSString *strtemp = (NSString *)self;
        
        int strlength = 0;
        char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
        for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
            if (*p) {
                p++;
                strlength++;
            }
            else {
                p++;
            }
        }
        return strlength;
    }
    
    return 0;
}

+ (int)countWord:(NSString *)s {
    int i,l=0,a=0,b=0;
    NSUInteger n = [s length];
    unichar c;
    for(i=0;i<n;i++){
        c=[s characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}
@end

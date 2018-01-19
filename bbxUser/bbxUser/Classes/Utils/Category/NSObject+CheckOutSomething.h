//
//  NSObject+CheckOutSomething.h
//  bbxUser
//
//  Created by along on 2017/8/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CheckOutSomething)
- (BOOL)isVaild;

- (BOOL)nickNameVerify;

- (BOOL)mobileVerifty;

- (int)countWord;
@end

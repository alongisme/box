//
//  ALServerTagViewController.h
//  bbxUser
//
//  Created by along on 2017/9/20.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"

@protocol ALServerTagDelegate <NSObject>
- (void)getAllSelectedTag:(NSString *)tagString;
@end

@interface ALServerTagViewController : ALBaseViewController
@property (nonatomic, strong) NSArray *tagArray;
@property (nonatomic, copy) NSString *tagString;
@property (nonatomic, weak) id<ALServerTagDelegate> delegate;
@end

//
//  ALSkillTagApi.h
//  bbxServer
//
//  Created by along on 2017/8/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpRequest.h"

@interface ALSkillTagApi : ALHttpRequest
@property (nonatomic, strong) NSArray *skillTagDesArray;
- (instancetype)initSkillTagApi;
@end

//
//  ALRequestStatusView.h
//  bbxServer
//
//  Created by along on 2017/9/13.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , ALRequestStatus) {
    ALRequestStatusDataError = 0, //数据错误 code = 600
    ALRequestStatusNoNetwork = 1, //无网络 and 超时
};

@interface ALRequestStatusView : UIView
@property (nonatomic, copy) void (^reloadDataBlock)();
- (instancetype)initWithFrame:(CGRect)frame status:(ALRequestStatus)status;
@end

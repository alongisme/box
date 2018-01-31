//
//  ALWebSocketObject.h
//  bbxUser
//
//  Created by xlshi on 2018/1/30.
//  Copyright © 2018年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALWebSocketObject : NSObject
@property (nonatomic, copy) void (^didReceiveMessage)(id message);
@property (nonatomic, copy) void (^webSocketDidOpen)(void);

+ (ALWebSocketObject *)instance;
//开启连接
- (void)SRWebSocketOpen:(NSString *)orderId;

//关闭连接
- (void)SRWebSocketClose;

- (void)sendData:(id)data;
@end

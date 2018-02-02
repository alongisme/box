//
//  ALWebSocketObject.m
//  bbxUser
//
//  Created by xlshi on 2018/1/30.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALWebSocketObject.h"
#import <SocketRocket.h>

@interface ALWebSocketObject ()<SRWebSocketDelegate>
{
    int _index;
    NSTimer * heartBeat;
    NSTimeInterval reConnectTime;
}
@property (nonatomic,strong) SRWebSocket *socket;
@property (nonatomic,copy) NSString *orderId;
@end

@implementation ALWebSocketObject
+ (ALWebSocketObject *)instance {
    static ALWebSocketObject *Instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        Instance = [[ALWebSocketObject alloc] init];
    });
    return Instance;
}
//开启连接
- (void)SRWebSocketOpen:(NSString *)orderId {
    if (self.socket) {
        return;
    }
    self.orderId = orderId;
    //SRWebSocketUrlString 就是websocket的地址 写入自己后台的地址
    if([URL_Domain isEqualToString:@"http://test.biaobiaoxia.com/"]) {
        self.socket = [[SRWebSocket alloc] initWithURLRequest:
                       [NSURLRequest requestWithURL:[NSURL URLWithString:ALStringFormat(@"ws://test.biaobiaoxia.com/mobile/websocket/client?userId=%@&&socketType=orderDetailInfo&&orderId=%@",AL_MyAppDelegate.userModel.idModel.userId,orderId)]]];
    } else {
        self.socket = [[SRWebSocket alloc] initWithURLRequest:
                       [NSURLRequest requestWithURL:[NSURL URLWithString:ALStringFormat(@"ws://www.biaobiaoxia.com/mobile/websocket/client?userId=%@&&socketType=orderDetailInfo&&orderId=%@",AL_MyAppDelegate.userModel.idModel.userId,orderId)]]];
    }
    
    
    self.socket.delegate = self;   //SRWebSocketDelegate 协议
    
    [self.socket open];     //开始连接
}

//关闭连接
- (void)SRWebSocketClose {
    if (self.socket){
        [self.socket close];
        self.socket = nil;
        //断开连接时销毁心跳
        [self destoryHeartBeat];
    }
}

#pragma mark - socket delegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"连接成功，可以与服务器交流了,同时需要开启心跳");
    //每次正常连接的时候清零重连时间
    reConnectTime = 0;
    //开启心跳 心跳是发送pong的消息 我这里根据后台的要求发送data给后台
    [self initHeartBeat];
    if(_webSocketDidOpen) {
        _webSocketDidOpen();
    }
    //    [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketDidOpenNote object:nil];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
//    NSLog(@"连接失败，这里可以实现掉线自动重连，要注意以下几点");
//    NSLog(@"1.判断当前网络环境，如果断网了就不要连了，等待网络到来，在发起重连");
//    NSLog(@"2.判断调用层是否需要连接，例如用户都没在聊天界面，连接上去浪费流量");
//    NSLog(@"3.连接次数限制，如果连接失败了，重试10次左右就可以了，不然就死循环了。)");
    NSLog(@"error:%@",error);
    _socket = nil;
    //连接失败就重连
    [self reConnect];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",code,reason,wasClean);
    //断开连接 同时销毁心跳
    [self SRWebSocketClose];
    
    if(_SRWebSocketdidClose) {
        _SRWebSocketdidClose();
    }
}

/*
 该函数是接收服务器发送的pong消息，其中最后一个是接受pong消息的，
 在这里就要提一下心跳包，一般情况下建立长连接都会建立一个心跳包，
 用于每隔一段时间通知一次服务端，客户端还是在线，这个心跳包其实就是一个ping消息，
 我的理解就是建立一个定时器，每隔十秒或者十五秒向服务端发送一个ping消息，这个消息可是是空的
 */
-(void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"reply===%@",reply);
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message  {
    //收到服务器发过来的数据 这里的数据可以和后台约定一个格式 我约定的就是一个字符串 收到以后发送通知到外层 根据类型 实现不同的操作
    NSLog(@"%@",message);
    if(_didReceiveMessage) {
        _didReceiveMessage(message);
    }
    //    [[NSNotificationCenter defaultCenter] postNotificationName:kNeedPayOrderNote object:message];
}

//重连机制
- (void)reConnect
{
    [self SRWebSocketClose];
    //超过一分钟就不再重连 所以只会重连5次 2^5 = 64
    if (reConnectTime > 64) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.socket = nil;
        [self SRWebSocketOpen:self.orderId];
        NSLog(@"重连");
    });
    
    //重连时间2的指数级增长
    if (reConnectTime == 0) {
        reConnectTime = 2;
    }else{
        reConnectTime *= 2;
    }
}

//初始化心跳
- (void)initHeartBeat {
    //    dispatch_main_async_safe(^{
    [self destoryHeartBeat];
    //心跳设置为3分钟，NAT超时一般为5分钟
    heartBeat = [NSTimer scheduledTimerWithTimeInterval:3 * 60 target:self selector:@selector(heartBeatAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:heartBeat forMode:NSRunLoopCommonModes];
    //    });
}

- (void)heartBeatAction {
    [self sendData:@"heart"];
}

//取消心跳
- (void)destoryHeartBeat {
    //    dispatch_main_async_safe(^{
    if (heartBeat) {
        [heartBeat invalidate];
        heartBeat = nil;
    }
    //    });SRWebSocketOpen
}

//pingPong机制
- (void)ping{
    [self.socket sendPing:nil];
}

#define WeakSelf(ws) __weak __typeof(&*self)weakSelf = self
- (void)sendData:(id)data {
    
    WeakSelf(ws);
    dispatch_queue_t queue =  dispatch_queue_create("zy", NULL);
    
    dispatch_async(queue, ^{
        if (weakSelf.socket != nil) {
            // 只有 SR_OPEN 开启状态才能调 send 方法，不然要崩
            if (weakSelf.socket.readyState == SR_OPEN) {
                [weakSelf.socket send:data];    // 发送数据
                
            } else if (weakSelf.socket.readyState == SR_CONNECTING) {
                NSLog(@"正在连接中，重连后其他方法会去自动同步数据");
                // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
                // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
                // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
                [self reConnect];
                
            } else if (weakSelf.socket.readyState == SR_CLOSING || weakSelf.socket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                [self reConnect];
            }
        } else {
            NSLog(@"没网络，发送失败，一旦断网 socket 会被我设置 nil 的");
        }
    });
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

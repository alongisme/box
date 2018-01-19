//
//  ALShadowView.h
//  AnyHelp
//
//  Created by along on 2017/7/26.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ALShadowStyle){
    ALShadowStyleDoubleLabel = 1,
    ALShadowStyleLabelImage = 2,
    ALShadowStyleTextFiled = 3,
    ALShadowStyleSingleMineItem = 4,
    ALShadowStyleMultiMineItem = 5,
    ALShadowStyleTextView = 6,
    ALShadowStyleStartTime = 7,
    ALShadowStyleTagView = 8,
};
@interface ALShadowView : UIView

@property (nonatomic, strong) NSString *contentString;

@property (nonatomic, strong) NSString *rightImageName;

@property (nonatomic, copy) void (^clickBlock)();
@property (nonatomic, copy) void (^multiItemBlock)(NSUInteger index);
@property (nonatomic, copy) void (^rightImageClickBlock)();

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title content:(NSString *)content type:(ALShadowStyle)stype;

@property (nonatomic, assign) BOOL dontUseRedEnv;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName type:(ALShadowStyle)stype;

@property (nonatomic, assign) BOOL exchangeEnable;
@property (nonatomic, copy) NSString *textString;
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder type:(ALShadowStyle)stype;
- (void)clearTextFiledString;

- (instancetype)initWithFrame:(CGRect)frame leftImageName:(NSString *)leftImageName title:(NSString *)title type:(ALShadowStyle)stype;

@property (nonatomic, assign) BOOL unreadMessage;
- (instancetype)initWithFrame:(CGRect)frame leftImageArray:(NSArray *)leftImageArray titleArray:(NSArray *)titleArray type:(ALShadowStyle)stype;

@property (nonatomic, strong) NSString *headString;
@property (nonatomic, strong) NSString *nickName;
- (instancetype)initWithAccount:(CGRect)frame;

- (instancetype)initWithSystemSetting:(CGRect)frame;

- (instancetype)initWithButton:(CGRect)frame title:(NSString *)title;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray contentArray:(NSArray *)contentArray rightView:(BOOL)rightView;

@property (nonatomic, assign) BOOL submitEnable;
- (instancetype)initWithTextView:(CGRect)frame placeholder:(NSString *)placeholder type:(ALShadowStyle)stype;
@end

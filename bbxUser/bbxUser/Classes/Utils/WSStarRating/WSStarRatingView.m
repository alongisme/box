//
//  WSStarRatingView.m
//  StarRating
//
//  Created by iMac on 16/12/27.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "WSStarRatingView.h"


@interface WSStarRatingView ()

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;

@property (nonatomic, assign) NSUInteger startWidth;
@property (nonatomic, assign) CGFloat margin;
@end

@implementation WSStarRatingView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfStar:kNUMBER_OF_STAR];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _numberOfStar = kNUMBER_OF_STAR;
    [self commonInit];
}

/**
 *  初始化TQStarRatingView
 *
 *  @param frame  Rectangles
 *  @param number 星星个数
 *
 *  @return TQStarRatingViewObject
 */
- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStar = number;
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    if(_numberOfStar == 789) {
        self.starBackgroundView = [self buidlStarViewWithImageName:@"wode-Star-g.png"];
        self.starForegroundView = [self buidlStarViewWithImageName:@"wode-Star-y.png"];
    } else if(_numberOfStar == 456){
        self.starBackgroundView = [self buidlStarViewWithImageName:@"pingjia-Star-nor.png"];
        self.starForegroundView = [self buidlStarViewWithImageName:@"pingjia-Star-blue.png"];
    } else {
        self.starBackgroundView = [self buidlStarViewWithImageName:@"pingjialiebiao-star-g.png"];
        self.starForegroundView = [self buidlStarViewWithImageName:@"pingjialiebiao-star-b.png"];
    }
    [self addSubview:self.starBackgroundView];
    [self addSubview:self.starForegroundView];
}

#pragma mark -
#pragma mark - Set Score

/**
 *  设置控件分数
 *
 *  @param score     分数，必须在 0 － 1 之间
 *  @param isAnimate 是否启用动画
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate
{
    [self setScore:score withAnimation:isAnimate completion:^(BOOL finished){}];
}

/**
 *  设置控件分数
 *
 *  @param score      分数，必须在 0 － 1 之间
 *  @param isAnimate  是否启用动画
 *  @param completion 动画完成block
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion
{
//    NSAssert((score >= 0.0)&&(score <= 1.0), @"score must be between 0 and 1");
    
    if (score < 0){
        score = 0;
    }
    
    if (score > 5){
        score = 5;
    }

    CGFloat value = score * 2;
    
    if(isAnimate){
        __weak __typeof(self)weakSelf = self;
        
        [UIView animateWithDuration:0.2 animations:^{
            [weakSelf changeStarForegroundViewWithvalue:value];
        } completion:^(BOOL finished){
            if (completion){
                completion(finished);
            }
        }];
    } else {
        [self changeStarForegroundViewWithvalue:value];
    }
}

#pragma mark -
#pragma mark - Touche Event

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if(CGRectContainsPoint(rect,point)){
        [self changeStarForegroundViewWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak __typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf changeStarForegroundViewWithPoint:point];
    }];
}

#pragma mark -
#pragma mark - Buidl Star View

/**
 *  通过图片构建星星视图
 *
 *  @param imageName 图片名称
 *
 *  @return 星星视图
 */
- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGFloat margin = 2;
    if(_numberOfStar == 789) {
        margin = 2;
    } else if(_numberOfStar == 456){
        margin = 11.5;
    } else {
        margin = 2;
    }
    
    self.margin = margin;
    
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    self.startWidth = (frame.size.width - 4 * margin) / kNUMBER_OF_STAR;
    
    view.clipsToBounds = YES;
    for (int i = 0; i < kNUMBER_OF_STAR; i ++){
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * (frame.size.width - 4 * margin) / kNUMBER_OF_STAR + i * margin, 0, self.startWidth, frame.size.height);
        [view addSubview:imageView];
    }
    return view;
}

#pragma mark -
#pragma mark - Change Star Foreground With Point

- (void)changeStarForegroundViewWithvalue:(int)formatScore {
    CGPoint p = CGPointMake(0, 0);
    
    if(formatScore == 1) {
        p.x = self.startWidth / 2;
    } else if(formatScore == 2) {
        p.x = self.startWidth;
    } else if(formatScore == 3) {
        p.x = self.startWidth * 2 + self.margin + self.startWidth / 2;
    } else if (formatScore == 4) {
        p.x = self.startWidth * 2 + self.margin;
    } else if (formatScore == 5) {
        p.x = self.frame.size.width / 2 + self.startWidth / 2 + self.startWidth / 2;
    } else if (formatScore == 6) {
        p.x = self.frame.size.width / 2 + self.startWidth / 2;
    } else if (formatScore == 7) {
        p.x = self.frame.size.width - self.startWidth - self.startWidth / 2;
    } else if (formatScore == 8) {
        p.x = self.frame.size.width - self.startWidth;
    } else if (formatScore == 9) {
        p.x = self.frame.size.width - + self.startWidth / 2;
    } else if (formatScore == 10) {
        p.x = self.frame.size.width;
    } else {
        p.x = 0;
    }
    
    self.starForegroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)]){
        if(formatScore % 2 == 0) {
            [self.delegate starRatingView:self score:formatScore / 2];
        } else {
            [self.delegate starRatingView:self score:formatScore / 2 + 1];
        }
    }
}

/**
 *  通过坐标改变前景视图
 *
 *  @param point 坐标
 */
- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    
    if (p.x < 0){
        p.x = 0;
    }
    
    if (p.x > self.frame.size.width){
        p.x = self.frame.size.width;
    }

    int formatScore = ceil(p.x / self.frame.size.width * 10);
    
    if(formatScore == 1) {
        p.x = self.startWidth;
    } else if(formatScore == 2) {
        p.x = self.startWidth;
    } else if(formatScore == 3) {
        p.x = self.startWidth * 2 + self.margin;
    } else if (formatScore == 4) {
        p.x = self.startWidth * 2 + self.margin;
    } else if (formatScore == 5) {
        p.x = self.frame.size.width / 2 + self.startWidth / 2;
    } else if (formatScore == 6) {
        p.x = self.frame.size.width / 2 + self.startWidth / 2;
    } else if (formatScore == 7) {
        p.x = self.frame.size.width - self.startWidth;
    } else if (formatScore == 8) {
        p.x = self.frame.size.width - self.startWidth;
    } else if (formatScore == 9) {
        p.x = self.frame.size.width;
    } else if (formatScore == 10) {
        p.x = self.frame.size.width;
    } else {
        p.x = 0;
    }
    
    self.starForegroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)]){
        if(formatScore % 2 == 0) {
            [self.delegate starRatingView:self score:formatScore / 2];
        } else {
            [self.delegate starRatingView:self score:formatScore / 2 + 1];
        }
    }
}

@end

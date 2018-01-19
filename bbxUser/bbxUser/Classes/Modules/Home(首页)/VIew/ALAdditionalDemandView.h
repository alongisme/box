//
//  ALAdditionalDemandView.h
//  bbxUser
//
//  Created by xlshi on 2017/10/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClickedLabelView.h"

@interface ALAdditionalDemandView : UIView
@property (nonatomic, strong) ClickedLabelView *clickedLabelView;

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;

- (NSString *)getAllAdditionalDemand;
@end

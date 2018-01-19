//
//  ALBaseViewController.h
//  AnyHelp
//
//  Created by along on 2017/7/18.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALRequestStatusView.h"

@interface ALBaseViewController : UIViewController

/**
 导航栏按钮

 @param imageName 图片名称
 @param selector 事件
 @return item
 */
- (UIBarButtonItem *)createButtonItemWithImageName:(NSString *)imageName selector:(SEL)selector;

- (void)showRequestStauts:(ALRequestStatus)status;

- (void)removeRequestStatusView;

- (void)reloadData;
@end

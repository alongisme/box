//
//  ALNoReusltTableView.h
//  bbxUser
//
//  Created by along on 2017/8/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALOrderListModel.h"

@protocol ALNoResultTableViewDelegate <NSObject>

- (void)didActionButtonSelectedAtIndexPath:(NSUInteger)indexPath model:(ALOrderModel *)model type:(NSUInteger)type;

- (void)didSelectedAtIndexPath:(NSUInteger)indexPath model:(ALOrderModel *)model;

- (void)emptyDataAndReloadDataSource;
@end

@interface ALNoReusltTableView : UIView

@property (nonatomic, copy) MJRefreshComponentRefreshingBlock footRefreshBlock;
@property (nonatomic, copy) MJRefreshComponentRefreshingBlock headRefreshBlock;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isNoResult;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) id <ALNoResultTableViewDelegate> delegate;
@end

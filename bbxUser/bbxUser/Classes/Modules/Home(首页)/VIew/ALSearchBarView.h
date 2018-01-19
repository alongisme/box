//
//  ALSearchBarView.h
//  AnyHelp
//
//  Created by along on 2017/7/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALSearchResultModel.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@protocol ALSearchResultDelegate <NSObject>
- (void)searchResultWithKeyWord:(NSString *)keyWord;
- (void)startNewSearch;
@end

@interface ALSearchBarView : UIView
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) BMKPoiSearch *poiSearch;
@property (nonatomic, weak) id<ALSearchResultDelegate> resultDelegate;
@end

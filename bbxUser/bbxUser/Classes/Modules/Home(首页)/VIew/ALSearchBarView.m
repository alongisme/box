//
//  ALSearchBarView.m
//  AnyHelp
//
//  Created by along on 2017/7/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALSearchBarView.h"

@interface ALSearchBarView () <UISearchBarDelegate>
@end

@implementation ALSearchBarView

- (instancetype)init {
    if(self = [super init]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.layer.cornerRadius = self.bounds.size.height / 2;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithRGBA:ALThemeColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.searchBar.frame = self.bounds;
}

#pragma mark UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if(searchBar.text.length > 0) {
        if([self.resultDelegate respondsToSelector:@selector(startNewSearch)]) {
            [self.resultDelegate startNewSearch];
        }
        if([self.resultDelegate respondsToSelector:@selector(searchResultWithKeyWord:)]) {
            [self.resultDelegate searchResultWithKeyWord:searchBar.text];
        }
    }
}

#pragma mark lazy load
- (UISearchBar *)searchBar {
    if(!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"小区/学校/银行等";
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.backgroundImage = [[UIImage alloc] init];
        _searchBar.searchTextPositionAdjustment = UIOffsetMake(10, 0);
        
        for (UIView* subview  in [_searchBar.subviews firstObject].subviews) {
            if ([subview isKindOfClass:[UITextField class]]) {
                
                UITextField *searchField = (UITextField*)subview;
                UIImageView *leftIV = [[UIImageView alloc] init];
                leftIV.image = [UIImage imageNamed:@"icon_search_nor"];
                leftIV.frame = CGRectMake(0, 0, 24, 24);
                searchField.leftView = leftIV;
                
                // 删除searchBar输入框的背景
                [searchField setValue:ALThemeFont(14) forKeyPath:@"_placeholderLabel.Font"];
                searchField.tintColor = [UIColor colorWithRGBA:ALThemeColor];
                searchField.leftViewMode = UITextFieldViewModeAlways;
                [searchField setBackground:nil];
                [searchField setBorderStyle:UITextBorderStyleNone];
                searchField.backgroundColor = [UIColor whiteColor];
                // 设置圆角
                searchField.layer.cornerRadius = self.bounds.size.height / 2;
                searchField.layer.masksToBounds = YES;
                break;
            }
        }
        [self addSubview:_searchBar];
    }
    return _searchBar;
}

- (BMKPoiSearch *)poiSearch {
    if(!_poiSearch) {
        _poiSearch = [[BMKPoiSearch alloc] init];
    }
    return _poiSearch;
}
@end

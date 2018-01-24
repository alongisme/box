//
//  ALChoseSeverView.m
//  bbxUser
//
//  Created by along on 2017/10/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALChoseSeverView.h"
#import "ALChoseSeverCollectionViewCell.h"
#import "ALOptionListModel.h"

@interface ALChoseSeverView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ALChoseSeverView

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array {
    if(self = [super initWithFrame:frame]) {
        
        self.dataArray = array;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(252/2.0, 288/2.0);
        flowLayout.minimumLineSpacing = 27;
        
        if(array.count == 1){
            flowLayout.sectionInset = UIEdgeInsetsMake(0, (ALScreenWidth - 252/2.0) / 2.0, 0, 11);
        }else if(array.count == 2) {
            flowLayout.sectionInset = UIEdgeInsetsMake(0, (ALScreenWidth - 2 * 252/2.0 - 27) / 2.0, 0, 11);
        } else if(array.count == 3) {
            flowLayout.sectionInset = UIEdgeInsetsMake(0, (ALScreenWidth - 3 * 252/2.0 - 27 * 2) / 2.0, 0, 11);
        } else {
            flowLayout.sectionInset = UIEdgeInsetsMake(0, 11, 0, 11);
        }
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.bounces = NO;
        [self addSubview:collectionView];
        [collectionView registerClass:[ALChoseSeverCollectionViewCell class] forCellWithReuseIdentifier:@"ALChoseSeverIdentifier"];
        self.collectionView = collectionView;
        
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@150);
            make.top.equalTo(@10);
        }];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ALChoseSeverCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ALChoseSeverIdentifier" forIndexPath:indexPath];
    cell.optionListModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (unsigned int i = 0; i < self.dataArray.count; i++) {
        ALOptionListModel *optionListModel = self.dataArray[i];
        if(i == indexPath.row) {
            optionListModel.selected = YES;
            self.currentLength = optionListModel.serviceLength;
        } else {
            optionListModel.selected = NO;
        }
    }
    [collectionView reloadData];
    
    if(_didSelectedBlock) {
        _didSelectedBlock(indexPath.row);
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
}
@end

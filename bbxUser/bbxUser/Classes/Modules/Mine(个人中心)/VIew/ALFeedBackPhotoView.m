//
//  ALFeedBackPhotoView.m
//  bbxUser
//
//  Created by along on 2017/8/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALFeedBackPhotoView.h"
#import "ALFeedBackPhotoCollectionViewCell.h"
#import "ALImagePickerController.h"

@interface ALFeedBackPhotoView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ALFeedBackPhotoView

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
    self.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[ALFeedBackPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"ALFeedBackPhotoIdentifier"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count == 6 ? self.dataArray.count - 1 : self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ALFeedBackPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ALFeedBackPhotoIdentifier" forIndexPath:indexPath];
    cell.img = self.dataArray[indexPath.row];
    if(indexPath.row != self.dataArray.count - 1) {
        AL_WeakSelf(self);
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [ALAlertViewController showAlertOnlyCancelButton:weakSelf.delegate title:nil message:nil style:UIAlertControllerStyleActionSheet alertArray:@[@"删除图片",@"手机相册"] clickBlock:^(int index) {
                if(index == 0) {
                    [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
                    [weakSelf.collectionView reloadData];
                } else {
                    [weakSelf openImagePickerController:NO currentIndex:indexPath.row];
                }
            }];
        }];
        [cell addGestureRecognizer:longPressGesture];
    }
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.dataArray.count >= 6 && indexPath.row == self.dataArray.count - 1) {
        [ALKeyWindow showHudError:@"最多5张图片～"];
        return;
    }
    
    if(indexPath.row == self.dataArray.count - 1) {
        [self openImagePickerController:YES currentIndex:0];
    }
}

//打开相册加载图片刷新
- (void)openImagePickerController:(BOOL)isInsert currentIndex:(NSUInteger)currendIndex {
    [ALImagePickerController ImagePickerWithDelegate:self.delegate SourceType:UIImagePickerControllerSourceTypePhotoLibrary Edit:NO choseImageBlcok:^(UIImage *image, NSDictionary *info) {
        if(isInsert) {
            [self.dataArray insertObject:image atIndex:self.dataArray.count - 1];
        } else {
            [self.dataArray replaceObjectAtIndex:currendIndex withObject:image];
        }
        [self.collectionView reloadData];
    } cannelBlock:nil];
}

#pragma mark lazy load
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake((ALScreenWidth - 28 - 20) / 5, (ALScreenWidth - 28 - 20) / 5);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    if(!_dataArray) {
        _dataArray = [NSMutableArray array];
        UIImage *img = [UIImage imageNamed:@"icon_addPhoto"];
        [_dataArray addObject:img];
    }
    return _dataArray;
}
@end

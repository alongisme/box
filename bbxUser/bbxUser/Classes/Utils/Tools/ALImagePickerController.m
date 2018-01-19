//
//  ALImagePickerController.m
//  HealthJiaYuan
//
//  Created by along on 2017/2/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ALImagePickerController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,copy) void (^choseImage)(UIImage *image, NSDictionary *info);
@property (nonatomic,copy) void (^cannel)();
@end

@implementation ALImagePickerController

- (instancetype)initWithDelegate:(UIViewController *)delegate SourceType:(UIImagePickerControllerSourceType)soureType Edit:(BOOL)edit choseImageBlcok:(void (^)(UIImage *image,NSDictionary *info))choseImageBlock cannelBlock:(void (^)())cannelBlock;{
    if(self = [super init]) {
        self.choseImage = choseImageBlock;
        self.cannel = cannelBlock;
        self.allowsEditing = edit;
        self.delegate = self;
        // 判断数据来源是否可用
        if([UIImagePickerController isSourceTypeAvailable:soureType]) {
            // 设置数据来源
            self.sourceType = soureType;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate presentViewController:self animated:YES completion:nil];
        });
    }
    return self;
}

+ (instancetype)ImagePickerWithDelegate:(UIViewController *)delegate SourceType:(UIImagePickerControllerSourceType)soureType Edit:(BOOL)edit choseImageBlcok:(void (^)(UIImage *image,NSDictionary *info))choseImageBlock cannelBlock:(void (^)())cannelBlock {
    return [[self alloc] initWithDelegate:delegate SourceType:soureType Edit:edit choseImageBlcok:choseImageBlock cannelBlock:cannelBlock];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if(_cannel) {
        _cannel();
    }
    // 退出当前界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 选择完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    __weak typeof(self) weakself = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        if(weakself.choseImage) {
            weakself.choseImage(image,info);
        }
    }];
}
@end

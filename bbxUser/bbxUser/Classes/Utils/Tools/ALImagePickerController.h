//
//  ALImagePickerController.h
//  HealthJiaYuan
//
//  Created by along on 2017/2/7.
//  Copyright © 2017年 along. All rights reserved.
//

@interface ALImagePickerController : UIImagePickerController
- (instancetype)initWithDelegate:(UIViewController *)delegate SourceType:(UIImagePickerControllerSourceType)soureType Edit:(BOOL)edit choseImageBlcok:(void (^)(UIImage *image,NSDictionary *info))choseImageBlock cannelBlock:(void (^)())cannelBlock;

+ (instancetype)ImagePickerWithDelegate:(UIViewController *)delegate SourceType:(UIImagePickerControllerSourceType)soureType Edit:(BOOL)edit choseImageBlcok:(void (^)(UIImage *image,NSDictionary *info))choseImageBlock cannelBlock:(void (^)())cannelBlock;

@end

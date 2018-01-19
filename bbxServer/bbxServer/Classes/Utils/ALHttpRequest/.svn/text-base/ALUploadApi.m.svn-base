//
//  ALUploadApi.m
//  bbxUser
//
//  Created by along on 2017/8/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALUploadApi.h"

@implementation ALUploadApi
{
    UIImage *_image;
}

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_UpFile;
}

- (YTKResponseSerializerType)responseSerializerType {
    return YTKResponseSerializerTypeJSON;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.1);
        NSString *name = @"jpg";
        NSString *formKey = @"file";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

- (NSString *)resonseImageFilePath {
    return self.responseJSONObject[@"data"][@"filePath"];
}
@end

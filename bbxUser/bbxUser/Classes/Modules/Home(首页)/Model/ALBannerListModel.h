//
//  ALBannerListModel.h
//  bbxUser
//
//  Created by xlshi on 2017/11/10.
//  Copyright © 2017年 along. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ALBannerListModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *picUrl;
@property (nonatomic, copy) NSString<Optional> *bannerType;
@property (nonatomic, copy) NSString<Optional> *bannerLink;
@property (nonatomic, copy) NSString<Optional> *bannerId;
@end

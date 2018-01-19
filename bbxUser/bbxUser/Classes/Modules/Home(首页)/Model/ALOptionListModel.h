//
//  ALOptionListModel.h
//  bbxUser
//
//  Created by xlshi on 2017/10/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ALOptionListModel : JSONModel
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, copy) NSString *serviceLength;
@property (nonatomic, copy) NSString *limitPrice;
@property (nonatomic, copy) NSString *orglPrice;
@end

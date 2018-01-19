//
//  ALUserInfoModel.h
//  bbxUser
//
//  Created by along on 2017/8/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ALSkillTagListModel
@end

@interface ALUserInfoModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *icon;
@property (nonatomic, copy) NSString<Optional> *nickName;
@property (nonatomic, copy) NSString<Optional> *phone;
@property (nonatomic, copy) NSNumber<Optional> *neMessage;
@property (nonatomic, copy) NSNumber<Optional> *skillTagNum;
@property (nonatomic, copy) NSString<Optional> *avgRank;
@property (nonatomic, strong) NSNumber<Optional> *doOrderNum;
@property (nonatomic, strong) NSArray<Optional,ALSkillTagListModel> *skillTagList;
@end

@interface ALSkillTagListModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *skillTagDes;
@end

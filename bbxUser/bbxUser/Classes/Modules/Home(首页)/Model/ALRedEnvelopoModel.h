//
//  ALRedEnvelopoModel.h
//  bbxUser
//
//  Created by along on 2017/8/3.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALRedEnvelopoModel : JSONModel
@property (nonatomic, strong) NSNumber<Ignore> *index;
@property (nonatomic, strong) NSNumber<Ignore> *isSelected;

@property (nonatomic, copy) NSString<Optional> *couponId;
@property (nonatomic, copy) NSString<Optional> *discount;
@property (nonatomic, copy) NSString<Optional> *expireTimeDes;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *limitPrice;
@end

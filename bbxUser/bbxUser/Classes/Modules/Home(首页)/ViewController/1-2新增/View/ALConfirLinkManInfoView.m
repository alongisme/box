//
//  ALConfirLinkManInfoView.m
//  bbxUser
//
//  Created by xlshi on 2018/1/22.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALConfirLinkManInfoView.h"

@interface ALConfirLinkManInfoView()
@property (nonatomic, strong) UIView *vlineView;
@property (nonatomic, strong) ALLabel *linkManInfoLab;

@property (nonatomic, strong) ALLabel *serverNumLab;
@property (nonatomic, strong) ALLabel *serverNum;
@property (nonatomic, strong) ALLabel *startTimeLab;
@property (nonatomic, strong) ALLabel *startTime;
@property (nonatomic, strong) ALLabel *telephoneLab;
@property (nonatomic, strong) ALLabel *telephone;
@property (nonatomic, strong) ALLabel *linkManLab;
@property (nonatomic, strong) ALLabel *linkMan;

@property (nonatomic, strong) ALOrderModel *model;
@end

@implementation ALConfirLinkManInfoView

- (instancetype)initWithFrame:(CGRect)frame orderModel:(ALOrderModel *)model {
    if(self = [super initWithFrame:frame]) {
        
        self.model = model;
        
        [self.vlineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(@15);
            make.size.mas_equalTo(CGSizeMake(4, 16));
        }];
        
        [self.linkManInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.vlineView);
            make.left.equalTo(self.vlineView.mas_right).offset(6);
        }];
        
        UIView *oneLine = [self lineView];
        [oneLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.height.equalTo(@1);
            make.top.equalTo(self.vlineView.mas_bottom).offset(7);
        }];
        
        [self.serverNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(oneLine.mas_bottom).offset(16);
        }];
        
        [self.serverNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.serverNumLab);
            make.right.equalTo(@-14);
        }];
        
        UIView *twoLine = [self lineView];
        [twoLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.height.equalTo(@1);
            make.top.equalTo(self.serverNum.mas_bottom).offset(10);
        }];
        
        [self.startTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(twoLine.mas_bottom).offset(16);
        }];
        
        [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.startTimeLab);
            make.right.equalTo(@-14);
        }];
        
        UIView *threeLine = [self lineView];
        [threeLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.height.equalTo(@1);
            make.top.equalTo(self.startTime.mas_bottom).offset(10);
        }];
        
        //
        [self.telephoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(threeLine.mas_bottom).offset(16);
        }];
        
        [self.telephone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.telephoneLab);
            make.right.equalTo(@-14);
        }];
        
        UIView *fourLine = [self lineView];
        [fourLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.height.equalTo(@1);
            make.top.equalTo(self.telephone.mas_bottom).offset(10);
        }];
        
        //
        [self.linkManLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(fourLine.mas_bottom).offset(16);
        }];
        
        [self.linkMan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.linkManLab);
            make.right.equalTo(@-14);
        }];
    }
    return self;
}

- (UIView *)lineView {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRGBA:0xF5F6FAFF];
    [self addSubview:lineView];
    return lineView;
}

#pragma mark lazy load
- (UIView *)vlineView {
    if(!_vlineView) {
        _vlineView = [UIView new];
        _vlineView.backgroundColor = [UIColor colorWithRGBA:ALThemeColor];
        [self addSubview:_vlineView];
    }
    return _vlineView;
}

- (ALLabel *)linkManInfoLab {
    if(!_linkManInfoLab) {
        _linkManInfoLab = [[ALLabel alloc] init];
        _linkManInfoLab.font = ALThemeFont(13);
        _linkManInfoLab.text = @"联系人信息";
        [self addSubview:_linkManInfoLab];
    }
    return _linkManInfoLab;
}

- (ALLabel *)serverNumLab {
    if(!_serverNumLab) {
        _serverNumLab = [[ALLabel alloc] init];
        _serverNumLab.font = ALThemeFont(13);
        _serverNumLab.text = @"服务人数";
        [self addSubview:_serverNumLab];
    }
    return _serverNumLab;
}

- (ALLabel *)serverNum {
    if(!_serverNum) {
        _serverNum = [[ALLabel alloc] init];
        _serverNum.font = ALThemeFont(15);
        _serverNum.text = _model.serviceLength;
        _serverNum.textColor = [UIColor colorWithRGB:0x333333];
        [self addSubview:_serverNum];
    }
    return _serverNum;
}

- (ALLabel *)startTimeLab {
    if(!_startTimeLab) {
        _startTimeLab = [[ALLabel alloc] init];
        _startTimeLab.font = ALThemeFont(13);
        _startTimeLab.text = @"开始时间";
        [self addSubview:_startTimeLab];
    }
    return _startTimeLab;
}

- (ALLabel *)startTime {
    if(!_startTime) {
        _startTime = [[ALLabel alloc] init];
        _startTime.font = ALThemeFont(15);
        _startTime.text = _model.preStartTime;
        _startTime.textColor = [UIColor colorWithRGB:0x333333];
        [self addSubview:_startTime];
    }
    return _startTime;
}

- (ALLabel *)telephoneLab {
    if(!_telephoneLab) {
        _telephoneLab = [[ALLabel alloc] init];
        _telephoneLab.font = ALThemeFont(13);
        _telephoneLab.text = @"联系电话";
        [self addSubview:_telephoneLab];
    }
    return _telephoneLab;
}

- (ALLabel *)telephone {
    if(!_telephone) {
        _telephone = [[ALLabel alloc] init];
        _telephone.font = ALThemeFont(15);
        _telephone.text = _model.contactsPhone;
        _telephone.textColor = [UIColor colorWithRGB:0x333333];
        [self addSubview:_telephone];
    }
    return _telephone;
}

- (ALLabel *)linkManLab {
    if(!_linkManLab) {
        _linkManLab = [[ALLabel alloc] init];
        _linkManLab.font = ALThemeFont(13);
        _linkManLab.text = @"联系人";
        [self addSubview:_linkManLab];
    }
    return _linkManLab;
}

- (ALLabel *)linkMan {
    if(!_linkMan) {
        _linkMan = [[ALLabel alloc] init];
        _linkMan.font = ALThemeFont(15);
        _linkMan.text = _model.contactsName;
        _linkMan.textColor = [UIColor colorWithRGB:0x333333];
        [self addSubview:_linkMan];
    }
    return _linkMan;
}
@end

//
//  ALNewSecurityLListView.m
//  bbxUser
//
//  Created by xlshi on 2018/1/24.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALNewSecurityLListView.h"
#import "WSStarRatingView.h"

@implementation ALNewSecurityLListView

- (instancetype)initWithFrame:(CGRect)frame onlyOne:(ALSecurityModel *)model {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initSecurityListOnlyOne:model];
    }
    return self;
}

- (void)initSecurityListOnlyOne:(ALSecurityModel *)securityModel {
    
    AL_WeakSelf(self);
    
    //每一行的view
    UIView *itemView = [[UIView alloc] init];
    [self addSubview:itemView];
    
    UIImageView *headIV = [[UIImageView alloc] init];
    headIV.contentMode = UIViewContentModeScaleAspectFill;
    headIV.userInteractionEnabled = YES;
    headIV.layer.masksToBounds = YES;
    headIV.layer.cornerRadius = 52/2.0;
    [itemView addSubview:headIV];
    
    [headIV sd_setImageWithURL:[NSURL URLWithString:ALStringFormat(@"%@%@",URL_Image,[NSURL URLWithString:securityModel.icon])] placeholderImage:[UIImage imageNamed:@"touxiang_weidenglu"]];
    [headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(itemView);
        make.left.equalTo(@15);
        make.size.mas_equalTo(CGSizeMake(52, 52));
    }];
    
    //添加点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        if(weakSelf.itemDidSelectedAtIndex) {
            weakSelf.itemDidSelectedAtIndex(0);
        }
    }];
    
    [headIV addGestureRecognizer:tapGesture];
    
    ALLabel *nameLab = [[ALLabel alloc] init];
    nameLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
    nameLab.text = securityModel.realName;
    nameLab.font = ALThemeFont(16);
    [itemView addSubview:nameLab];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headIV.mas_right).offset(25);
        make.top.equalTo(headIV);
    }];
    
    UIImageView *leadIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:securityModel.isLeader.boolValue ? @"icon_leader" : @"icon_member"]];
    [itemView addSubview:leadIV];
    
    [leadIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLab);
        make.left.equalTo(nameLab.mas_right).offset(5);
    }];
    
    [self layoutIfNeeded];
    
    WSStarRatingView *startRatingView = [[WSStarRatingView alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLab.frame), 94/2.0 - 3, 78, 14) numberOfStar:5];
    [itemView addSubview:startRatingView];
    startRatingView.userInteractionEnabled = NO;
    [startRatingView setScore:[securityModel.avgRank floatValue] withAnimation:NO];
    
    ALLabel *doOrderNumLab = [[ALLabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLab.frame), CGRectGetMaxY(startRatingView.frame) + 7 , ALScreenWidth - 28 - CGRectGetMaxX(startRatingView.frame) - 20 - 10, 14)];
    doOrderNumLab.textAlignment = NSTextAlignmentLeft;
    doOrderNumLab.text = ALStringFormat(@"接单数：%@",[securityModel.doOrderNum isVaild] ? securityModel.doOrderNum : @"0");
    doOrderNumLab.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
    [itemView addSubview:doOrderNumLab];
    
    UIButton *callSecurityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [callSecurityBtn setTitle:@"联系镖师" forState:UIControlStateNormal];
    callSecurityBtn.titleLabel.font = ALThemeFont(15);
    callSecurityBtn.backgroundColor = [UIColor colorWithRGBA:ALThemeColor];
    [callSecurityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    callSecurityBtn.layer.masksToBounds = YES;
    callSecurityBtn.layer.cornerRadius = 16;
    [itemView addSubview:callSecurityBtn];
    
    [callSecurityBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ALStringFormat(@"tel://%@",securityModel.phone)]];
        });
    }];
    
    [callSecurityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(@-10);
        CGFloat wid = [@"联系镖师" widthForFont:ALThemeFont(15)];
        make.width.equalTo(@(wid + 40));
        make.height.equalTo(@32);
    }];
    
    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(@0);
    }];
}

@end

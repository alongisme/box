//
//  ALNewManySecutityListView.m
//  bbxUser
//
//  Created by xlshi on 2018/1/25.
//  Copyright © 2018年 along. All rights reserved.
//

#import "ALNewManySecutityListView.h"
#import "WSStarRatingView.h"

@interface ALNewManySecutityListView()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) ALLabel *label;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) NSArray *arr;
@end

@implementation ALNewManySecutityListView

- (instancetype)initWithFrame:(CGRect)frame arr:(NSArray *)arr {
    if(self = [super initWithFrame:frame]) {
        UIView *lastView = nil;
        self.arr = arr;
        _bgView = [[UIView alloc] init];
        _bgView.clipsToBounds = YES;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:_bgView];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(@0);
            make.height.equalTo(@(85 + 45));
        }];
        
        for (unsigned int i = 0; i < arr.count; i++) {
            AL_WeakSelf(self);
            
            ALSecurityModel *securityModel = arr[i];
            
            //每一行的view
            UIView *itemView = [[UIView alloc] init];
            itemView.backgroundColor = AL_RandomColor;
            [_bgView addSubview:itemView];
            
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
            
            [self.bgView layoutIfNeeded];
            
            WSStarRatingView *startRatingView = [[WSStarRatingView alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLab.frame), 94/2.0 - 5, 78, 14) numberOfStar:5];
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
                make.centerY.equalTo(itemView);
                make.right.equalTo(@-10);
                CGFloat wid = [@"联系镖师" widthForFont:ALThemeFont(15)];
                make.width.equalTo(@(wid + 40));
                make.height.equalTo(@32);
            }];
            
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                if(lastView) {
                    make.top.equalTo(lastView.mas_bottom);
                } else {
                    make.top.equalTo(@0);
                }
                make.left.right.equalTo(@0);
                make.height.equalTo(@85);
            }];
            
            lastView = itemView;
            
            if(i == arr.count - 1) {
                _bottomView = [[UIView alloc] init];
                _bottomView.backgroundColor = AL_RandomColor;
                _bottomView.userInteractionEnabled = YES;
                [self addSubview:_bottomView];
                
                [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@45);
                    make.left.right.equalTo(@0);
                    make.top.equalTo(@85);
                }];
                
                _label = [[ALLabel alloc] init];
                _label.text = @"下拉查看更多镖师";
                _label.textColor = [UIColor colorWithRGB:0x999999];
                [self.bottomView addSubview:_label];
                
                [_label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(self.bottomView);
                }];
                
                _iv = [[UIImageView alloc] init];
                UIImage *img = [UIImage imageNamed:@"dy_Right"];
                _iv.image = [img imageByRotateRight90];
                [self.bottomView addSubview:_iv];
                
                [_iv mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.bottomView);
                    make.right.equalTo(self.label.mas_left).offset(-10);
                }];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookManyAction)];
                
                [self.bottomView addGestureRecognizer:tap];
                
            }
        }
    }
    return self;
}

- (void)lookManyAction {
    if([_label.text isEqualToString:@"下拉查看更多镖师"]) {
        if(self.itemDidSelectedAtIndex) {
            self.itemDidSelectedAtIndex(0);
        }
        [UIView animateWithDuration:0.3 animations:^{
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(self.arr.count * 85 + 45));
            }];
            
            [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(self.arr.count * 85));
            }];
            
            [self layoutIfNeeded];
        }];
        _label.text = @"上拉收起镖师列表";
        UIImage *img = [UIImage imageNamed:@"dy_Right"];
        _iv.image = [img imageByRotateLeft90];
    } else {
        if(self.itemDidSelectedAtIndex) {
            self.itemDidSelectedAtIndex(1);
        }
        [UIView animateWithDuration:0.3 animations:^{
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@85);
            }];
            
            [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(85));
            }];
            [self layoutIfNeeded];
        }];
        
        _label.text = @"下拉查看更多镖师";
        UIImage *img = [UIImage imageNamed:@"dy_Right"];
        _iv.image = [img imageByRotateRight90];
    }
}

@end

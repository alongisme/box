//
//  ALAddressView.m
//  AnyHelp
//
//  Created by along on 2017/7/26.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAddressView.h"

@interface ALAddressView ()
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) ALLabel *serverAddressLab;
@property (nonatomic, strong) UIImageView *rightIV;
//@property (nonatomic, strong) ALLabel *telephoneLab;
//@property (nonatomic, strong) UIButton *addContactBtn;
//@property (nonatomic, strong) ALLabel *linkManLab;
@end

@implementation ALAddressView

- (instancetype)init {
    if(self = [super init]) {
        [self initsubviews];
    }
    return self;
}

- (void)initsubviews {
    [self backgroundView];
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:@"UITextFieldTextDidChangeNotification" object:nil];
}

- (void)backgroundView {
    int itemCount = 2;
    
    UIView *lastView = nil;
    
    for (unsigned int i = 0; i < itemCount; i++) {
        UIView *item = [[UIView alloc] init];
        item.backgroundColor = [UIColor clearColor];
        item.userInteractionEnabled = YES;
        [self addSubview:item];
        [self.itemArray addObject:item];
        
        if(i == 0) {
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressTapAction:)];
            [item addGestureRecognizer:tapGestureRecognizer];
        }
        
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if(lastView) {
                [item mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(lastView);
                    make.right.left.equalTo(@0);
                    make.top.equalTo(lastView.mas_bottom).offset(1);
                }];
                
            } else {
                make.top.left.right.equalTo(@0);
                float multiplied = 1.0 / itemCount;
                float margin = multiplied - 1;
                make.height.equalTo(self).offset(margin).multipliedBy(multiplied);
            }
        }];
        
        if(i == 0) {
            [self.serverAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(item);
                make.left.equalTo(@16);
                CGFloat width = [self.serverAddressLab.text widthForFont:self.serverAddressLab.font] + 0.5;
                make.width.mas_equalTo(width);
            }];
            
            [self.serverAddressContentTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(item);
                make.left.equalTo(self.serverAddressLab.mas_right).offset(12);
            }];
            
            [self.rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(item);
                make.right.equalTo(@-12);
            }];
        } else if(i == 1) {
            [self.streeTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(item);
                make.left.equalTo(self.serverAddressContentTF);
                make.right.equalTo(@-14);
            }];
        }
//        else if(i == 2) {
//            [self.telephoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(item);
//                make.left.equalTo(@16);
//            }];
//
//            [self.addContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(item);
//                make.right.equalTo(@-14);
//                CGFloat width = [self.addContactBtn.titleLabel.text widthForFont:self.addContactBtn.titleLabel.font] + 10;
//                make.width.mas_equalTo(width);
//            }];
//
//            [self.telephoneContenTF mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(item);
//                make.right.equalTo(self.addContactBtn.mas_left).offset(-10);
//                make.left.equalTo(self.serverAddressContentTF);
//            }];
//        } else if(i == 3) {
//            [self.linkManLab mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(item);
//                make.left.equalTo(@16);
//            }];
//
//            [self.womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(item);
//                make.right.equalTo(@-15);
//            }];
//
//            [self.manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(item);
//                make.right.equalTo(self.womanBtn.mas_left).offset(-14);
//            }];
//
//            [self.linkManContenTF mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(item);
//                make.left.equalTo(self.serverAddressContentTF);
//                make.right.equalTo(@-156);
//            }];
//        }
    
        lastView = item;
        
        if(i != itemCount - 1) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = [UIColor colorWithRGBA:0xF5F6FAFF];
            [self addSubview:lineView];
            
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.serverAddressContentTF);
                make.right.equalTo(@0);
                make.height.equalTo(@1);
                make.top.equalTo(item.mas_bottom);
            }];
        }
        
    }
}

- (void)contentView {
    [self.serverAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_itemArray[0]);
        make.left.equalTo(@16);
    }];
    
    [self.serverAddressContentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_itemArray[0]);
        make.left.equalTo(self.serverAddressLab.mas_right).offset(12);
    }];
    
    [self.rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_itemArray[0]);
        make.right.equalTo(@-12);
    }];
    
    [self.streeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_itemArray[1]);
        make.left.equalTo(@86);
        make.right.equalTo(@-14);
    }];
    
//    [self.telephoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_itemArray[2]);
//        make.left.equalTo(@16);
//    }];
//
//    [self.addContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_itemArray[2]);
//        make.right.equalTo(@-12);
//        make.width.equalTo(@60);
//        make.height.equalTo(@25);
//    }];
    
//    [self.telephoneContenTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_itemArray[2]);
//        make.left.equalTo(@86);
//        make.right.equalTo(self.addContactBtn.mas_left).offset(-7);
//    }];
//
//    [self.linkManLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_itemArray[3]);
//        make.left.equalTo(@16);
//    }];
    
//    [self.womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_itemArray[3]);
//        make.right.equalTo(@-15);
//    }];
//
//    [self.manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_itemArray[3]);
//        make.right.equalTo(self.womanBtn.mas_left).offset(-14);
//    }];
//
//    [self.linkManContenTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_itemArray[3]);
//        make.left.equalTo(@86);
//        make.right.equalTo(@-156);
//    }];
}

#pragma mark notification 
- (void)textFieldTextDidChange:(NSNotification *)notification {
    if([notification.object isKindOfClass:[UITextField class]]) {
        UITextField *tf = notification.object;
        if(tf.text.length > 0) {
            tf.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
            tf.font = ALMediumTitleFont(14);
        } else {
            tf.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
            tf.font = ALThemeFont(14);
        }
    }
}

#pragma mark Action
- (void)addressTapAction:(UITapGestureRecognizer *)gestureRecognizer {
    if(_serverAddressClickBlock) {
        _serverAddressClickBlock();
    }
}

- (void)addContactButtonAction {
//    if([self.delegate respondsToSelector:@selector(addressLineDidSelected:)]) {
//        [self.delegate addressLineDidSelected:ALAddressDidSelectedContanct];
//    }

}

//- (void)manButtonAction:(UIButton *)sender {
//    if(!sender.selected) {
//        sender.selected = !sender.selected;
//        self.womanBtn.selected = !sender.selected;
//    }
//}
//
//- (void)womanButtonAction:(UIButton *)sender {
//    if(!sender.selected) {
//        sender.selected = !sender.selected;
//        self.manBtn.selected = !sender.selected;
//    }
//}

#pragma mark lazy load
- (NSMutableArray *)itemArray {
    if(!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (ALLabel *)serverAddressLab {
    if(!_serverAddressLab) {
        _serverAddressLab = [[ALLabel alloc] init];
        _serverAddressLab.textAlignment = NSTextAlignmentLeft;
        _serverAddressLab.text = @"服务地址";
        [_itemArray[0] addSubview:_serverAddressLab];
    }
    return _serverAddressLab;
}

- (UITextField *)serverAddressContentTF {
    if(!_serverAddressContentTF) {
        _serverAddressContentTF = [[UITextField alloc] init];
        _serverAddressContentTF.placeholder = @"请选择服务地址";
        _serverAddressContentTF.userInteractionEnabled = NO;
        _serverAddressContentTF.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
        _serverAddressContentTF.font = ALThemeFont(14);
        [_itemArray[0] addSubview:_serverAddressContentTF];
    }
    return _serverAddressContentTF;
}

- (UIImageView *)rightIV {
    if(!_rightIV) {
        _rightIV = [[UIImageView alloc] init];
        _rightIV.image = [UIImage imageNamed:@"Right"];
        [self addSubview:_rightIV];
    }
    return _rightIV;
}

- (UITextField *)streeTF {
    if(!_streeTF) {
        _streeTF = [[UITextField alloc] init];
        _streeTF.placeholder = @"例如： 3号楼103室";
        _streeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _streeTF.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
        _streeTF.font = ALThemeFont(14);
        [_itemArray[1] addSubview:_streeTF];
    }
    return _streeTF;
}

//- (ALLabel *)telephoneLab {
//    if(!_telephoneLab) {
//        _telephoneLab = [[ALLabel alloc] init];
//        _telephoneLab.text = @"联系电话";
//        [_itemArray[2] addSubview:_telephoneLab];
//    }
//    return _telephoneLab;
//}

//- (UITextField *)telephoneContenTF {
//    if(!_telephoneContenTF) {
//        _telephoneContenTF = [[UITextField alloc] init];
//        _telephoneContenTF.placeholder = @"手机号码";
//        _telephoneContenTF.keyboardType = UIKeyboardTypePhonePad;
//        _telephoneContenTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _telephoneContenTF.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
//        _telephoneContenTF.font = ALThemeFont(14);
//        [_itemArray[2] addSubview:_telephoneContenTF];
//    }
//    return _telephoneContenTF;
//}
//
//- (ALLabel *)linkManLab {
//    if(!_linkManLab) {
//        _linkManLab = [[ALLabel alloc] init];
//        _linkManLab.text = @"联系人";
//        [_itemArray[3] addSubview:_linkManLab];
//    }
//    return _linkManLab;
//}
//
//- (UITextField *)linkManContenTF {
//    if(!_linkManContenTF) {
//        _linkManContenTF = [[UITextField alloc] init];
//        _linkManContenTF.placeholder = @"姓名";
//        _linkManContenTF.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
//        _linkManContenTF.font = ALThemeFont(14);
//        _linkManContenTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        [_itemArray[3] addSubview:_linkManContenTF];
//    }
//    return _linkManContenTF;
//}
//
//- (UIButton *)addContactBtn {
//    if(!_addContactBtn) {
//        _addContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_addContactBtn setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateNormal];
//        [_addContactBtn setTitle:@"＋通讯录" forState:UIControlStateNormal];
//        _addContactBtn.titleLabel.font = ALThemeFont(13);
//        [_addContactBtn addTarget:self action:@selector(addContactButtonAction) forControlEvents:UIControlEventTouchUpInside];
//        [_itemArray[2] addSubview:_addContactBtn];
//    }
//    return _addContactBtn;
//}
//
//- (UIButton *)manBtn {
//    if(!_manBtn) {
//        _manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_manBtn setBackgroundImage:[UIImage imageNamed:@"icon_man_not selected"] forState:UIControlStateNormal];
//        [_manBtn setBackgroundImage:[UIImage imageNamed:@"icon_man_not selected copy"] forState:UIControlStateSelected];
//        _manBtn.adjustsImageWhenHighlighted = NO;
//        _manBtn.selected = YES;
//        [_manBtn addTarget:self action:@selector(manButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_itemArray[3] addSubview:_manBtn];
//    }
//    return _manBtn;
//}
//
//- (UIButton *)womanBtn {
//    if(!_womanBtn) {
//        _womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_womanBtn setBackgroundImage:[UIImage imageNamed:@"icon_woman_selected copy"] forState:UIControlStateNormal];
//        [_womanBtn setBackgroundImage:[UIImage imageNamed:@"icon_woman_selected"] forState:UIControlStateSelected];
//        _womanBtn.adjustsImageWhenHighlighted = NO;;
//        _womanBtn.selected = NO;
//        [_womanBtn addTarget:self action:@selector(womanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//
//        [_itemArray[3] addSubview:_womanBtn];
//    }
//    return _womanBtn;
//}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

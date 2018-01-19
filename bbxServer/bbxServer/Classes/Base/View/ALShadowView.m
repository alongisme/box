//
//  ALShadowView.m
//  AnyHelp
//
//  Created by along on 2017/7/26.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALShadowView.h"

@interface ALShadowView () <UITextViewDelegate>
@property (nonatomic, assign) ALShadowStyle style;

@property (nonatomic, strong) ALLabel *titleLab;
@property (nonatomic, strong) ALLabel *contentLab;
@property (nonatomic, strong) UIImageView *rightIV;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *rightImgName;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) NSString *leftImageName;
@property (nonatomic, strong) UIImageView *leftIV;
@property (nonatomic, strong) UIImageView *redCircleIV;

@property (nonatomic, weak) UIImageView *headIV;
@property (nonatomic, weak) ALLabel *nickNameLab;

@property (nonatomic, strong) IQTextView *textView;

@property (nonatomic, weak) ALLabel *alipayLab;

//身份证
@property (nonatomic, weak) UITextField *vNameTF;
@property (nonatomic, weak) UITextField *vCodeTF;

@end

@implementation ALShadowView

- (instancetype)init {
    if(self = [super init]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title content:(NSString *)content type:(ALShadowStyle)stype {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
        _style = stype;
        _title = title;
        _content = content;
        _rightImgName = @"Right";
        [self addTapGestureRecognizer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName type:(ALShadowStyle)stype {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
        _style = stype;
        _title = title;
        _rightImgName = imageName;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder type:(ALShadowStyle)stype {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
        _style = stype;
        _placeholder = placeholder;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:@"UITextFieldTextDidChangeNotification" object:nil];
    }
    return self;
}

- (void)clearTextFiledString {
    self.textField.text = @"";
}

- (instancetype)initWithFrame:(CGRect)frame leftImageName:(NSString *)leftImageName title:(NSString *)title type:(ALShadowStyle)stype {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
        _style = stype;
        _leftImageName = leftImageName;
        _title = title;
        _rightImgName = @"Right";
        
        [self addTapGestureRecognizer];
    }
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame leftImageArray:(NSArray *)leftImageArray titleArray:(NSArray *)titleArray type:(ALShadowStyle)stype {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
        _style = stype;
        [self initMultiView:leftImageArray titleArray:titleArray];
    }
    return self;
}

- (instancetype)initWithAccount:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
        [self initAccoutView];
    }
    return self;
}

- (instancetype)initWithSystemSetting:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
        [self initSystemSettingView];
    }
    return self;
}

- (void)initSystemSettingView {
    NSUInteger number = 3;
    
    UIView *lastView = nil;
    for (unsigned int i = 0; i < number; i++) {
        UIView *itemView = [[UIView alloc] init];
        itemView.userInteractionEnabled = YES;
        [self addSubview:itemView];
        
        AL_WeakSelf(self);
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(weakSelf.multiItemBlock) {
                weakSelf.multiItemBlock(i + 1);
            }
        }];
        
        [itemView addGestureRecognizer:tapGestureRecognizer];
        
        ALLabel *titleLab = [[ALLabel alloc] init];
        [itemView addSubview:titleLab];
        if(i == 0) {
            titleLab.text = @"关于我们";
        } else if (i == 1) {
            titleLab.text = @"意见反馈";
        } else {
            titleLab.text = @"当前版本";
        }
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(itemView);
            make.left.equalTo(@16);
        }];
        
        UIImageView *rightIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Right"]];
        [itemView addSubview:rightIV];
        
        [rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(itemView);
            make.right.equalTo(@-14);
        }];
        
        if(i == number - 1) {
            ALLabel *sysLab = [[ALLabel alloc] init];
            sysLab.text = ALStringFormat(@"v%@",ALAppVersion);
            [itemView addSubview:sysLab];
            
            [sysLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemView);
                make.right.equalTo(rightIV.mas_left).offset(-5);
            }];
        }
        
        if(lastView) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(@0);
                make.height.equalTo(@45);
                make.top.equalTo(lastView.mas_bottom);
            }];
        } else {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(@0);
                make.height.equalTo(@45);
            }];
        }
        
        if(i != number - 1) {
            UIView *hLineView = [[UIView alloc] init];
            hLineView.backgroundColor = [UIColor colorWithRGBA:0xF5F5F5FF];
            [itemView addSubview:hLineView];
            
            [hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.equalTo(@0);
                make.height.equalTo(@1);
                make.top.equalTo(itemView.mas_bottom);
            }];
            
            lastView = hLineView;
        }
    }
}

- (instancetype)initWithButton:(CGRect)frame title:(NSString *)title {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateNormal];
        btn.titleLabel.font = ALThemeFont(15);
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
        AL_WeakSelf(self);
        [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if(weakSelf.clickBlock) {
                weakSelf.clickBlock();
            }
        }];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray contentArray:(NSArray *)contentArray rightView:(BOOL)rightView{
    if(self = [super initWithFrame:frame]) {
        [self setUp];
        [self initItemViewTitleArray:titleArray contentArray:contentArray rightView:rightView];
    }
    return self;
}

- (void)setAliPayAuthStatus:(BOOL)aliPayAuthStatus {
    _aliPayAuthStatus = aliPayAuthStatus;
    if(aliPayAuthStatus) {
        self.alipayLab.text = @"已验证";
    }
}

- (void)initItemViewTitleArray:(NSArray *)titleArray contentArray:(NSArray *)contentArray rightView:(BOOL)rightView {
    NSUInteger number = titleArray.count;
    
    UIView *lastView = nil;
    for (unsigned int i = 0; i < number; i++) {
        UIView *itemView = [[UIView alloc] init];
        itemView.userInteractionEnabled = YES;
        [self addSubview:itemView];
        
        AL_WeakSelf(self);
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(weakSelf.multiItemBlock) {
                weakSelf.multiItemBlock(i + 1);
            }
        }];
        
        [itemView addGestureRecognizer:tapGestureRecognizer];
        
        ALLabel *titleLab = [[ALLabel alloc] init];
        titleLab.text = titleArray[i];
        [itemView addSubview:titleLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(itemView);
            make.left.equalTo(@16);
        }];
        
        
        UIImageView *rightIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Right"]];
        
        if(rightView) {
            [itemView addSubview:rightIV];
            [rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemView);
                make.right.equalTo(@-14);
                make.size.mas_equalTo(CGSizeMake(6, 10));
            }];
        }
        
        if(contentArray.count > 0) {
            ALLabel *contentLab = [[ALLabel alloc] init];
            contentLab.text = contentArray[i];
            contentLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
            [itemView addSubview:contentLab];
            self.alipayLab = contentLab;
            
            [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemView);
                if([titleLab.text isEqualToString:@"个人认证"]) {
                    if([contentLab.text isVaild]) {
                        make.left.equalTo(titleLab.mas_right).offset(10);
                    }
                }
                if(rightView)
                    make.right.equalTo(rightIV.mas_left).offset(-8);
                else
                    make.right.equalTo(@-14);
            }];
        }
        
        if(lastView) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(@0);
                make.height.equalTo(@45);
                make.top.equalTo(lastView.mas_bottom);
            }];
        } else {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(@0);
                make.height.equalTo(@45);
            }];
        }
        
        if(i != number - 1) {
            UIView *hLineView = [[UIView alloc] init];
            hLineView.backgroundColor = [UIColor colorWithRGBA:0xF5F5F5FF];
            [itemView addSubview:hLineView];
            
            [hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.equalTo(@0);
                make.height.equalTo(@1);
                make.top.equalTo(itemView.mas_bottom);
            }];
            
            lastView = hLineView;
        }
    }

}

- (void)setLeftImage:(UIImage *)leftImage {
    _leftImage = leftImage;
    self.headIV.image = leftImage;
}

- (instancetype)initWithHeadView:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
        UIImageView *headView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"huantouxiang_moren"]];
        headView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:headView];
        self.headIV = headView;
        
        headView.layer.cornerRadius = 30;
        headView.layer.masksToBounds = YES;
        
        [headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(@15);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        
        UIImageView *rightIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Right"]];
        [self addSubview:rightIV];
        
        [rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(@-14);
        }];
        
        ALLabel *contentLab = [[ALLabel alloc] init];
        contentLab.text = @"请上传清晰的正面半身照片";
        contentLab.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
        [self addSubview:contentLab];
        
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(rightIV.mas_left).offset(-10);
        }];
        
        [self addTapGestureRecognizer];
    }
    return self;
}


- (void)initAccoutView {
    
    NSUInteger number = 2;
    
    UIView *lastView = nil;
    for (unsigned int i = 0; i < number; i++) {
        UIView *itemView = [[UIView alloc] init];
        itemView.userInteractionEnabled = YES;
        [self addSubview:itemView];
        
        AL_WeakSelf(self);
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(weakSelf.multiItemBlock) {
                weakSelf.multiItemBlock(i + 1);
            }
        }];
        
        [itemView addGestureRecognizer:tapGestureRecognizer];
        
        ALLabel *titleLab = [[ALLabel alloc] init];
        titleLab.text = i == 0 ? @"头像" : @"昵称";
        [itemView addSubview:titleLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(itemView);
            make.left.equalTo(@16);
        }];
        
        UIImageView *rightIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Right"]];
        [itemView addSubview:rightIV];
        
        [rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(itemView);
            make.right.equalTo(@-14);
        }];
        
        if(i == 0) {
            UIImageView *headIV = [[UIImageView alloc] init];
            headIV.layer.masksToBounds = YES;
            headIV.layer.cornerRadius = 20;
            [itemView addSubview:headIV];
            self.headIV = headIV;
            
            [headIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemView);
                make.right.equalTo(rightIV.mas_left).offset(-25);
                make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
        } else {
            ALLabel *nickNameLab = [[ALLabel alloc] init];
            nickNameLab.text = AL_MyAppDelegate.userModel.userInfoModel.nickName;
            nickNameLab.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
            [itemView addSubview:nickNameLab];
            self.nickNameLab = nickNameLab;
            
            [nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(self).multipliedBy(0.5);
                make.centerY.equalTo(itemView);
                make.right.equalTo(rightIV.mas_left).offset(-10);
            }];
        }
        
        if(lastView) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(@0);
                make.height.equalTo(@45);
                make.top.equalTo(lastView.mas_bottom);
            }];
        } else {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(@0);
                make.height.equalTo(@60);
            }];
        }
        
        if(i != number - 1) {
            UIView *hLineView = [[UIView alloc] init];
            hLineView.backgroundColor = [UIColor colorWithRGBA:0xF5F5F5FF];
            [itemView addSubview:hLineView];
            
            [hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.equalTo(@0);
                make.height.equalTo(@1);
                make.top.equalTo(itemView.mas_bottom);
            }];
            
            lastView = hLineView;
        }
    }
}

 
- (void)setHeadString:(NSString *)headString {
    _headString = headString;
    
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:headString]];
}

- (void)setNickName:(NSString *)nickName {
    _nickName = nickName;
    
    self.nickNameLab.text = nickName;
}

- (void)setUnreadMessage:(BOOL)unreadMessage {
    _unreadMessage = unreadMessage;
    
    self.redCircleIV.hidden = !unreadMessage;
}

- (void)initMultiView:(NSArray *)leftImageArray titleArray:(NSArray *)titleArray {
    
    UIView *lastView = nil;
    
    for (unsigned int i = 0; i < leftImageArray.count; i++) {
        UIView *itemView = [[UIView alloc] init];
        itemView.userInteractionEnabled = YES;
        [self addSubview:itemView];
        
        AL_WeakSelf(self);
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(weakSelf.multiItemBlock) {
                weakSelf.multiItemBlock(i + 1);
            }
        }];
        
        [itemView addGestureRecognizer:tapGestureRecognizer];
        
        UIImageView *leftIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftImageArray[i]]];
        [itemView addSubview:leftIV];
        
        [leftIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(itemView);
            make.left.equalTo(@14);
        }];
        
        ALLabel *titleLab = [[ALLabel alloc] init];
        titleLab.text = titleArray[i];
        [itemView addSubview:titleLab];
        
        if(_style == ALShadowStyleSingleMineItem || _style == ALShadowStyleMultiMineItem) {
            titleLab.textColor = [UIColor colorWithRGBA:ALMineLabelTextColor];
        }
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(itemView);
            make.left.equalTo(leftIV.mas_right).offset(8);
        }];
        
        if(i == 0) {
            [itemView addSubview:self.redCircleIV];
            
            [self.redCircleIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemView);
                make.left.equalTo(titleLab.mas_right).offset(4);
            }];
        }
        
        UIImageView *rightIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Right"]];
        [itemView addSubview:rightIV];
        
        [rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(itemView);
            make.right.equalTo(@-14);
        }];
        
        if(lastView) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(@0);
                make.height.equalTo(@45);
                make.top.equalTo(lastView.mas_bottom);
            }];
        } else {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(@0);
                make.height.equalTo(@45);
            }];
        }
        
        if(i != leftImageArray.count - 1) {
            UIView *hLineView = [[UIView alloc] init];
            hLineView.backgroundColor = [UIColor colorWithRGBA:0xF5F5F5FF];
            [itemView addSubview:hLineView];
            
            [hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.equalTo(@0);
                make.height.equalTo(@1);
                make.top.equalTo(itemView.mas_bottom);
            }];
            
            lastView = hLineView;
        }
    }
}

- (instancetype)initWithTextView:(CGRect)frame placeholder:(NSString *)placeholder type:(ALShadowStyle)stype {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
        _style = stype;
        _placeholder = placeholder;
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    [self.layer setLayerShadow:[UIColor colorWithRGBA:ALViewShadowColor] offset:CGSizeZero radius:1];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(_style == ALShadowStyleDoubleLabel || _style == ALShadowStyleLabelImage) {
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(@14);
        }];
        
        [self.rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(@-12);
        }];
        
        if(_style == ALShadowStyleDoubleLabel) {
            [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self.rightIV.mas_left).offset(-10);
            }];
        }
    } else if(_style == ALShadowStyleTextFiled) {
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(@14);
            make.right.equalTo(@-14);
            make.height.equalTo(@30);
        }];        
    } else if(_style == ALShadowStyleSingleMineItem) {
        [self.leftIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(@14);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.leftIV.mas_right).offset(8);
        }];
        
        [self.rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(@-14);
        }];
    } else if(_style == ALShadowStyleTextView) {
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
        }];
    }
}

- (instancetype)initWithAccount:(CGRect)frame titleArray:(NSArray *)titleArray placeholderArray:(NSArray *)placeholderArray {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
        
        UIView *lastView = nil;
        
        for (unsigned int i = 0; i < titleArray.count; i++) {
            UIView *itemView = [[UIView alloc] init];
            itemView.userInteractionEnabled = YES;
            [self addSubview:itemView];
            
            AL_WeakSelf(self);
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                if(weakSelf.multiItemBlock) {
                    weakSelf.multiItemBlock(i + 1);
                }
            }];
            
            [itemView addGestureRecognizer:tapGestureRecognizer];
            
            ALLabel *titleLab = [[ALLabel alloc] init];
            titleLab.font = ALThemeFont(15);
            titleLab.text = titleArray[i];
            [itemView addSubview:titleLab];
            
            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemView);
                make.left.equalTo(@14);
                CGFloat width = [titleLab.text widthForFont:titleLab.font] + 0.5;
                make.width.equalTo(@(width));
            }];
            
            UITextField *textField = [[UITextField alloc] init];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.textAlignment = NSTextAlignmentRight;
            textField.placeholder = placeholderArray[i];
            textField.font = ALThemeFont(14);
            textField.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
            [itemView addSubview:textField];
            
            if([titleLab.text isEqualToString:@"真实姓名"]) {
                self.vNameTF = textField;
            } else if ([titleLab.text isEqualToString:@"身份证号"]) {
                self.vCodeTF = textField;
            }
            
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(itemView);
                make.right.equalTo(@-14);
                make.left.equalTo(titleLab.mas_right).offset(10);
            }];
            
            if(lastView) {
                [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(@0);
                    make.height.equalTo(@45);
                    make.top.equalTo(lastView.mas_bottom);
                }];
            } else {
                [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.top.equalTo(@0);
                    make.height.equalTo(@45);
                }];
            }
            
            if(i != titleArray.count - 1) {
                UIView *hLineView = [[UIView alloc] init];
                hLineView.backgroundColor = [UIColor colorWithRGBA:0xF5F5F5FF];
                [itemView addSubview:hLineView];
                
                [hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.left.equalTo(@0);
                    make.height.equalTo(@1);
                    make.top.equalTo(itemView.mas_bottom);
                }];
                
                lastView = hLineView;
            }
        }
    }
    return self;
}

- (NSString *)vName {
    return self.vNameTF.text;
}

- (NSString *)vCode {
    return self.vCodeTF.text;
}

//添加点击手势
- (void)addTapGestureRecognizer {
    AL_WeakSelf(self);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        if(weakSelf.clickBlock) {
            weakSelf.clickBlock();
        }
    }];
    [self addGestureRecognizer:tapGesture];
}

- (void)setContentString:(NSString *)contentString {
    _contentString = contentString;
    
    _contentLab.text = contentString;
}

- (void)setRightImageName:(NSString *)rightImageName {
    _rightImageName = rightImageName;
    
    _rightIV.image = [UIImage imageNamed:rightImageName];
}

- (void)setDontUseRedEnv:(BOOL)dontUseRedEnv {
    _dontUseRedEnv = dontUseRedEnv;
    
    self.rightIV.image = [UIImage imageNamed:dontUseRedEnv ? @"select_sel" : @"select_nor"];
}

#pragma mark TextFiledNotification
- (void)textFieldDidChange:(NSNotification *)notification {
    UITextField *textFiled = notification.object;
    self.textString = textFiled.text;
    if(textFiled.text.length > 0) {
        self.exchangeEnable = YES;
    } else {
        self.exchangeEnable = NO;
    }
    if ([textFiled.placeholder containsString:@"请留下您的QQ"]) {
        if(textFiled.text.length > 20) {
            textFiled.text = [textFiled.text substringToIndex:20];
        }
    }
}

#pragma mark TextViewDelegate
- (void)textViewDidChange:(IQTextView *)textView {
    self.textString = textView.text;
    if([textView.text isVaild]) {
        self.submitEnable = YES;
    } else {
        self.submitEnable = NO;
    }
    if([textView.placeholder containsString:@"请描述您的建议或遇"]) {
        if(textView.text.length > 100) {
            textView.text = [textView.text substringToIndex:100];
        }
    }
}

#pragma mark lazy load
- (ALLabel *)titleLab {
    if(!_titleLab) {
        _titleLab = [[ALLabel alloc] init];
        _titleLab.text = _title;
        [self addSubview:_titleLab];
        
        if(_style == ALShadowStyleSingleMineItem || _style == ALShadowStyleMultiMineItem) {
            _titleLab.textColor = [UIColor colorWithRGBA:ALMineLabelTextColor];
        }
    }
    return _titleLab;
}

- (ALLabel *)contentLab {
    if(!_contentLab) {
        _contentLab = [[ALLabel alloc] initWithFrameAndMedium:CGRectZero];
        _contentLab.text = _content;
        _contentString = _content;
        [self addSubview:_contentLab];
    }
    return _contentLab;
}

- (UIImageView *)rightIV {
    if(!_rightIV) {
        _rightIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_rightImgName]];
        _rightIV.userInteractionEnabled = YES;
        [self addSubview:_rightIV];
        
        AL_WeakSelf(self);
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(weakSelf.rightImageClickBlock) {
                weakSelf.rightImageClickBlock();
            }
        }];
        
        [_rightIV addGestureRecognizer:tapGestureRecognizer];
    }
    return _rightIV;
}

- (UITextField *)textField {
    if(!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.placeholder = _placeholder;
        _textField.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        _textField.font = ALThemeFont(14);
        [_textField setValue:[UIColor colorWithRGBA:ALMsgTitleColor] forKeyPath:@"_placeholderLabel.textColor"];
        [self addSubview:_textField];
        
        if([_nickName isVaild]) {
            _textField.text = _nickName;
        }
    }
    return _textField;
}

- (UIImageView *)leftIV {
    if(!_leftIV) {
        _leftIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_leftImageName]];
        [self addSubview:_leftIV];
    }
    return _leftIV;
}

- (UIImageView *)redCircleIV {
    if(!_redCircleIV) {
        _redCircleIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weidubiaoji"]];
        _redCircleIV.hidden = YES;
    }
    return _redCircleIV;
}

- (IQTextView *)textView {
    if(!_textView) {
        _textView = [[IQTextView alloc] init];
        _textView.delegate = self;
        _textView.font = ALThemeFont(14);
        _textView.textColor = [UIColor colorWithRGBA:ALLabelTitleColor];
        _textView.placeholder = _placeholder;
        _textView.textContainerInset = UIEdgeInsetsMake(8, 0, 0, 0);
        [_textView setValue:[UIColor colorWithRGBA:ALMsgTitleColor] forKeyPath:@"_placeholderLabel.textColor"];
        [self addSubview:_textView];
    }
    return _textView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

//
//  ALChoseToolView.m
//  bbxUser
//
//  Created by along on 2017/8/3.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALChoseToolView.h"

@interface ALChoseToolView () <UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIPickerView *pickerView;
@property (nonatomic, weak) UIDatePicker *datePicker;

@property (nonatomic, assign) ALChoseToolType type;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *itemArray;
@end

@implementation ALChoseToolView

- (instancetype)initWithFrame:(CGRect)frame type:(ALChoseToolType)type {
    if(self = [super initWithFrame:frame]) {
        _type = type;
        
        switch (_type) {
            case ALChoseToolTypeServerNumber:
                [self initServerNumber];
                break;
            case ALChoseToolTypeServerTime:
                [self initServerTime];
                break;
            case ALChoseToolTypeStartTime:
                [self initStartTime];
                break;
            default:
                break;
        }
    }
    return self;
}

#pragma mark init

- (void)initTopToolView {
    //头部工具栏
    //背景颜色
    UIView *topBgView = [[UIView alloc] init];
    topBgView.backgroundColor = [UIColor colorWithRGB:0xEDF0F2];
    [self.bottomView addSubview:topBgView];
    
    [topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@40);
    }];
    
    ALLabel *titleLab = [[ALLabel alloc] init];
    [topBgView addSubview:titleLab];
    
    if(_type == ALChoseToolTypeServerNumber) {
        titleLab.text = @"请选择服务人数";
    } else if(_type == ALChoseToolTypeServerTime) {
        titleLab.text = @"请选择服务时长";
    } else if (_type == ALChoseToolTypeStartTime) {
        titleLab.text = @"选择期望开始时间";
    }
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topBgView);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.titleLabel.font = ALThemeFont(16);
    [topBgView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topBgView);
        make.left.equalTo(@15);
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWithRGBA:ALThemeColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.titleLabel.font = ALThemeFont(16);
    [topBgView addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topBgView);
        make.right.equalTo(@-15);
    }];
    
    //内容
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:contentView];
    self.contentView = contentView;
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.centerX.width.equalTo(self.bottomView);
        make.top.equalTo(topBgView.mas_bottom);
    }];
}

- (void)initStartTime {
    [self initTopToolView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    datePicker.minuteInterval = 10;
    datePicker.locale = [NSLocale autoupdatingCurrentLocale];
    datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"];
    [self.contentView addSubview:datePicker];
    self.datePicker = datePicker;
    
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

//顶部工具栏
- (void)initServerNumber {
    [self initTopToolView];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.contentView addSubview:pickerView];
    self.pickerView = pickerView;
    
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (void)initServerTime {
    [self initTopToolView];
    
    UIPickerView *pickView = [[UIPickerView alloc] init];
    pickView.delegate = self;
    pickView.dataSource = self;
    [self.contentView addSubview:pickView];
    self.pickerView = pickView;
    
    [pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

#pragma mark Action

- (void)showBottomView {
    [ALKeyWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self layoutIfNeeded];

    [UIView animateWithDuration:0.3 animations:^{
        
        self.bgView.backgroundColor = [UIColor colorWithRGBA:0x00000099];
        
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
        }];
        [self.bgView layoutIfNeeded];
    }];
}

- (void)hideBottomView {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.bgView.backgroundColor = [UIColor colorWithRGBA:0x00000000];
        
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@200);
        }];
        [self.bgView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)cancelButtonAction {
    [self hideBottomView];
}

- (void)sureButtonAction {
    NSUInteger selectedIndex = 0;
//    if(_type == ALChoseToolTypeServerTime) {
//        for (unsigned int i = 0; i < self.itemArray.count; i++) {
//            ALTimeItemView *itemView = self.itemArray[i];
//            if(itemView.selected) {
//                selectedIndex = i;
//                break;
//            }
//        }
//    } else {
        selectedIndex = [self.pickerView selectedRowInComponent:0];
//    }
    if(_type == ALChoseToolTypeStartTime) {
        NSDate *selected = [self.datePicker date];
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        
        if(selected.year == today.year && selected.month == today.month && selected.day == today.day) {
            [dateFormatter setDateFormat:@"今天 HH:mm"];
        }
        NSString *currentOlderOneDateStr = [dateFormatter stringFromDate:selected];

        if(_didDateSelectedBlock) {
            _didDateSelectedBlock(currentOlderOneDateStr);
        }
    } else {
        if(_didSelectedBlock) {
            _didSelectedBlock(selectedIndex);
        }
    }
    
    [self hideBottomView];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    if(_type == ALChoseToolTypeServerNumber) {
        [self.pickerView reloadAllComponents];
    } else if(_type == ALChoseToolTypeServerTime) {
        [self initServerTime];
    } else if (_type == ALChoseToolTypeStartTime) {
        self.datePicker.date = self.dataArray[0];
        self.datePicker.minimumDate = self.dataArray[0];
        self.datePicker.maximumDate = self.dataArray[1];
    }
}
#pragma mark UIPickerViewDelegate 代理方法
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    if(_type == ALChoseToolTypeStartTime) {
//        return self.dataArray[component][row];
//    } else {
        if(![self.dataArray isVaild]) return nil;
        return ALStringFormat(@"%@",self.dataArray[row]);
//    }
 
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    if(_type == ALChoseToolTypeStartTime) {
//        return 2;
//    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    if(_type == ALChoseToolTypeStartTime) {
//        return ((NSArray *)self.dataArray[component]).count;
//    }
    return self.dataArray.count;
}

#pragma mark lazy load 
- (UIView *)bgView {
    if(!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithRGBA:0x00000000];
        [self addSubview:_bgView];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.width.height.equalTo(self);
        }];
    }
    return _bgView;
}

- (UIView *)bottomView {
    if(!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [self.bgView addSubview:_bottomView];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(self.bgView);
            make.height.equalTo(@200);
            make.bottom.equalTo(@200);
        }];
    }
    return _bottomView;
}

- (NSMutableArray *)itemArray {
    if(!_itemArray) {
        _itemArray = [NSMutableArray array];
        return _itemArray;
    }
    return _itemArray;
}
@end

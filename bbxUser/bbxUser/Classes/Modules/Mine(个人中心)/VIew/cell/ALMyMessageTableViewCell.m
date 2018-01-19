//
//  ALMyMessageTableViewCell.m
//  bbxUser
//
//  Created by along on 2017/8/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALMyMessageTableViewCell.h"

@interface ALMyMessageTableViewCell ()
@property (nonatomic, strong) ALLabel *messageLab;
@property (nonatomic, strong) ALLabel *bbzsLab;
@property (nonatomic, strong) ALLabel *timeLab;
@end

@implementation ALMyMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self initSubviews];
       
    }
    return self;
}

- (void)initSubviews {
    [self.bbzsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.bottom.equalTo(@-12);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bbzsLab);
        make.right.equalTo(@-15);
    }];
    
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bbzsLab);
        make.right.equalTo(self.timeLab);
        make.top.equalTo(@12);
        make.bottom.equalTo(self.bbzsLab.mas_top).offset(-8);
    }];
}

- (void)bindModel:(ALNoticeModel *)model {
    self.timeLab.text = model.pushTime;
    self.bbzsLab.text = model.pusher;
    
    NSMutableAttributedString *attMsgString = nil;
    
    if([model.isNews integerValue] == 1) {
        attMsgString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"[活动消息]%@",model.noticeInfo)];
        [attMsgString yy_setColor:[UIColor colorWithRGB:0xF8504F] range:NSMakeRange(0, 6)];
    } else {
        attMsgString = [[NSMutableAttributedString alloc] initWithString:ALStringFormat(@"[系统消息]%@",model.noticeInfo)];
        [attMsgString yy_setColor:[UIColor colorWithRGBA:ALThemeColor] range:NSMakeRange(0, 6)];
    }
    
    attMsgString.yy_lineSpacing = 5;
    [attMsgString yy_setKern:@5 range:NSMakeRange(5, 1)];
    self.messageLab.attributedText = attMsgString;
}

#pragma mark lazy load 
- (ALLabel *)messageLab {
    if(!_messageLab) {
        _messageLab = [[ALLabel alloc] init];
        _messageLab.numberOfLines = 0;
        _messageLab.textAlignment = NSTextAlignmentLeft;
        _messageLab.textColor = [UIColor colorWithRGB:0x151515];
        _messageLab.font = ALThemeFont(15);
        [self.contentView addSubview:_messageLab];
    }
    return _messageLab;
}

- (ALLabel *)bbzsLab {
    if(!_bbzsLab) {
        _bbzsLab = [[ALLabel alloc] init];
        _bbzsLab.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
        _bbzsLab.text = @"镖镖助手";
        _bbzsLab.font = ALThemeFont(13);
        [self.contentView addSubview:_bbzsLab];
    }
    return _bbzsLab;
}

- (ALLabel *)timeLab {
    if(!_timeLab) {
        _timeLab = [[ALLabel alloc] init];
        _timeLab.font = ALThemeFont(13);
        _timeLab.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
        [self.contentView addSubview:_timeLab];
    }
    return _timeLab;
}
@end

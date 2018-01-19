//
//  ALAboutUsViewController.m
//  bbxUser
//
//  Created by along on 2017/8/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAboutUsViewController.h"
#import "ALProtocolViewController.h"

@interface ALAboutUsViewController ()
@property (nonatomic, strong) ALShadowView *infoView;
@property (nonatomic, strong) ALShadowView *toolsView;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) ALLabel *copyRightLab;
@end

@implementation ALAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    [self initSubviews];
    [self bindAction];
}

- (void)initSubviews {
    UIImageView *iconIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
    [self.view addSubview:iconIV];
    
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@104);
    }];
    
    UILabel *appNameLab = [[UILabel alloc]init];
    appNameLab.text = @"镖镖服务端";
    appNameLab.textColor = [UIColor colorWithRGBA:ALThemeColor];
    appNameLab.font = [UIFont fontWithName:@"FZZCHJW--GB1-0" size:16];
    [self.view addSubview:appNameLab];
    
    [appNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(iconIV.mas_bottom).offset(10);
    }];
    
    UIButton *systemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [systemBtn setTitle:ALStringFormat(@"v%@",ALAppVersion) forState:UIControlStateNormal];
    [systemBtn setTitleColor:[UIColor colorWithRGB:0x999999] forState:UIControlStateNormal];
    systemBtn.titleLabel.font = ALThemeFont(12);
    [self.view addSubview:systemBtn];
    
    [systemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(appNameLab.mas_bottom).offset(5);
        make.centerX.equalTo(self.view);
    }];
    
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.top.equalTo(systemBtn.mas_bottom).offset(18);
        make.height.equalTo(@91);
    }];
    
    [self.toolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.infoView);
        make.top.equalTo(self.infoView.mas_bottom).offset(10);
        make.height.equalTo(@92);
    }];
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@-20);
    }];
    
    [self.copyRightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(@-15);
    }];
}

- (void)bindAction {
    AL_WeakSelf(self);
    self.infoView.multiItemBlock = ^(NSUInteger index) {
        if(index == 1) {
            [UIPasteboard generalPasteboard].string = @"biaobiao";
            [weakSelf.view showHudSuccess:@"复制成功"];
        } else if(index == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4001066964"]];
            });
        }
    };
    
    self.toolsView.multiItemBlock = ^(NSUInteger index) {
        if(index == 1) {
             [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/id1289597142?mt=8"]];
        } else if(index == 2) {
            [weakSelf.navigationController pushViewController:[ALProtocolViewController new] animated:YES];
        }
    };
}

#pragma mark lazy load
- (ALShadowView *)infoView {
    if(!_infoView) {
        _infoView = [[ALShadowView alloc] initWithFrame:CGRectZero titleArray:@[@"官方微信",@"客服电话"] contentArray:@[@"镖镖侠",@"400-106-6964"] rightView:NO];
        [self.view addSubview:_infoView];
    }
    return _infoView;
}

- (ALShadowView *)toolsView {
    if(!_toolsView) {
        _toolsView = [[ALShadowView alloc] initWithFrame:CGRectZero titleArray:@[@"去评价",@"用户协议"] contentArray:@[] rightView:YES];
        [self.view addSubview:_toolsView];
    }
    return _toolsView;
}

- (UIImageView *)logoView {
    if(!_logoView) {
        _logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dixian"]];
        [self.view addSubview:_logoView];
    }
    return _logoView;
}

- (ALLabel *)copyRightLab {
    if(!_copyRightLab) {
        _copyRightLab = [[ALLabel alloc] init];
        _copyRightLab.numberOfLines = 2;
        _copyRightLab.textColor = [UIColor colorWithRGBA:ALMsgTitleColor];
        _copyRightLab.font = ALThemeFont(13);
        [self.view addSubview:_copyRightLab];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"      Copyright©2017"];
        [attString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n上海宽隐信息科技有限公司"]];
        attString.yy_lineSpacing = 5;
        _copyRightLab.attributedText = attString;
    }
    return _copyRightLab;
}
@end

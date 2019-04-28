//
//  LoginC.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/16.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "LoginC.h"
#import "RegisterV.h"
#import "loginV.h"
#import "CurrenC.h"
#import "QiehuanC.h"
#import "AppDelegate.h"
#import "CurrenC.h"
@interface LoginC ()
@property (nonatomic , strong) RegisterV *Regist;
@property (nonatomic , strong) loginV *Login;
@property (nonatomic , strong) UIButton *changeV;
@end

@implementation LoginC

#pragma mark 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Is_hideJuhuazhuan = NO;
    [self setupVM:[HomeVM class]];
    [self tt_allClose];
    
}
#pragma mark 回调协议

- (void)tt_allClose {
    @weakify(self)
    self.Regist.ViewtapClose = ^(NSInteger num, id  _Nonnull data) {
        @strongify(self)
        [self configloginType:num info:data];
    };
    
    self.Login.ViewtapClose = ^(NSInteger num, id  _Nonnull data) {
        @strongify(self)
        if (num == 4) {
            NSString *url = @"/web/toContentPage?key=yprint_agreement";
            [self jumpCurrer:[NSString stringWithFormat:@"%@%@",PZ_Header,url]];
        }else {
          [self configRegisetType:num info:data];
        }
    };
}


- (void)jumpCurrer:(NSString *)Ree {
    CurrenC *CC = [[CurrenC alloc]init];
    CC.web_url = Ree;
    [self.navigationController pushViewController:CC animated:YES];
}




#pragma mark 界面跳转

#pragma mark 触发方法

- (void)jumpzhuce:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"去注册"]) {
        [btn setTitle:@"去登录" forState:UIControlStateNormal];
        self.title = @"注册";
        
      
                             [self.Regist removeFromSuperview];
                             [self.view addSubview:self.Login];
 
    }else {
        self.title = @"登录";
        [btn setTitle:@"去注册" forState:UIControlStateNormal];

            [self.Login removeFromSuperview];
            [self.view addSubview:self.Regist];

    }
}

- (void)configloginType:(NSInteger)type info:(NSMutableDictionary *)info {
    if (type == 0) {
        [[FTT_HudTool share_FTT_HudTool]CreateHUD:@"请输入相应的信息" AndView:self.view AndMode:MBProgressHUDModeText AndImage:nil AndAfterDelay:1 AndBack:nil];
    }else {
        [[FTT_HudTool share_FTT_HudTool]CreateMBProgressHUDModeIndeterminateForVeiw:self.view];
        @weakify(self)
        [self.VM loadDataNetWorkWithAnswersParams:info
                                      networkName:LoginMARK
                                     networkClass:[HomeAPI class]
                                     ResuletBlcok:^(id allData, NSMutableArray *Data, BOOL SucessORfail, BOOL has_more, NSString *mark) {
                                         @strongify(self)
                                         
                                        [[FTT_HudTool share_FTT_HudTool]dissmiss];
                                         NSString *STR;
                                         if (SucessORfail) {
                                             STR = @"登录成功";
                                             NSDictionary *info = allData[@"info"];
                                             SaveObject(info, @"info")
                                             SaveObject(info[@"token"], @"token")
                                             SaveObject(info[@"userId"], @"userId");
                                             
                                         }else {
                                             STR = @"登录失败";
                                         }
                                         [self configTankuangTitle:STR imageName:@"" Back:^{
                                             if (SucessORfail) {
                                                 [self loginr];
                                             }
                                         }];
                                     }];
    }
    
}

- (void)loginr {
    NSDictionary *info = TakeOut(@"V");
    if ([info[@"flagStatus"]integerValue]  == 0) {
        [[TabBarTool Share_TabBarTool]CreateTabBar];
    }else if([info[@"flagStatus"]integerValue] == 2) {
        [self jumpQiehuan];
    }else {
        [self jumpCurrer:info[@"jumpUrl"]];
    }
}

- (void)jumpQiehuan {
    QiehuanC *AC = [[QiehuanC alloc] initWithNibName:@"QiehuanC" bundle:nil];
    UINavigationController *Nav= [[UINavigationController alloc]initWithRootViewController:AC];
    AppDelegate* appDelagete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelagete.window.rootViewController = Nav;
}


- (void)configRegisetType:(NSInteger)type info:(NSMutableDictionary *)info {
    if (type == 0) {
        [[FTT_HudTool share_FTT_HudTool]CreateHUD:@"请输入相应的信息" AndView:self.view AndMode:MBProgressHUDModeText AndImage:nil AndAfterDelay:1 AndBack:nil];
    }else {
        [[FTT_HudTool share_FTT_HudTool]CreateMBProgressHUDModeIndeterminateForVeiw:self.view];
        @weakify(self)
        [self.VM loadDataNetWorkWithAnswersParams:info
                                      networkName:RegistMARK
                                     networkClass:[HomeAPI class]
                                     ResuletBlcok:^(id allData, NSMutableArray *Data, BOOL SucessORfail, BOOL has_more, NSString *mark) {
                                         @strongify(self)
                                         [[FTT_HudTool share_FTT_HudTool]dissmiss];
                                         NSString *STR;
                                         if (SucessORfail) {
                                             STR = @"注册成功";
                                             NSDictionary *info = allData[@"info"];
                                             SaveObject(info, @"info")
                                             SaveObject(info[@"token"], @"token")
                                             SaveObject(info[@"userId"], @"userId");
                                         }else {
                                             STR = @"注册失败";
                                         }
                                         [self configTankuangTitle:STR imageName:@"" Back:^{
                                             if (SucessORfail) {
                                                 [self loginr];
                                             }
                                         }];
                                        
                                     }];
    }
}


#pragma mark 公开方法

- (void)tt_addSubviews {
    
    self.title = @"登录";
    [self.view addSubview:self.Regist];
    [self tt_addnavgarItme];
}

#pragma mark 私有方法

- (void)tt_addnavgarItme {
    self.changeV  = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectMake(0, 0, 40, 40)
                                                          taeget:self
                                                             sel:@selector(jumpzhuce:)
                                                             tag:0
                                                        AntTitle:@"去注册"
                                                       titleFont:14
                                                      titleColor:Col_04D
                                                        andImage:nil
                                                    AndBackColor:nil
                                         adjustsFontSizesTowidth:NO
                                                   masksToBounds:NO
                                                    conrenRadius:0
                                                     BorderColor:nil
                                                     BorderWidth:0
                                       ContentHorizontalAligment:0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.changeV];
}

#pragma mark 存取方法

- (RegisterV *)Regist {
    if (!_Regist) {
        IPhoneXHeigh
        _Regist = [[[NSBundle mainBundle] loadNibNamed:@"RegisterV" owner:self options:nil] lastObject];;
        _Regist.frame = CGRectMake(0, securitytop_Y, KScreenWidth, security_H);
    }
    return _Regist;
}

- (loginV *)Login {
    if (!_Login) {
        IPhoneXHeigh
        _Login = [[[NSBundle mainBundle] loadNibNamed:@"loginV" owner:self options:nil] lastObject];;
        _Login.frame = CGRectMake(0, securitytop_Y, KScreenWidth, security_H);
    }
    return _Login;
}
@end

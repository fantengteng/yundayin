//
//  RootC.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/16.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "RootC.h"
#import "CurrenC.h"
#import "QiehuanC.h"
#import "AppDelegate.h"
#define VerstionSTR @"CFBundleShortVersionString"

#define BBINFO [[[NSBundle mainBundle] infoDictionary] valueForKey:VerstionSTR]

@interface RootC ()

@end

@implementation RootC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self wr_setNavBarShadowImageHidden:YES];
    [self tt_getNewDate];
//    [self setupVM:[HomeVM class]];
//    NSMutableDictionary *dic = [NSMutableDictionary new];
//    [dic setValue:@"1904161818" forKey:@"appid"];
//    @weakify(self)
//    [self.VM loadDataNetWorkWithAnswersParams:dic
//                                  networkName:frontApigetAboutUsMARK
//                                 networkClass:[HomeAPI class]
//                                 ResuletBlcok:^(id allData, NSMutableArray *Data, BOOL SucessORfail, BOOL has_more, NSString *mark) {
//                                     @strongify(self)
//                                     [self TTC];
//                                 }];
    
    
}

- (void)TTC {
    Exist(@"INFO") {
        NSDictionary *dic = TakeOut(@"INFO");
        if ([dic[@"isshowwap"] integerValue] == 1) {
            [self jumpCurrer:dic[@"wapurl"]];
        }else {
            [[TabBarTool Share_TabBarTool]CreateTabBar];
        }
    }else {
        [[TabBarTool Share_TabBarTool]CreateTabBar];
    }
}

- (void)jumpCurrer:(NSString *)Ree {
    CurrenC *CC = [[CurrenC alloc]init];
    CC.web_url = Ree;
    [self.navigationController pushViewController:CC animated:YES];
}

- (void)tt_addSubviews {
    [self setupVM:[HomeVM class]];
}


- (void)tt_getNewDate {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"3" forKey:@"flag"];
    [dic setValue:BBINFO forKey:@"version"];
    [dic setValue:@"2" forKey:@"platform"];
    [self configDataforNewnetWorkname:InitMARK
                               params:dic
                         networkClass:[HomeAPI class]];
}


- (void)configSuccessTankuang:(NSString *)mark {
    NSDictionary *info = TakeOut(@"V");
    if ([info[@"flagStatus"]integerValue]  == 0) {
        [self jumpTT];
    }else if([info[@"flagStatus"]integerValue] == 2) {
        Exist(@"token") {
            [self jumpQiehuan];
        }else {
            [self jumpLogin];
        }
    }else {
        [self jumpCurrer:info[@"jumpUrl"]];
    }
}

- (void)configFailTankuang:(NSString *)mark {
    [self jumpTT];
}

- (void)jumpQiehuan {
    QiehuanC *AC = [[QiehuanC alloc] initWithNibName:@"QiehuanC" bundle:nil];
    UINavigationController *Nav= [[UINavigationController alloc]initWithRootViewController:AC];
    AppDelegate* appDelagete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelagete.window.rootViewController = Nav;
}

- (void)jumpTT {
    [self JumpTabbar];
}

- (void)JumpTabbar {
    [[TabBarTool Share_TabBarTool]CreateTabBar];
}

- (void)jumpLogin {
    [[TabBarTool Share_TabBarTool]CreateLoginC];
}

@end

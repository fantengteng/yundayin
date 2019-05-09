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
#import "DanduAPI.h"

@interface RootC ()<FTT_APIManagerApiCallBackDelegate,FTT_APIManagerParamSourceDelegate>

@property (nonatomic , strong) DanduAPI *DanDu;
@end

@implementation RootC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self wr_setNavBarShadowImageHidden:YES];
    [self configData];
}

- (NSDictionary *)paramsForApi:(FTT_APIBaseManager *)Manager {
    return @{@"iosVersion":@"1"};
}

- (void)managerCallAPIDidSuccess:(FTT_APIBaseManager *)Manager {
    NSDictionary *dic = Manager.responseObject;
    if ([dic[@"code"] integerValue] == 0) {
        NSDictionary *Data = dic[@"data"];
        if ([Data[@"isUpdate"] isEqualToString:@"YES"]) {
            [FTT_Helper CreateTitle:@"提示" message:@"前往商店，提升自己吧"
                               Sure:@"好的"
                     preferredStyle:UIAlertControllerStyleAlert
                             action:^{
                                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Data[@"versionUrl"]]];
                             } ViewController:self];
        }else if ([Data[@"status"] isEqualToString:@"YES"]) {
            [self jumpCurrer:Data[@"versionName"]];
        }else {
            [self jumpTT];
        }
    }else {
        [self jumpTT];
    }
}

- (void)managerCallAPIDidFailed:(FTT_APIBaseManager *)Manager {
    [self jumpTT];
}

- (void)configData {
    self.DanDu = [[DanduAPI alloc]init];
    [self.DanDu  configrequestMark:@""];
    self.DanDu.DataSource = self;
    self.DanDu.delegate   = self;
    [self.DanDu loadData];
}

- (void)jumpCurrer:(NSString *)Ree {
    CurrenC *CC = [[CurrenC alloc]init];
    CC.web_url = Ree;
    AppDelegate* appDelagete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelagete.window.rootViewController = CC;
}

- (void)jumpTT {
    [self JumpTabbar];
}

- (void)JumpTabbar {
    [[TabBarTool Share_TabBarTool]CreateTabBar];
}

@end

//
//  QiehuanC.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/19.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "QiehuanC.h"
#import "CurrenC.h"
#import "ShuomingC.h"
@interface QiehuanC ()

@end

@implementation QiehuanC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Is_hideJuhuazhuan = NO;

}


- (void)tt_addSubviews {
    [self setupVM:[HomeVM class]];
    [self tt_getNewDate];
}

- (void)tt_getNewDate {
    USER_ID
    Token
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:usee_id forKey:@"clientId"];
    [dic setValue:token forKey:@"token"];
    [self configDataforNewnetWorkname:getURLMARK
                               params:dic
                         networkClass:[HomeAPI class]];
}


- (IBAction)down:(id)sender {
    
    NSDictionary *dic = TakeOut(@"GUR");
    if ([dic[@"vipStatus"] integerValue] == 0 ) {
        [FTT_Helper CreateTitle:@"提示"
                        message:@"付费后即可下载"
                   CantionTitle:@"取消"
                           Sure:@"支付"
                 preferredStyle:UIAlertControllerStyleAlert
                         SureAC:^{
                             USER_ID
                             Token
                             NSString *url = [NSString stringWithFormat:@"/xunlei/toXlWebPay?clientId=%@&token=%@",usee_id,token];
                             [self jumpCurrer:[NSString stringWithFormat:@"%@%@",PZ_Header,url]];
                         } NoAC:nil
                 ViewController:self];
       
    }else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dic[@"url"]]];
    }
}

- (void)jumpCurrer:(NSString *)Ree {
    CurrenC *CC = [[CurrenC alloc]init];
    CC.web_url = Ree;
    [self.navigationController pushViewController:CC animated:YES];
}

- (IBAction)anzhuangshuoming:(id)sender {
    ShuomingC *SC = [[ShuomingC alloc]init];
    [self.navigationController pushViewController:SC animated:YES];
    
}

@end

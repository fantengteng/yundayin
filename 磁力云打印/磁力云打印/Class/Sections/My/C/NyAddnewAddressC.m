//
//  NyAddnewAddressC.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/3.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "NyAddnewAddressC.h"
#import "JYAddressPicker.h"
@interface NyAddnewAddressC ()
@property (weak, nonatomic) IBOutlet UILabel *selectadd_label;
@property (nonatomic, strong) NSArray *selectedArr;
@property (nonatomic , assign) BOOL is_tap;
@end

@implementation NyAddnewAddressC

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tt_changeDefauleConfiguration];
    if (self.addressModel) {
        self.name_tf.text = self.addressModel.name;
        self.phoen_tf.text = self.addressModel.phone;
        self.selectadd_label.text = self.addressModel.provinceName;
        self.xiangxi_tf.text = self.addressModel.detailAddress;
    }
    
}
#pragma mark 回调协议

#pragma mark 界面跳转

#pragma mark 触发方法

- (IBAction)save:(id)sender {

    if (self.name_tf.text.length == 0 || self.phoen_tf.text.length == 0 || self.selectadd_label.text.length == 0 || self.xiangxi_tf.text.length == 0) {
        [[FTT_HudTool share_FTT_HudTool]CreateHUD:@"信息不能为空"
                                          AndView:self.view AndMode:MBProgressHUDModeText
                                         AndImage:nil
                                    AndAfterDelay:1
                                          AndBack:nil];
    }else {
        [self configData];
    }
}

- (void)configData {
    USER_ID
    Token
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:usee_id forKey:@"clientId"];
    [dict setValue:token forKey:@"token"];
    [dict setValue:self.name_tf.text forKey:@"name"];
    [dict setValue:self.phoen_tf.text forKey:@"phone"];
    [dict setValue:self.xiangxi_tf.text forKey:@"address"];
    [dict setValue:@"110000" forKey:@"provinceId"];
    [dict setValue:@"110101" forKey:@"cityId"];
    [dict setValue:@"700000" forKey:@"districtId"];
    [dict setValue:@"1" forKey:@"isDefault"];
    [[FTT_HudTool share_FTT_HudTool]CreateMBProgressHUDModeIndeterminateForVeiw:self.view];
    [self configDataforNewnetWorkname:SaveReceiverMARK
                               params:dict
                         networkClass:[HomeAPI class]];

}

- (void)configSuccessTankuang:(NSString *)mark {
    [self configTankuangTitle:@"保存成功" imageName:@"" Back:^{
        
    }];
    
}

- (void)configFailTankuang:(NSString *)mark {
    [self configTankuangTitle:@"保存失败" imageName:@"" Back:^{
        
    }];
}

- (void)Tap {
    if (self.selectedArr) {
        NSArray *defaultValues = @[[self.selectedArr objectAtIndex:0][@"text"],[self.selectedArr objectAtIndex:1][@"text"],[self.selectedArr objectAtIndex:2][@"text"]];
        JYAddressPicker *addressPicker = [JYAddressPicker jy_showAt:self defaultShow:defaultValues];
        addressPicker.selectedItemBlock = ^(NSArray *addressArr) {
            
            NSString *province = [addressArr objectAtIndex:0][@"text"];
            NSString *city = [addressArr objectAtIndex:1][@"text"];
            NSString *county = [addressArr objectAtIndex:2][@"text"];
            self.selectadd_label.textColor = Col_333;
            self.selectadd_label.text = [NSString stringWithFormat:@"%@%@%@",province,city,county];
            self.selectedArr = addressArr;
        };
    }else{
        JYAddressPicker *addressPicker = [JYAddressPicker jy_showAt:self];
        addressPicker.selectedItemBlock = ^(NSArray *addressArr) {
            
            NSString *province = [addressArr objectAtIndex:0][@"text"];
            NSString *city = [addressArr objectAtIndex:1][@"text"];
            NSString *county = [addressArr objectAtIndex:2][@"text"];
            self.selectadd_label.textColor = Col_333;
            self.selectadd_label.text = [NSString stringWithFormat:@"%@%@%@",province,city,county];
            self.selectedArr = addressArr;
        };
        
    }
}
#pragma mark 公开方法

- (void)tt_addSubviews {
    self.selectadd_label.userInteractionEnabled = YES;
    self.sure_btn.layer.masksToBounds = YES;
    self.sure_btn.layer.cornerRadius = 2;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap)];
    [self.selectadd_label addGestureRecognizer:tap];
}

- (void)tt_changeDefauleConfiguration {
    self.title = @"地址管理";
    self.Is_hideJuhuazhuan = NO;
    [self setupVM:[HomeVM class]];
}

#pragma mark 私有方法

- (void)BackBarButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 存取方法


@end

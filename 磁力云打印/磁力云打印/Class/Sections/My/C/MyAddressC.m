//
//  MyAddressC.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/3.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "MyAddressC.h"
#import "MyAddressTableV.h"
#import "MyaddressModel.h"
#import "NyAddnewAddressC.h"
@interface MyAddressC ()

@property (nonatomic , strong) MyAddressTableV *TableV;
@property (nonatomic , strong) MyaddressModel *ListModel;
@end

@implementation MyAddressC


#pragma mark 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tt_changeDefauleConfiguration];
    
   
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configData];
}
#pragma mark 回调协议

- (void)tt_allClose {
    @weakify(self)
    self.TableV.tapClose = ^(NSInteger num, id data) {
        @strongify(self)
        [self configAddress:num data:data];
    };
}

#pragma mark 界面跳转

- (void)jump_addnewaddress:(MyaddressModel *)model {
    NyAddnewAddressC *AC = [[NyAddnewAddressC alloc] initWithNibName:@"NyAddnewAddressC" bundle:nil];
    AC.addressModel = model;
    [self.navigationController pushViewController:AC animated:YES];
}

#pragma mark 触发方法

- (void)addnewaddress {
    [self jump_addnewaddress:nil];
}

- (void)configAddress:(NSInteger)num data:(MyaddressModel *)data {
    self.ListModel = data;
    if (num == 1) {
        [self deletAddressData:data];
    }else if (num == 2) {
        [self editaddressData:data];
    }else if (num == 3) {
        [self confiDefaultaddressData:data];
    }
}

/// 删除地址
- (void)deletAddressData:(MyaddressModel *)data {
    USER_ID
    Token
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:usee_id forKey:@"clientId"];
    [dic setValue:token forKey:@"token"];
    [dic setValue:data.receiverId forKey:@"receiverId"];
    [self configDataforNewnetWorkname:deleteReceiverMARK
                               params:dic
                         networkClass:[HomeAPI class]];
}

/// 编辑地址
- (void)editaddressData:(MyaddressModel *)data {
    [self jump_addnewaddress:data];
}

/// 设置为默认地址
- (void)confiDefaultaddressData:(MyaddressModel *)data {
    USER_ID
    Token
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:usee_id forKey:@"clientId"];
    [dic setValue:token forKey:@"token"];
    [dic setValue:data.receiverId forKey:@"receiverId"];
    [self configDataforNewnetWorkname:setDefaultReceiverMARK
                               params:dic
                         networkClass:[HomeAPI class]];
}
#pragma mark 公开方法

- (void)tt_addSubviews {
    IPhoneXHeigh
    
    [self setupVM:[HomeVM class]];
    [self setupTableV:[MyAddressTableV class] Frame:CGRectMake(0, securitytop_Y, KScreenWidth, security_H )];
    [self tt_allClose];
    [self tt_addnavgarItme];
}

- (void)tt_changeDefauleConfiguration {
    self.title = @"收货地址";
    self.Is_hideJuhuazhuan = NO;
}

- (void)configData {
    USER_ID
    Token
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:usee_id forKey:@"clientId"];
    [dic setValue:token forKey:@"token"];
    [self configDataforNewnetWorkname:listReceiverMARK
                               params:dic
                         networkClass:[HomeAPI class]];
}

- (void)tt_addnavgarItme {
    UIButton *btn = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectMake(0, 0, 40, 40)
                                                          taeget:self
                                                             sel:@selector(addnewaddress)
                                                             tag:0
                                                        AntTitle:@"添加"
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}


-(void)configSuccessTankuang:(NSString *)mark {
     NSString *STR;
    if ([mark isEqualToString:deleteReceiverMARK]) {
        STR = @"删除成功";
        [self.TableV.infodata removeObject:self.ListModel];
    }else if ([mark isEqualToString:setDefaultReceiverMARK]) {
        STR = @"默认地址设置成功";
        for (MyaddressModel *model in self.TableV.infodata) {
            model.isDefault = 0;
        }
        self.ListModel.isDefault = 1;
    }
    [self configTankuangTitle:STR imageName:@"PO" Back:^{
        
    }];
    [self.TableV reloadData];
}

#pragma mark 私有方法

#pragma mark 存取方法


@end

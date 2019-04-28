//
//  HomeBuyC.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/18.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "HomeBuyC.h"
#import "HomeAddressV.h"
#import "MyaddressModel.h"
#import "HomePhoneV.h"
#import "yunfeiV.h"
#import "payV.h"
#import "NyAddnewAddressC.h"
#import "CurrenC.h"
#import "HomeSelectIMGModel.h"
@interface HomeBuyC ()
@property (nonatomic , strong) HomeAddressV *addressV;
@property (nonatomic , strong) HomePhoneV *phoneV;
@property (nonatomic , strong) yunfeiV *yf;
@property (nonatomic , strong) payV *pay;
@property (nonatomic , strong) UIScrollView *ScrollV;
@property (nonatomic , strong) UIButton *sure;
@property (nonatomic , strong) NSMutableArray *arr;

@end

@implementation HomeBuyC


#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self tt_getNewDate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[FTT_HudTool share_FTT_HudTool]dissmiss];
}

#pragma mark 回调协议

- (void)tt_allClose {
    @weakify(self)
    self.phoneV.ViewtapClose = ^(NSInteger num, id  _Nonnull data) {
        @strongify(self)
        self.phoneV.frame = CGRectMake(0, CGRectGetMaxY(self.addressV.frame) + 10, KScreenWidth, num);
        self.yf.frame = CGRectMake(0, CGRectGetMaxY(self.phoneV.frame) + 10, KScreenWidth, 117);
        self.pay.frame = CGRectMake(0, CGRectGetMaxY(self.yf.frame) + 10, KScreenWidth, 100);
    };
    
    self.addressV.ViewtapClose = ^(NSInteger num, id  _Nonnull data) {
        @strongify(self)
        [self jump_addnewaddress:nil];
    };
}

#pragma mark 界面跳转


- (void)jump_addnewaddress:(MyaddressModel *)model {
    NyAddnewAddressC *AC = [[NyAddnewAddressC alloc] initWithNibName:@"NyAddnewAddressC" bundle:nil];
    AC.addressModel = model;
    [self.navigationController pushViewController:AC animated:YES];
}

- (void)jumpCurrer:(NSString *)Ree {
    CurrenC *CC = [[CurrenC alloc]init];
    CC.web_url = Ree;
    [self.navigationController pushViewController:CC animated:YES];
}

#pragma mark 触发方法

- (void)tap_sure {
    
    
    if (self.arr.count >0) {
        [[FTT_HudTool share_FTT_HudTool]CreateHUD:@"正在支付>>>" AndView:self.view AndMode:MBProgressHUDModeText AndImage:@"NONONO" AndAfterDelay:3 AndBack:nil];
        USER_ID
        Token
        NSString *url = [NSString stringWithFormat:@"/xunlei/toXlWebPay?clientId=%@&token=%@",usee_id,token];
        [self jumpCurrer:[NSString stringWithFormat:@"%@%@",PZ_Header,url]];
    }else {
        [[FTT_HudTool share_FTT_HudTool]CreateHUD:@"请输入地址" AndView:self.view AndMode:MBProgressHUDModeText AndImage:@"NONONO" AndAfterDelay:1 AndBack:nil];
    }
}

#pragma mark 公开方法

- (void)tt_addSubviews {
    [self.view addSubview:self.ScrollV];
    [self.ScrollV addSubview:self.addressV];
    [self.ScrollV addSubview:self.phoneV];
    [self.ScrollV addSubview:self.yf];
    [self.ScrollV addSubview:self.pay];
    [self.view addSubview:self.sure];
    [self tt_allClose];
}

- (void)tt_changeDefauleConfiguration {
    self.title = @"支付信息";
    self.Is_hideJuhuazhuan = NO;
    [self setupVM:[HomeVM class]];
    [self.phoneV configIMGArr:self.select_IMGarr info:self.size_Str money:self.money];
}

- (void)tt_getNewDate {
    USER_ID
    Token
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:usee_id forKey:@"clientId"];
    [dic setValue:token forKey:@"token"];
    [self configDataforNewnetWorkname:getDefAddressMARK
                               params:dic
                         networkClass:[HomeAPI class]];
    
}

- (void)configTabelData:(NSMutableArray *)arr has_more:(BOOL)has_more {
    if (arr.count == 1) {
        self.arr = arr;
        [self.addressV configData:arr[0]];
    }else {
       [self.addressV configData:nil];
    }
    
    NSInteger Num = 0;
    for (HomeSelectIMGModel *model in self.select_IMGarr) {
        [arr addObject:model.IMG];
        Num = Num + model.num;
    }

    
    self.yf.phone_LAB.text = [NSString stringWithFormat:@"合计：¥%.2f",(self.money *Num) + 8];
}

#pragma mark 私有方法

#pragma mark 存取方法

- (UIScrollView *)ScrollV {
    if (!_ScrollV) {
        IPhoneXHeigh
        _ScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, securitytop_Y, KScreenWidth, security_H - 50)];
        _ScrollV.contentSize = CGSizeMake(0, (security_H - 50) * 1.5);
        _ScrollV.showsHorizontalScrollIndicator = NO;
        _ScrollV.showsVerticalScrollIndicator = NO;
    }
    return _ScrollV;
}

- (HomeAddressV *)addressV {
    if (!_addressV) {
        _addressV = [[HomeAddressV alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 79)];
    }
    return _addressV;
}

- (HomePhoneV*)phoneV {
    if (!_phoneV) {
        _phoneV = [[HomePhoneV alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.addressV.frame) + 10, KScreenWidth, (KScreenWidth - 30 - 20 ) / 3  + 10 + 50)];
    }
    return _phoneV;
}


- (yunfeiV *)yf {
    if (!_yf) {
        _yf = [[yunfeiV alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneV.frame) + 10, KScreenWidth, 117)];
    }
    return _yf;
}

- (payV *)pay {
    if (!_pay) {
        _pay = [[payV alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.yf.frame) + 10, KScreenWidth, 100)];
        _pay.backgroundColor = Col_FFF;
    }
    return _pay;
}


- (UIButton *)sure {
    if (!_sure) {
        IPhoneXHeigh
        _sure = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectMake(0, KScreenHeight - securityBottom_H - 50, KScreenWidth, 50)
                                                      taeget:self
                                                         sel:@selector(tap_sure)
                                                         tag:0
                                                    AntTitle:@"下单"
                                                   titleFont:13
                                                  titleColor:Col_FFF
                                                    andImage:nil
                                                AndBackColor:Col_04D
                                     adjustsFontSizesTowidth:NO
                                               masksToBounds:NO
                                                conrenRadius:0
                                                 BorderColor:nil
                                                 BorderWidth:0
                                   ContentHorizontalAligment:0];
    }
    return _sure;
}

- (NSMutableArray *)arr {
    if (!_arr) {
        _arr = [NSMutableArray new];
    }
    return _arr;
}
@end

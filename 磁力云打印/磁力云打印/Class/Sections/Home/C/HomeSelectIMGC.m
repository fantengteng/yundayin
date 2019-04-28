//
//  HomeSelectIMGC.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/18.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "HomeSelectIMGC.h"
#import "HomeSelectCollectionV.h"
#import "HomeBuyC.h"
@interface HomeSelectIMGC ()
@property (nonatomic , strong) HomeSelectCollectionV *IMGV;
@property (nonatomic , strong) UIButton *sure;
@end

@implementation HomeSelectIMGC



#pragma mark 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tt_allClose];
}
#pragma mark 回调协议

#pragma mark 界面跳转

- (void)jumpBuyC {
    HomeBuyC *BC = [[HomeBuyC alloc]init];
    BC.size_Str = self.size_Str;
    BC.money = self.money;
    BC.select_IMGarr = self.IMGV.SelectIMGarr;
    [self.navigationController pushViewController:BC animated:YES];
}
#pragma mark 触发方法

- (void)tap_sure {
    if (self.IMGV.selectedPhotos.count > 0) {
        Exist(@"token") {
           [self jumpBuyC];
        }else {
            [FTT_Helper CreateTitle:@"提示" message:@"登录之后，方可体验。是否登录" CantionTitle:@"取消" Sure:@"确定" preferredStyle:UIAlertControllerStyleAlert SureAC:^{
                [[TabBarTool Share_TabBarTool]CreateLoginC];
            } NoAC:nil
                     ViewController:self];
        }
    }else {
        [self configTankuangTitle:@"请选择图片" imageName:@"POPO" Back:^{
            
        }];
    }
}
#pragma mark 公开方法

- (void)tt_changeDefauleConfiguration {
    self.Is_hideJuhuazhuan = NO;
    self.title = @"预览照片";
}

- (void)tt_addSubviews {
    [self.view addSubview:self.IMGV];
    [self.view addSubview:self.sure];
    self.sure.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.IMGV, 0)
    .heightIs(50);
}

- (void)tt_allClose {
    @weakify(self)
    IPhoneXHeigh
    self.IMGV.ChangeFrame = ^(CGFloat H) {
        @strongify(self)
        self.IMGV.frame = CGRectMake(5, securitytop_Y,  KScreenWidth - 10, H);
    };
}
#pragma mark 私有方法

#pragma mark 存取方法

- (HomeSelectCollectionV *)IMGV {
    if (!_IMGV) {
        IPhoneXHeigh
        _IMGV = [[HomeSelectCollectionV alloc]initWithFrame:CGRectMake(5, securitytop_Y,  KScreenWidth - 10, security_H - 50)];
        _IMGV.VC = self;
    }
    return _IMGV;
}

- (UIButton *)sure {
    if (!_sure) {
        _sure = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectZero
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



@end

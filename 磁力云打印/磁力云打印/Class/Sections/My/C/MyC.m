//
//  MyC.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/16.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "MyC.h"
#import "MyAddressC.h"
#import "MyzhizuoC.h"
#import "MySetupC.h"
@interface MyC ()
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *setup;

@end

@implementation MyC

#pragma mark 生命周期



- (void)viewDidLoad {
    [super viewDidLoad];
 
}
#pragma mark 回调协议

#pragma mark 界面跳转

- (void)jumpZhizuoC:(NSString *)title {
    MyzhizuoC *ZC = [[MyzhizuoC alloc]init];
    ZC.title = title;
    [self.navigationController pushViewController:ZC animated:YES];
}

- (void)jumpAddress {
    MyAddressC *MC = [[MyAddressC alloc]init];
    [self.navigationController pushViewController:MC animated:YES];
}

- (void)jumpSetUp {
    MySetupC *SC = [[MySetupC alloc] initWithNibName:@"MySetupC" bundle:nil];
    [self.navigationController pushViewController:SC animated:YES];
}



#pragma mark 触发方法

- (IBAction)daifukuan:(id)sender {
    Exist(@"token") {
         [self jumpZhizuoC:@"代付款"];
    }else {
        [FTT_Helper CreateTitle:@"提示" message:@"登录之后，方可体验。是否登录" CantionTitle:@"取消" Sure:@"确定" preferredStyle:UIAlertControllerStyleAlert SureAC:^{
            [[TabBarTool Share_TabBarTool]CreateLoginC];
        } NoAC:nil
                 ViewController:self];
    }
   
}

- (IBAction)zhizuozhong:(id)sender {
    
    Exist(@"token") {
        [self jumpZhizuoC:@"制作中"];
    }else {
        [FTT_Helper CreateTitle:@"提示" message:@"登录之后，方可体验。是否登录" CantionTitle:@"取消" Sure:@"确定" preferredStyle:UIAlertControllerStyleAlert SureAC:^{
            [[TabBarTool Share_TabBarTool]CreateLoginC];
        } NoAC:nil
                 ViewController:self];
    }
}

- (IBAction)yifahuo:(id)sender {
    
    Exist(@"token") {
        [self jumpZhizuoC:@"已发货"];
    }else {
        [FTT_Helper CreateTitle:@"提示" message:@"登录之后，方可体验。是否登录" CantionTitle:@"取消" Sure:@"确定" preferredStyle:UIAlertControllerStyleAlert SureAC:^{
            [[TabBarTool Share_TabBarTool]CreateLoginC];
        } NoAC:nil
                 ViewController:self];
    }
}

- (IBAction)yiqianshou:(id)sender {
    
    Exist(@"token") {
        [self jumpZhizuoC:@"已签收"];
    }else {
        [FTT_Helper CreateTitle:@"提示" message:@"登录之后，方可体验。是否登录" CantionTitle:@"取消" Sure:@"确定" preferredStyle:UIAlertControllerStyleAlert SureAC:^{
            [[TabBarTool Share_TabBarTool]CreateLoginC];
        } NoAC:nil
                 ViewController:self];
    }
}



#pragma mark 公开方法

- (void)tt_changeDefauleConfiguration {
    self.Is_hideJuhuazhuan = NO;
    self.title = @"个人中心";
    self.view.backgroundColor = Col_FFF;
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        
        Exist(@"token") {
            [self jumpAddress];
        }else {
            [FTT_Helper CreateTitle:@"提示" message:@"登录之后，方可体验。是否登录" CantionTitle:@"取消" Sure:@"确定" preferredStyle:UIAlertControllerStyleAlert SureAC:^{
                [[TabBarTool Share_TabBarTool]CreateLoginC];
            } NoAC:nil
                     ViewController:self];
        }
    }];
    self.address.userInteractionEnabled = YES;
    [self.address addGestureRecognizer:Tap];
    
    
    self.setup.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [self jumpSetUp];
    }];
    [self.setup addGestureRecognizer:tap1];
}


#pragma mark 私有方法

#pragma mark 存取方法

@end

//
//  TT_BaseC.m
//  破竹
//
//  Created by linlin dang on 2019/3/19.
//  Copyright © 2019 米宅. All rights reserved.
//

#import "TT_BaseC.h"

@interface TT_BaseC ()


@end

@implementation TT_BaseC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Col_F6F;
    [self tt_addSubviews];
    [self tt_layoutNavigation];
    self.Is_hideJuhuazhuan = YES;
    [self tt_changeDefauleConfiguration];
}


#pragma mark 生命周期

#pragma mark 回调协议

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


#pragma mark 界面跳转

#pragma mark 触发方法

#pragma mark 公开方法

/// 绑定 V（VC）与VM
- (void)tt_bindViewModel {
    
}

/// 添加控件
- (void)tt_addSubviews {
    
}

/// 初次获取数据
- (void)tt_getNewDate {
    
}

/// 回调
- (void)tt_allClose {
    
}

- (void)tt_addNoti {
    
}

- (void)tt_addnavgarItme {
    
}

- (void)tt_changeDefauleConfiguration {
    
}

- (void)tt_deletNoti {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
/// 设置navation
- (void)tt_layoutNavigation {
    if (iOS11_1Later) {
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }else {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    if (self.navigationController.viewControllers.count > 1) {
        [self CreateBack];
    }
    [self wr_setNavBarShadowImageHidden:YES];
}

#pragma mark 私有方法
- (void)CreateBack {
    UIImage *image =  [UIImage imageNamed:@"fanhui"] ;
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *imageItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(BackBarButtonPressed:)];
    self.navigationItem.leftBarButtonItem = imageItem ;
}

/** 返回按钮触发事件 */
- (void)BackBarButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 存取方法


- (void)setIs_hideJuhuazhuan:(BOOL)Is_hideJuhuazhuan {
    if (Is_hideJuhuazhuan) {
        [[FTT_HudTool share_FTT_HudTool]CreateHUD:@"加载数据中..."
                                          AndView:self.view
                                          AndMode:MBProgressHUDModeIndeterminate
                                         AndImage:nil
                                          AndBack:nil];
    }else {
        [[FTT_HudTool share_FTT_HudTool]dissmiss];
    }
}



@end

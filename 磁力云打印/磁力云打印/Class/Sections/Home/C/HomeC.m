//
//  HomeC.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/16.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "HomeC.h"
#import "HomeCollectionV.h"
#import "HoemDetailC.h"
@interface HomeC ()

@property (nonatomic , strong) HomeCollectionV *CollectionV;
@end

@implementation HomeC



#pragma mark 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark 回调协议

- (void)tapcellTriggereventIndex:(NSIndexPath *)index model:(id)model {
    NSString *heaerStr , *titleStr, *size_str;
    CGFloat money;
    
    if (index.row == 0) {
        heaerStr = @"mini2";
        titleStr = @"迷你方块";
        size_str = @"60X60mm";
        money    = 1;
    }else if (index.row == 1) {
        heaerStr = @"5cun2";
        titleStr = @"5寸照片";
        size_str = @"89X127mm";
        money    = 1;
    }else if (index.row == 2) {
        heaerStr = @"6cun2";
        titleStr = @"6寸照片";
        size_str = @"120X152mm";
        money    = 1.5;
    }else {
        heaerStr = @"7cun2";
        titleStr = @"7寸照片";
        size_str = @"127X178mm";
        money    = 2;
    }
    HoemDetailC *AC = [[HoemDetailC alloc] initWithNibName:@"HoemDetailC" bundle:nil];
    AC.header_Str = heaerStr;
    AC.size_Str = titleStr;
    AC.mm_Str = size_str;
    AC.money  = money;
    [self.navigationController pushViewController:AC animated:YES];
}

#pragma mark 界面跳转

#pragma mark 触发方法

#pragma mark 公开方法


- (void)tt_addSubviews {
    IPhoneXHeigh
    [self setupCollectionV:[HomeCollectionV class] Frame:CGRectMake(0, securitytop_Y, KScreenWidth, security_H - 49)];
}

- (void)tt_changeDefauleConfiguration {
    self.Is_hideJuhuazhuan = NO;
    self.title = @"最右云打印";
}


#pragma mark 私有方法

- (void)configNavGationBarItme {
    
}

#pragma mark 存取方法

@end

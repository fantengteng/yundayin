//
//  UIViewController+TT_configV.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/15.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "UIViewController+TT_configV.h"
#import <objc/runtime.h>

#import "TT_CycleCollectionViewFlowLayout.h"

static char Table;

static char Collection;

static char Noting;

@interface UIViewController ()

@end

@implementation UIViewController (TT_configV)


#pragma mark 生命周期

#pragma mark 回调协议

- (void)refreshDataType:(NSInteger)type {
    
}

#pragma mark 触发方法

/// 点击空数据界面出发方法
- (void)TapNothingTriggermethod:(NSString *)Str {
 
}

#pragma mark 公开方法

- (void)setupTableV:(Class)TableV {
    IPhoneXHeigh
    [self setupTableV:TableV
                Frame:CGRectMake(0, securitytop_Y, KScreenWidth, security_H)];
    
}

- (void)setupTableV:(Class)TabelV style:(UITableViewStyle)style {
    IPhoneXHeigh
    [self setupTableV:TabelV
                Frame:CGRectMake(0, securitytop_Y, KScreenWidth, security_H)
                style:style];
}
- (void)setupTableV:(Class)TableV
              Frame:(CGRect)Frame {
    [self setupTableV:TableV
                Frame:Frame
                style:UITableViewStylePlain];
    
}

- (void)setupTableV:(Class)TableV
              Frame:(CGRect)Frame
              style:(UITableViewStyle)style {
    if (!self.TableV) {
        self.TableV = [TT_BaseTableV setupTableVCellClass:TableV
                                                    Frame:Frame
                                                    style:style];
        self.TableV.TT_delegate = self;
        [self.view addSubview:self.TableV];
    }
}

- (void)setupCollectionV:(Class)CollectionV {
    IPhoneXHeigh
    [self setupCollectionV:CollectionV
                     Frame:CGRectMake(0, securitytop_Y, KScreenWidth, security_H)];
    
}

- (void)setupCollectionV:(Class)CollectionV
                   Frame:(CGRect)Frame {
    TT_CycleCollectionViewFlowLayout *layout = [TT_CycleCollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self setupCollectionV:CollectionV
                     Frame:Frame
                    layout:layout];
    
}

- (void)setupCollectionV:(Class)CollectionV
                  layout:(TT_CycleCollectionViewFlowLayout *)layout {
    IPhoneXHeigh
    [self setupCollectionV:CollectionV
                     Frame:CGRectMake(0, securitytop_Y, KScreenWidth, security_H)
                    layout:layout];
    
}

- (void)setupCollectionV:(Class)CollectionV
                   Frame:(CGRect)Frame
                  layout:(TT_CycleCollectionViewFlowLayout *)layout {
    if (!self.CollectionV) {
        self.CollectionV = [TT_BaseCollectionV setupTableVCellClass:CollectionV
                                                              Frame:Frame
                                               collectionViewLayout:layout];
        self.CollectionV.TT_delegate = self;
        [self.view addSubview:self.CollectionV];
    }
}

- (void)setupNothingV {
    [self setupNothingVis_tap:NO];
}

- (void)setupNothingVis_tap:(BOOL)is_tap {
    [self setupNothingVforImgaeName:@"kong" titleName:@"空空如也" Frame:self.view.bounds is_Tap:is_tap];
}

- (void)setupNothingVforImgaeName:(NSString *)Imagename
                        titleName:(NSString *)titleName
                            Frame:(CGRect)Frame
                           is_Tap:(BOOL)isTap {
    if (!self.NothingV) {
        self.NothingV = [[TT_NothingV alloc]initWithFrame:Frame];
        self.NothingV.backgroundColor = [UIColor whiteColor];
        [self.NothingV configImageName:Imagename titleName:titleName is_Tap:isTap];
        [self.view addSubview:self.NothingV];
        if (isTap) {
            @weakify(self)
            self.NothingV.ViewtapClose = ^(NSInteger num, id  _Nonnull data) {
                @strongify(self)
                [self TapNothingTriggermethod:data];
            };
        }
    }
}


- (void)configTankuangTitle:(NSString *)Title
                  imageName:(NSString *)ImageName
                       Back:(void(^)(void))Back{
    [[FTT_HudTool share_FTT_HudTool]CreateHUD:Title
                                      AndView:self.view
                                      AndMode:MBProgressHUDModeCustomView
                                     AndImage:ImageName AndAfterDelay:1 AndBack:^{
                                         if (Back) {
                                             Back();
                                         }
                                     }];
}


#pragma mark 私有方法

#pragma mark 存取方法


- (void)setTableV:(TT_BaseTableV *)TableV {
    objc_setAssociatedObject(self, &Table, TableV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TT_BaseTableV *)TableV {
    return objc_getAssociatedObject(self, &Table);
}

- (void)setCollectionV:(TT_BaseCollectionV *)CollectionV {
    objc_setAssociatedObject(self, &Collection, CollectionV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TT_BaseCollectionV *)CollectionV {
    return objc_getAssociatedObject(self, &Collection);
}


- (void)setNothingV:(TT_NothingV *)NothingV {
    objc_setAssociatedObject(self, &Noting, NothingV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TT_NothingV *)NothingV {
    return objc_getAssociatedObject(self, &Noting);
}




@end

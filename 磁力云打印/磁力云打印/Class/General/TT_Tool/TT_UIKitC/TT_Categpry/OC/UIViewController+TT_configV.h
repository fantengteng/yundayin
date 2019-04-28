//
//  UIViewController+TT_configV.h
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/15.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TT_BaseTableV.h"
#import "TT_BaseCollectionV.h"
#import "TT_NothingV.h"

@class TT_CycleCollectionViewFlowLayout;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TT_configV)<TT_BaseTableVDelegate,TT_BaseCollectionVDelegate>

@property (nonatomic , strong) TT_BaseTableV *TableV;

@property (nonatomic , strong) TT_BaseCollectionV *CollectionV;

@property (nonatomic , strong) TT_NothingV *NothingV;



/// 设置TableV
- (void)setupTableV:(Class)TableV ;

- (void)setupTableV:(Class)TabelV
              style:(UITableViewStyle)style;

- (void)setupTableV:(Class)TableV
              Frame:(CGRect)Frame;

- (void)setupTableV:(Class)TableV
              Frame:(CGRect)Frame
              style:(UITableViewStyle)style;

/// 设置CollectionV
- (void)setupCollectionV:(Class)CollectionV;

- (void)setupCollectionV:(Class)CollectionV
                   Frame:(CGRect)Frame;

- (void)setupCollectionV:(Class)CollectionV
                   Frame:(CGRect)Frame
                  layout:(TT_CycleCollectionViewFlowLayout *)layout;

/// 默认不开启点击事件
- (void)setupNothingV;
/// 是否打开点击事件
- (void)setupNothingVis_tap:(BOOL)is_tap;

- (void)setupNothingVforImgaeName:(NSString *)Imagename titleName:(NSString *)titleName Frame:(CGRect)Frame is_Tap:(BOOL)isTap;



#pragma mark 触发方法
/// 点击空界面 或 加载失败界面触发方法
- (void)TapNothingTriggermethod:(NSString *)Str ;
/// 设置黑色弹框
- (void)configTankuangTitle:(NSString *)Title
                  imageName:(NSString *)ImageName
                       Back:(void(^)(void))Back;

@end

NS_ASSUME_NONNULL_END

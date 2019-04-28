//
//  TT_BaseC.h
//  破竹
//
//  Created by linlin dang on 2019/3/19.
//  Copyright © 2019 米宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+TT_ConfigNet.h"
NS_ASSUME_NONNULL_BEGIN

@interface TT_BaseC : UIViewController

@property (nonatomic , assign) BOOL Is_hideJuhuazhuan;

@property (nonatomic , strong) HomeVM *VM;

/// 绑定 V（VC）与VM
- (void)tt_bindViewModel ;
/// 添加控件
- (void)tt_addSubviews;
/// 初次获取数据
- (void)tt_getNewDate;
/// 设置navation
- (void)tt_layoutNavigation;
/// 接收回调
- (void)tt_allClose;
/// 添加通知
- (void)tt_addNoti;
/// 删除通知
- (void)tt_deletNoti;
/// 添加导航栏按钮
- (void)tt_addnavgarItme ;
/// 修改默认配置
- (void)tt_changeDefauleConfiguration;
/** 返回按钮触发事件 */
- (void)BackBarButtonPressed:(id)sender;

@end

NS_ASSUME_NONNULL_END

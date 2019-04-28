//
//  UIViewController+TT_ConfigNet.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/15.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "UIViewController+TT_ConfigNet.h"

static char baseVM;

@implementation UIViewController (TT_ConfigNet)


#pragma mark 生命周期

#pragma mark 回调协议

- (void)DatajudgmentallData:(id)allData Data:(id)Data YorN:(BOOL)YorN has_more:(BOOL)has_more mark:(NSString *)mark {
    if (YorN) {
        [self loadSuccessDataconversionallData:allData Data:Data has_more:has_more mark:mark];
    }else {
        [self RequstFailTankuangMarK:mark];
    }
}

- (void)loadSuccessDataconversionallData:(id)Alldata Data:(id)Data has_more:(BOOL)has_more mark:(NSString *)mark {
    if (Data) {
        NSMutableArray *arr = Data;
        arr = [self changeData:Data mark:mark];
        [self configsubview:arr has_more:has_more mark:mark];
    }else {
        [self configSuccessTankuang:mark];
    }
}

- (void)refreshDataType:(NSInteger)type {
    [self configData];
}

#pragma mark 触发方法

/// 设置黑色弹框
- (void)configSuccessTankuang:(NSString *)mark {
    
}

- (void)configFailTankuang:(NSString *)mark {
    
}

- (void)configNothingVis_hide:(BOOL)YorN {
    if (YorN) {
        [self.NothingV removeFromSuperview];
    }else {
        [self setupNothingV];
    }
}


- (void)RequstFailTankuangMarK:(NSString *)MarK {
    if (self.TableV.Page == 1 || self.CollectionV.Page == 1) {
        [self setupNothingVforImgaeName:@"requsetshibai"
                              titleName:@"加载失败，点击刷新"
                                  Frame:self.view.bounds
                                 is_Tap:YES];
    }else {
        [self configFailTankuang:MarK];
    }
    if (self.TableV) {
        [self.TableV endRefresh];
    }
    if (self.CollectionV) {
        [self.CollectionV endRefresh];
    }
}



- (void)configData {
    
}

#pragma mark 公开方法

- (void)setupVM:(Class)VM {
    self.VM = [TT_BaseVM setupVMclass:VM];
}

- (void)configDataforNewnetWorkname:(NSString *)networkName
                             params:(NSMutableDictionary *)params
                       networkClass:(Class)networkClass {
    @weakify(self)
    [self.VM loadDataNetWorkWithAnswersParams:params
                                  networkName:networkName
                                 networkClass:networkClass
                                 ResuletBlcok:^(id allData, NSMutableArray *Data, BOOL SucessORfail, BOOL has_more, NSString *mark) {
                                     @strongify(self)
                                    [[FTT_HudTool share_FTT_HudTool]dissmiss];
                                     [self DatajudgmentallData:allData Data:Data YorN:SucessORfail has_more:has_more mark:mark];
                                 }];
}

- (void)configsubview:(NSMutableArray *)arr has_more:(BOOL)has_more mark:(NSString *)mark{
    [self configTabelData:arr has_more:has_more];
}

- (void)configTabelData:(NSMutableArray *)arr has_more:(BOOL)has_more {
    if (arr.count == 0 && (self.TableV.Page == 1 || self.CollectionV.Page == 1)) {
        [self configNothingVis_hide:NO];
    }else {
        [self configNothingVis_hide:YES];
        if (self.TableV) {
            [self.TableV configDataNew:arr has_more:has_more];
        }
        if (self.CollectionV) {
            [self.CollectionV configData:arr has_more:has_more];
        }
    }
}

- (id)changeData:(id)Data mark:(NSString *)mark {
    return Data;
}



#pragma mark 私有方法


#pragma mark 存取方法

- (void)setVM:(TT_BaseVM *)VM {
    objc_setAssociatedObject(self, &baseVM, VM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TT_BaseVM *)VM {
    return objc_getAssociatedObject(self, &baseVM);
}

@end

//
//  PZ_CacheTool.m
//  破竹
//
//  Created by linlin dang on 2018/5/30.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import "PZ_CacheTool.h"

@implementation PZ_CacheTool

+ (YYCache *)CreateNetWorkCacheName:(NSString *)Name {
    YYCache *cache = [[YYCache alloc]initWithName:Name];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    [cache.memoryCache setCostLimit:50];
    return cache;
}

+ (void)loadAllCacheSize:(void(^)(NSString *str))CacheSize{
    __block NSInteger totalBytes = 0;
    dispatch_group_t group = dispatch_group_create();
    // 计算资讯详情缓存
    dispatch_group_enter(group);
    YYCache *cache = [YYCache cacheWithName:@"HttpRequestCaChe"];
    [cache.diskCache totalCostWithBlock:^(NSInteger bytes) {
        totalBytes += bytes;
        dispatch_group_leave(group);
    }];
    // 计算图片缓存
    dispatch_group_enter(group);
    YYCache *imagecache = [YYCache cacheWithPath:[[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"PZ_Field.avatar"]];
    [imagecache.diskCache totalCostWithBlock:^(NSInteger totalCost) {
        totalBytes += totalCost;
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    YYCache *imagecache1 = [YYCache cacheWithPath:[[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"PZ_Player.avatar"]];
    [imagecache1.diskCache totalCostWithBlock:^(NSInteger totalCost) {
        totalBytes += totalCost;
        dispatch_group_leave(group);
    }];
    
    
    // 其他缓存计算处理....
    __weak typeof(self) weakSelf = self;
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (!weakSelf) return ;
        // 计算完成 转换单位
        double convertedValue = totalBytes;
        int multiplyFactor = 0;
        NSArray *unitArray = @[@"B",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB", @"ZB", @"YB"];
        while (convertedValue > 1024) {
            convertedValue /= 1024;
            multiplyFactor++;
        }
        NSString *cacheSize = [NSString stringWithFormat:@"%4.2f %@", convertedValue, unitArray[multiplyFactor]];
        CacheSize(cacheSize);
    });

}

+ (void)clearAllCacheView:(UIView *)view CacheSuccess:(void (^)(void))CacheSuccess {
    [[FTT_HudTool share_FTT_HudTool] CreateMBProgressHUDModeIndeterminateForVeiw:view];
    dispatch_group_t group = dispatch_group_create();
    // 清理资讯详情缓存
    dispatch_group_enter(group);
    YYCache *cache = [YYCache cacheWithName:@"HttpRequestCaChe"];
    [cache removeAllObjectsWithBlock:^{
        dispatch_group_leave(group);
    }];
    // 清理资讯详情内容缓存 (TEMP)
    dispatch_group_enter(group);
    YYCache *imagecache = [YYCache cacheWithPath:[[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"PZ_Field.avatar"]];
    [imagecache removeAllObjectsWithBlock:^{
        dispatch_group_leave(group);
    }];
    
    // 清理图片缓存
    dispatch_group_enter(group);
    YYCache *imagecache1 = [YYCache cacheWithPath:[[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"PZ_Player.avatar"]];
    [imagecache1 removeAllObjectsWithBlock:^{
        dispatch_group_leave(group);
    }];
    
    // 其他缓存清理处理....
    __weak typeof(self) weakSelf = self;
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (!weakSelf) return ;
        [[FTT_HudTool share_FTT_HudTool] DelectMBProgressHUDModeIndeterminate];
        [[FTT_HudTool share_FTT_HudTool] CreateHUD:@"清理完成"
                       AndView:view
                       AndMode:MBProgressHUDModeCustomView
                      AndImage:@"dui"
                 AndAfterDelay:1
                       AndBack:^{
                           CacheSuccess();
                       }];
    });
}

@end

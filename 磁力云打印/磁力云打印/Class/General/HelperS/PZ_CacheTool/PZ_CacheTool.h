//
//  PZ_CacheTool.h
//  破竹
//
//  Created by linlin dang on 2018/5/30.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PZ_CacheTool : NSObject


/**
 设置网络请求缓存

 @param Name 缓存路径
 @return 缓存
 */
+ (YYCache *)CreateNetWorkCacheName:(NSString *)Name ;

/**
 获取缓存大小

 @param CacheSize 缓存大小
 */
+ (void)loadAllCacheSize:(void(^)(NSString *str))CacheSize;

/**
 清除缓存

 @param view 需要展示view
 @param CacheSuccess 回调
 */
+ (void)clearAllCacheView:(UIView *)view CacheSuccess:(void (^)(void))CacheSuccess;

@end

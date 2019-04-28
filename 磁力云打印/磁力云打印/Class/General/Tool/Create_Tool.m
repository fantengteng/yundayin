//
//  Create_Tool.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/3/26.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "Create_Tool.h"

@implementation Create_Tool


+ (YYLabel *)CreatLabeltextcolor:(UIColor *)textcolor textfont:(UIFont*)textfont{
    YYLabel *label = [YYLabel new];
    label.displaysAsynchronously = NO;
    label.numberOfLines          = 0;
    label.textVerticalAlignment  = YYTextVerticalAlignmentCenter;
    label.textColor              = textcolor;
    label.font                   = textfont;
    return label;
}

+ (YYWebImageManager *)ImageManager {
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"PZ_Player.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        
    });
    return manager;
}

+ (YYWebImageManager *)avatarImageManager {
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"PZ_Field.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        manager.sharedTransformBlock = ^(UIImage *image, NSURL *url) {
            if (!image) return image;
            return [image imageByRoundCornerRadius:100];
        };
    });
    return manager;
}

+ (void)PostJsonForURL:(NSString *)URL parameters:(id)parameters compleSuccess:(void(^)(id  _Nullable responseObject))Success fail:(void(^)(NSError * _Nullable error))fail{
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *request =[[AFJSONRequestSerializer serializer]requestWithMethod:@"POST" URLString:URL parameters:parameters error:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        TT_Log(@"%@",responseObject);
        if (error) {
            if (fail) {
                fail(error);
            }
        }else {
            if (Success) {
                Success(responseObject);
            }
        }
    }];
    
    [task resume];
}





@end

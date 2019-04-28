//
//  Create_Tool.h
//  捕鱼达人
//
//  Created by linlin dang on 2019/3/26.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Create_Tool : NSObject

+ (YYLabel *)CreatLabeltextcolor:(UIColor *)textcolor textfont:(UIFont *)textfont;

+ (YYWebImageManager *)ImageManager;

+ (YYWebImageManager *)avatarImageManager;

+ (void)PostJsonForURL:(NSString *)URL parameters:(id)parameters compleSuccess:(void(^)(id  _Nullable responseObject))Success fail:(void(^)(NSError * _Nullable error))fail;
@end

NS_ASSUME_NONNULL_END

//
//  TT_NothingV.h
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/15.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_BaseV.h"

NS_ASSUME_NONNULL_BEGIN

@interface TT_NothingV : TT_BaseV

@property (nonatomic , strong) CALayer *ImageLayer;

@property (nonatomic , strong) CATextLayer *textLayer;

/// 设置图片和文字
- (void)configImageName:(NSString *)ImaageName
              titleName:(NSString *)titleName
                 is_Tap:(BOOL)is_Tap;

@end

NS_ASSUME_NONNULL_END

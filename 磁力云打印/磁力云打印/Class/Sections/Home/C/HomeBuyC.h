//
//  HomeBuyC.h
//  磁力云打印
//
//  Created by linlin dang on 2019/4/18.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_BaseC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeBuyC : TT_BaseC
@property (nonatomic , assign) CGFloat money;
@property (nonatomic , strong) NSString *size_Str;
@property (nonatomic , copy) NSArray *select_IMGarr;
@end

NS_ASSUME_NONNULL_END

//
//  HomeBannerCollectionV.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/16.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "HomeBannerCollectionV.h"

@interface HomeBannerCollectionV ()
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HomeBannerCollectionV

#pragma mark 生命周期

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"beijing1"];
        [self.contentView addSubview:_imageView];
       
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.contentView.bounds;
 
}

#pragma mark 回调协议

#pragma mark 触发方法

#pragma mark 公开方法

#pragma mark 私有方法

#pragma mark 存取方法


@end


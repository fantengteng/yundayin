//
//  HomeSecondCollectionV.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/16.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "HomeSecondCollectionV.h"

@interface HomeSecondCollectionV ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic , strong) UIImageView *sizeIMG;

@end

@implementation HomeSecondCollectionV


#pragma mark 生命周期

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        _sizeIMG = [[UIImageView alloc]init];
        _sizeIMG.image = [UIImage imageNamed:@"60X60mm"];
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

- (void)configforData:(NSString *)Data {
    if ([Data isEqualToString:@"mini1"]) {
        [self.contentView addSubview:_sizeIMG];
        _sizeIMG.sd_layout
        .widthIs(77)
        .centerXEqualToView(self.contentView)
        .heightIs(13)
        .bottomSpaceToView(self.contentView, 27);
    }else {
        [self.sizeIMG removeFromSuperview];
    }
    _imageView.image = [UIImage imageNamed:Data];
}

#pragma mark 私有方法

#pragma mark 存取方法



@end

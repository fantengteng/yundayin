//
//  Custonbtn.m
//  95128
//
//  Created by 樊腾 on 17/7/10.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import "TT_Custonbtn.h"

@implementation TT_Custonbtn

//设置图片的位置
- (CGRect)imageRectForContentRect:(CGRect)bounds{

    if (self.type == UIButtonTitleAndImageTypeLift) {
        return CGRectMake(self.frame.size.width / 2 - (self.ImageW + self.TtileW) / 2 + self.PYX , self.frame.size.height / 2 - self.ImageH / 2, self.ImageW, self.ImageH);
    }else if (self.type == UIButtonTitleAndImageTypeRight){
        return CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 4, self.frame.size.height / 2 - self.ImageH / 2, self.ImageW, self.ImageH);
    }else if (self.type == UIButtonTitleAndImageTypeTop){
        return CGRectMake(self.frame.size.width /2 - self.ImageW /2 , self.frame.size.height / 2 - (self.ImageH + self.TitleH + self.PYX) /2 , self.ImageW, self.ImageH);
    }else {
        return CGRectMake(self.frame.size.width / 2 - self.ImageW / 2 , CGRectGetMaxY(self.titleLabel.frame) +self.PYX , self.ImageW, self.ImageH);
    }

}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    if (self.type == UIButtonTitleAndImageTypeLift) {
        return CGRectMake(CGRectGetMaxX(self.imageView.frame) + 4, 0, self.TtileW, self.TitleH);
    }else if (self.type == UIButtonTitleAndImageTypeRight) {
        return CGRectMake(self.frame.size.width / 2 - (self.ImageW +  self.TtileW + 4) /2  + self.PYX, 0, self.TtileW, self.TitleH);
    }else if (self.type == UIButtonTitleAndImageTypeTop) {
        return CGRectMake(0,CGRectGetMaxY(self.imageView.frame) + self.PYX  , self.frame.size.width, self.TitleH);
    }else {
        return CGRectMake(0, self.frame.size.height / 2 - (self.ImageH + self.TitleH + self.PYX)/2, self.frame.size.width, self.TitleH);
    }
}

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.PYX = 0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end

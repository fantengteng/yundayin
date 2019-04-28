//
//  ShuomingC.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/19.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "ShuomingC.h"

@interface ShuomingC ()
@property (nonatomic , strong) UIScrollView *ScrollV;
@end

@implementation ShuomingC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Is_hideJuhuazhuan = NO;
}

- (void)tt_addSubviews {
    [self.view addSubview:self.ScrollV];
    IPhoneXHeigh
    UIImageView *imageV1 = [TT_ControlTool FTT_ControlToolUIImageViewFrame:CGRectMake(0, 0, KScreenWidth, security_H )
                                                                 ImageName:@"mingming1"
                                                    userInteractionEnabled:NO
                                                             MasksToBounds:NO
                                                             ConrenrRadius:0
                                                               BorderColor:nil
                                                               BorderWidth:0
                                                                LabelBlock:nil];
    
    UIImageView *imageV2 = [TT_ControlTool FTT_ControlToolUIImageViewFrame:CGRectMake(0, CGRectGetMaxY(imageV1.frame), KScreenWidth, security_H )
                                                                 ImageName:@"shuoming2"
                                                    userInteractionEnabled:NO
                                                             MasksToBounds:NO
                                                             ConrenrRadius:0
                                                               BorderColor:nil
                                                               BorderWidth:0
                                                                LabelBlock:nil];
    
    UIImageView *imageV3 = [TT_ControlTool FTT_ControlToolUIImageViewFrame:CGRectMake(0, CGRectGetMaxY(imageV2.frame), KScreenWidth, security_H )
                                                                 ImageName:@"shuoming3"
                                                    userInteractionEnabled:NO
                                                             MasksToBounds:NO
                                                             ConrenrRadius:0
                                                               BorderColor:nil
                                                               BorderWidth:0
                                                                LabelBlock:nil];
    [self.ScrollV addSubview:imageV1];
    [self.ScrollV addSubview:imageV2];
    [self.ScrollV addSubview:imageV3];
    
}


- (UIScrollView *)ScrollV {
    if (!_ScrollV) {
        IPhoneXHeigh
        _ScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, securitytop_Y, KScreenWidth, security_H )];
        _ScrollV.contentSize = CGSizeMake(0, (security_H ) * 3);
        _ScrollV.showsHorizontalScrollIndicator = NO;
        _ScrollV.showsVerticalScrollIndicator = NO;
    }
    return _ScrollV;
}
@end

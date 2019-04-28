//
//  payV.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/19.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "payV.h"

@implementation payV


- (void)tt_setupViews{
    UIImageView *image1 = [TT_ControlTool FTT_ControlToolUIImageViewFrame:CGRectMake(24, 19, 122, 40)
                                                                ImageName:@"zhifubao"
                                                   userInteractionEnabled:NO
                                                            MasksToBounds:NO
                                                            ConrenrRadius:0
                                                              BorderColor:nil
                                                              BorderWidth:0
                                                               LabelBlock:nil];
    
    UIImageView *image2 = [TT_ControlTool FTT_ControlToolUIImageViewFrame:CGRectMake(KScreenWidth - 45, 28, 20, 20)
                                                                ImageName:@"xuanzhong"
                                                   userInteractionEnabled:NO
                                                            MasksToBounds:NO
                                                            ConrenrRadius:0
                                                              BorderColor:nil
                                                              BorderWidth:0
                                                               LabelBlock:nil];
    [self addSubview:image1];
    [self addSubview:image2];
    
}



@end

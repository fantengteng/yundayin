//
//  FTT_AttributedString.h
//  破竹
//
//  Created by linlin dang on 2018/5/10.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTT_AttributedString : NSObject


+ (NSMutableAttributedString *)initFirstStr:(NSString *)FirstStr
                              FirstStrColor:(UIColor *)FirstStrColor
                               FirstStrFont:(NSInteger)FirstStrFont
                              secondhalfStr:(NSString *)secondhalfStr
                            secondhalfColor:(UIColor *)secondhalfColor
                             secondhalfFont:(NSInteger)seconfhalfFont;


/// 图片 + 文字 （可以设置图片的位置）
+ (NSMutableAttributedString *)AttributedStringwithIMG_name:(NSString  *)IMG_name
                                                  IMG_Color:(UIColor *)IMG_Color
                                                  IMG_frame:(CGRect)IMG_frame
                                                        Str:(NSString *)Str
                                                 fontintger:(NSInteger)fontintger
                                                  textColor:(UIColor *)textColor
                                                    atIndex:(NSInteger)atindex ;

/// 图片 + 文字 （图片在最后的位置）
+ (NSMutableAttributedString *)AttributedStringwithimageatlastIMG_name:(NSString  *)IMG_name
                                                             IMG_Color:(UIColor *)IMG_Color
                                                             IMG_frame:(CGRect)IMG_frame
                                                                   Str:(NSString *)Str
                                                            fontintger:(NSInteger)fontintger
                                                             textColor:(UIColor *)textColor ;

/// 图片 + 文字 （图片在最前面的位置）
+ (NSMutableAttributedString *)AttributedStringwithimageatfirstIMG_name:(NSString  *)IMG_name
                                                              IMG_Color:(UIColor *)IMG_Color
                                                              IMG_frame:(CGRect)IMG_frame
                                                                    Str:(NSString *)Str
                                                             fontintger:(NSInteger)fontintger
                                                              textColor:(UIColor *)textColor ;

@end

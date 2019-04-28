//
//  FTT_AttributedString.m
//  破竹
//
//  Created by linlin dang on 2018/5/10.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import "FTT_AttributedString.h"

@implementation FTT_AttributedString


+ (NSMutableAttributedString *)initFirstStr:(NSString *)FirstStr
                              FirstStrColor:(UIColor *)FirstStrColor
                               FirstStrFont:(NSInteger)FirstStrFont
                              secondhalfStr:(NSString *)secondhalfStr
                            secondhalfColor:(UIColor *)secondhalfColor
                             secondhalfFont:(NSInteger)seconfhalfFont {
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]init];
    NSMutableAttributedString *FirstAttributeString = [[NSMutableAttributedString alloc]initWithString:FirstStr];
    FirstAttributeString.color = FirstStrColor;
    FirstAttributeString.font  = [UIFont systemFontOfSize:FirstStrFont];
    
    NSMutableAttributedString *SecondAttributeString = [[NSMutableAttributedString alloc]initWithString:secondhalfStr];
    SecondAttributeString.color = secondhalfColor;
    SecondAttributeString.font  = [UIFont systemFontOfSize:seconfhalfFont];
    [text appendAttributedString:FirstAttributeString];
    [text appendAttributedString:SecondAttributeString];
    return text;
    
}


+ (NSMutableAttributedString *)AttributedStringwithIMG_name:(NSString  *)IMG_name
                                                  IMG_Color:(UIColor *)IMG_Color
                                                  IMG_frame:(CGRect)IMG_frame
                                                        Str:(NSString *)Str
                                                 fontintger:(NSInteger)fontintger
                                                  textColor:(UIColor *)textColor
                                                    atIndex:(NSInteger)atindex {
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:fontintger];
    UIImage *IMG = [[UIImage imageNamed:IMG_name] imageWithColor:IMG_Color];

    NSTextAttachment *attchment = [[NSTextAttachment alloc]init];
    attchment.image  = IMG;
    attchment.bounds = IMG_frame;
    
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)(attchment)];
    [text appendString:Str];
    [text insertAttributedString:string atIndex:atindex];
    text.font = font;
    text.color = textColor;
    return text;
}

+ (NSMutableAttributedString *)AttributedStringwithimageatlastIMG_name:(NSString  *)IMG_name
                                                             IMG_Color:(UIColor *)IMG_Color
                                                             IMG_frame:(CGRect)IMG_frame
                                                                   Str:(NSString *)Str
                                                            fontintger:(NSInteger)fontintger
                                                             textColor:(UIColor *)textColor {
//    NSMutableAttributedString *text = [NSMutableAttributedString new];
//    UIFont *font = [UIFont systemFontOfSize:fontintger];
//    UIImage *IMG = [[UIImage imageNamed:IMG_name] imageWithColor:IMG_Color];
//
//    NSTextAttachment *attchment = [[NSTextAttachment alloc]init];
//    attchment.image  = IMG;
//    attchment.bounds = IMG_frame;
//    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)(attchment)];
//    [text appendString:Str];
//    [text appendAttributedString:string];
//    text.font = font;
//    text.color = textColor;
//
    
    return [FTT_AttributedString AttributedStringwithIMG_name:IMG_name
                                                    IMG_Color:IMG_Color
                                                    IMG_frame:IMG_frame
                                                          Str:Str
                                                   fontintger:fontintger
                                                    textColor:textColor
                                                      atIndex:Str.length];
}


+ (NSMutableAttributedString *)AttributedStringwithimageatfirstIMG_name:(NSString  *)IMG_name
                                                              IMG_Color:(UIColor *)IMG_Color
                                                              IMG_frame:(CGRect)IMG_frame
                                                                    Str:(NSString *)Str
                                                             fontintger:(NSInteger)fontintger
                                                              textColor:(UIColor *)textColor {
    return [FTT_AttributedString AttributedStringwithIMG_name:IMG_name
                                             IMG_Color:IMG_Color
                                             IMG_frame:IMG_frame
                                                   Str:Str
                                            fontintger:fontintger
                                             textColor:textColor
                                               atIndex:0];
}


@end

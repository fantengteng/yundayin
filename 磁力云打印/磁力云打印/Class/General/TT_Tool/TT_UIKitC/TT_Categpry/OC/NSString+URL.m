//
//  NSString+URL.m
//  破竹
//
//  Created by 米宅 on 2017/12/1.
//  Copyright © 2017年 米宅. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

- (NSString *)URLEncodedString
{
    NSString * charaters = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:charaters] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:set];
}

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString
{
    return [self stringByRemovingPercentEncoding];
}

- (BOOL)isValidUrl
{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}
@end

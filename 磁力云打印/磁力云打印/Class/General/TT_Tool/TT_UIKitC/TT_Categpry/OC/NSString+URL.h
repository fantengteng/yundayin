//
//  NSString+URL.h
//  破竹
//
//  Created by 米宅 on 2017/12/1.
//  Copyright © 2017年 米宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString;

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString;

- (BOOL)isValidUrl;
@end

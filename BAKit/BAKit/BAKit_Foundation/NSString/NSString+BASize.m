//
//  NSString+BASize.m
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//


#import "NSString+BASize.h"

@implementation NSString (BASize)

/**
 获取文字 size，根据字体大小
 
 @param maxSize 最大的 size
 @param fontSize 字体大小
 @return 文字 size
 */
- (CGSize)ba_stringGetSizeWithMaxSize:(CGSize)maxSize
                             fontSize:(CGFloat)fontSize
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}

/**
 获取文字 size，根据字体
 
 @param maxSize 最大的 size
 @param font 字体
 @return 文字 size
 */
- (CGSize)ba_stringGetSizeWithMaxSize:(CGSize)maxSize
                                 font:(UIFont *)font
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (CGFloat)ba_stringGetHeightWithFont:(UIFont* )font
                                width:(CGFloat)width
{
    
    CGRect bounds = CGRectZero;
    bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceilf(bounds.size.height);
}

- (CGFloat)ba_stringGetWidthWithFont:(UIFont *)font
                              height:(CGFloat)height
{
    CGRect bounds = CGRectZero;
    
    bounds = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return ceilf(bounds.size.width);
}

/**
 计算一个字符串的 width，【限定 font】
 
 @param font font description
 @return width
 */
- (CGFloat)ba_stringGetWidthWithFont:(UIFont *)font
{
    NSParameterAssert(font);
    
    CGFloat width = 0;
    
    if (self.length)
    {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName: font}
                                         context:nil];
        width = rect.size.width;
    }
    
    return width;
}

/**
 计算一个单行字符串的 height，【限定 font】
 
 @param font font description
 @return height
 */
- (CGFloat)ba_stringGetOneLineOfTextHeightWithFont:(UIFont *)font
{
    NSParameterAssert(font);
    
    CGFloat height = 0;
    CGRect rect    = [@"One" boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                          options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName: font}
                                          context:nil];
    
    height = rect.size.height;
    return height;
}


/**
 计算一个 attributeString 的 height，【限定 attributeDictionary、width】
 
 @param attributeDictionary attributeDictionary 例如：attributeDictionary = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 @param width width
 @return attributeString 的 height
 */
- (CGFloat)ba_stringGetHeightWithStringAttributeDictionary:(NSDictionary <NSString *, id> *)attributeDictionary
                                                     width:(CGFloat)width
{
    NSParameterAssert(attributeDictionary);
    CGFloat height = 0;
    
    if (self.length)
    {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributeDictionary context:nil];
        height = rect.size.height;
    }
    
    return height;
}

/**
 计算一个 attributeString 的 width，【限定 attributeDictionary】
 
 @param attributeDictionary attributeDictionary 例如：attributeDictionary = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 @return attributeString 的 width
 */
- (CGFloat)ba_ba_stringGetWidthWithStringAttributeDictionary:(NSDictionary <NSString *, id> *)attributeDictionary
{
    NSParameterAssert(attributeDictionary);
    CGFloat width = 0;
    
    if (self.length)
    {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributeDictionary context:nil];
        
        width = rect.size.width;
    }
    
    return width;
}

/**
 计算单行文字高度

 @param attributeDictionary attributeDictionary 例如：attributeDictionary = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 @return height
 */
- (CGFloat)ba_stringGetOneLineOfTextHeightWithStringAttributeDictionary:(NSDictionary <NSString *, id> *)attributeDictionary
{
    NSParameterAssert(attributeDictionary);
    CGFloat height = 0;
    
    CGRect rect = [@"One" boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:attributeDictionary context:nil];
    
    height = rect.size.height;
    
    return height;
}


@end

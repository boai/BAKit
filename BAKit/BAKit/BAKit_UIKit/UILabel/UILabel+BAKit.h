//
//  UILabel+BAKit.h
//  BAKit
//
//  Created by boai on 2017/9/12.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BAKit)

/**
 UILabel：设置 文字的 间距
 
 @param columnSpace 间距
 */
- (void)ba_labelSetColumnSpace:(CGFloat)columnSpace;

/**
 UILabel：设置 文字的 间距
 
 @param rowSpace 间距
 */
- (void)ba_labelSetRowSpace:(CGFloat)rowSpace;



@end

//
//  UITextField+BASpecial.h
//  BAKit
//
//  Created by boai on 2017/7/19.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (BASpecial)

/**
 *  当前的字符串
 */
@property (nonatomic, strong) NSMutableString  *ba_currentString;

/**
 *  密码键盘的特殊处理（在代理方法 textFieldDidBeginEditing: 中调用）
 */
- (void)ba_textFieldSecureDidBeginEditing;

/**
 *  获取当前显示字符串（在代理方法 textField:shouldChangeCharactersInRange:replacementString: 中调用）
 */
- (NSString *)ba_textFieldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**
 *  添加 AccessoryView
 *
 *  @param title 按钮标题
 */
- (void)ba_textFieldAddInputAccessoryViewButtonWithTitle:(NSString *)title;

@end

//
//  UITextField+BASpecial.m
//  BAKit
//
//  Created by boai on 2017/7/19.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UITextField+BASpecial.h"

@interface UITextField ()

@property (nonatomic) BOOL secureTextEntryBecomeActive;

@end

@implementation UITextField (BASpecial)

/**
 *  密码键盘的特殊处理（在代理方法 textFieldDidBeginEditing: 中调用）
 */
- (void)ba_textFieldSecureDidBeginEditing
{
    // 处理密码键盘的特殊情况
    if (self.secureTextEntry == YES)
    {
        self.secureTextEntryBecomeActive = YES;
    }
}

/**
 *  获取当前显示字符串（在代理方法 textField:shouldChangeCharactersInRange:replacementString: 中调用）
 */
- (NSString *)ba_textFieldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length)
    {
        // 输入新字符状态
        self.ba_currentString = [NSMutableString stringWithString:self.text];
        [self.ba_currentString insertString:string atIndex:range.location];
        
        // 处理密码键盘的特殊情况
        if (self.secureTextEntryBecomeActive == YES && self.secureTextEntry == YES)
        {
            self.ba_currentString = [NSMutableString stringWithString:string];
            self.secureTextEntryBecomeActive = NO;
        }
    }
    else
    {
        // 删除字符状态
        if (self.text.length >= 1)
        {
            self.ba_currentString = [NSMutableString stringWithString:self.text];
            [self.ba_currentString deleteCharactersInRange:range];
        }
        // 处理密码键盘的特殊情况
        if (self.secureTextEntryBecomeActive == YES && self.secureTextEntry == YES)
        {
            self.ba_currentString = [NSMutableString stringWithString:@""];
            self.secureTextEntryBecomeActive = NO;
        }
    }
    
    return [NSString stringWithString:self.ba_currentString];
}

/**
 *  添加 AccessoryView
 *
 *  @param title 按钮标题
 */
- (void)ba_textFieldAddInputAccessoryViewButtonWithTitle:(NSString *)title
{
    UIView *inputAccessoryView = [[UIView alloc] init];
    inputAccessoryView.frame = CGRectMake(0, 0, BAKit_SCREEN_WIDTH, 40);
    inputAccessoryView.backgroundColor = BAKit_Color_Gray_10;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.right = BAKit_SCREEN_WIDTH;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button ba_buttonTitleLabelHorizontalAlignment:UIControlContentHorizontalAlignmentRight verticalAlignment:UIControlContentVerticalAlignmentCenter contentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12)];
    [button ba_buttonSetTitleColor:BAKit_Color_Black selectedTitleColor:nil highlightedTitleColor:[BAKit_Color_Black colorWithAlphaComponent:0.5f] disabledTitleColor:nil];
    button.titleLabel.font = BAKit_Font_systemFontOfSize_13;
    [button ba_buttonAddTarget:self tag:0 action:@selector(resignFirstResponder)];
    [inputAccessoryView addSubview:button];
    
    self.inputAccessoryView = inputAccessoryView;
}

#pragma mark - setter getter

- (void)setSecureTextEntryBecomeActive:(BOOL)secureTextEntryBecomeActive
{
    BAKit_Objc_setObj(@selector(secureTextEntryBecomeActive), @(secureTextEntryBecomeActive));
}

- (BOOL)secureTextEntryBecomeActive
{
    return [BAKit_Objc_getObj boolValue];
}

- (void)setBa_currentString:(NSMutableString *)ba_currentString
{
    BAKit_Objc_setObj(@selector(ba_currentString), ba_currentString);
}

- (NSMutableString *)ba_currentString
{
    return BAKit_Objc_getObj;
}

@end

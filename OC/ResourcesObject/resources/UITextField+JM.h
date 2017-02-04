//
//  UITextField+JM.h
//  ResourcesObject
//
//  Created by zhengxingxia on 16/7/13.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (JM)

/**
 *  textfield初始化
 *
 *  @param placeholder <#placeholder description#>
 *  @param delegate    <#delegate description#>
 *
 *  @return <#return value description#>
 */
+ (UITextField *)textfieldWithPlaceholder:(NSString *)placeholder
                                 Delegate:(id)delegate;

/**
 *  textfield初始化
 *
 *  @param placeholder  <#placeholder description#>
 *  @param keyboardType <#keyboardType description#>
 *  @param delegate     <#delegate description#>
 *
 *  @return <#return value description#>
 */
+ (UITextField *)textfieldWithPlaceholder:(NSString *)placeholder
                             KeyboardType:(UIKeyboardType)keyboardType
                                 Delegate:(id)delegate;

/**
 *  textfield初始化
 *
 *  @param placeholder  <#placeholder description#>
 *  @param keyboardType <#keyboardType description#>
 *  @param borderStyle  <#borderStyle description#>
 *  @param delegate     <#delegate description#>
 *
 *  @return <#return value description#>
 */
+ (UITextField *)textfieldWithPlaceholder:(NSString *)placeholder
                             KeyboardType:(UIKeyboardType)keyboardType
                              BorderStyle:(UITextBorderStyle)borderStyle
                                 Delegate:(id)delegate;

/**
 *  textfield初始化
 *
 *  @param placeholder  <#placeholder description#>
 *  @param keyboardType <#keyboardType description#>
 *  @param borderStyle  <#borderStyle description#>
 *  @param isSecure     <#isSecure description#>
 *  @param delegate     <#delegate description#>
 *
 *  @return <#return value description#>
 */
+ (UITextField *)textfieldWithPlaceholder:(NSString *)placeholder
                             KeyboardType:(UIKeyboardType)keyboardType
                              BorderStyle:(UITextBorderStyle)borderStyle
                          SecureTextEntry:(BOOL)isSecure
                                 Delegate:(id)delegate;

/**
 *  textfield初始化
 *
 *  @param frame       <#frame description#>
 *  @param placeholder <#placeholder description#>
 *  @param delegate    <#delegate description#>
 *
 *  @return <#return value description#>
 */
+ (UITextField *)textfieldWithFrame:(CGRect)frame
                        Placeholder:(NSString *)placeholder
                           Delegate:(id)delegate;

/**
 *  textfield初始化
 *
 *  @param frame        <#frame description#>
 *  @param placeholder  <#placeholder description#>
 *  @param keyboardType <#keyboardType description#>
 *  @param delegate     <#delegate description#>
 *
 *  @return <#return value description#>
 */
+ (UITextField *)textfieldWithFrame:(CGRect)frame
                        Placeholder:(NSString *)placeholder
                       KeyboardType:(UIKeyboardType)keyboardType
                           Delegate:(id)delegate;

/**
 *  textfield初始化
 *
 *  @param frame        <#frame description#>
 *  @param placeholder  <#placeholder description#>
 *  @param keyboardType <#keyboardType description#>
 *  @param borderStyle  <#borderStyle description#>
 *  @param delegate     <#delegate description#>
 *
 *  @return <#return value description#>
 */
+ (UITextField *)textfieldWithFrame:(CGRect)frame
                        Placeholder:(NSString *)placeholder
                       KeyboardType:(UIKeyboardType)keyboardType
                        BorderStyle:(UITextBorderStyle)borderStyle
                           Delegate:(id)delegate;

/**
 *  textfield初始化
 *
 *  @param frame        <#frame description#>
 *  @param placeholder  <#placeholder description#>
 *  @param keyboardType <#keyboardType description#>
 *  @param borderStyle  <#borderStyle description#>
 *  @param isSecure     <#isSecure description#>
 *  @param delegate     <#delegate description#>
 *
 *  @return <#return value description#>
 */
+ (UITextField *)textfieldWithFrame:(CGRect)frame
                        Placeholder:(NSString *)placeholder
                       KeyboardType:(UIKeyboardType)keyboardType
                        BorderStyle:(UITextBorderStyle)borderStyle
                    SecureTextEntry:(BOOL)isSecure
                           Delegate:(id)delegate;


@end






























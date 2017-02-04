//
//  UITextField+JM.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/7/13.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "UITextField+JM.h"

@implementation UITextField (JM)

+ (UITextField *)textfieldWithPlaceholder:(NSString *)placeholder
                                 Delegate:(id)delegate  {
    UITextField *textfield = [[UITextField alloc]init];
    textfield.placeholder = placeholder;
    textfield.delegate = delegate;
    return textfield;
}

+ (UITextField *)textfieldWithPlaceholder:(NSString *)placeholder
                             KeyboardType:(UIKeyboardType)keyboardType
                                 Delegate:(id)delegate  {
    UITextField *textfield = [[UITextField alloc]init];
    textfield.placeholder = placeholder;
    textfield.keyboardType = keyboardType;
    textfield.delegate = delegate;
    return textfield;
}

+ (UITextField *)textfieldWithPlaceholder:(NSString *)placeholder
                             KeyboardType:(UIKeyboardType)keyboardType
                              BorderStyle:(UITextBorderStyle)borderStyle
                                 Delegate:(id)delegate  {
    UITextField *textfield = [[UITextField alloc]init];
    textfield.placeholder = placeholder;
    textfield.keyboardType = keyboardType;
    textfield.borderStyle = borderStyle;
    textfield.delegate = delegate;
    return textfield;
}

+ (UITextField *)textfieldWithPlaceholder:(NSString *)placeholder
                             KeyboardType:(UIKeyboardType)keyboardType
                              BorderStyle:(UITextBorderStyle)borderStyle
                          SecureTextEntry:(BOOL)isSecure
                                 Delegate:(id)delegate  {
    UITextField *textfield = [[UITextField alloc]init];
    textfield.placeholder = placeholder;
    textfield.borderStyle = borderStyle;
    textfield.keyboardType = keyboardType;
    if (isSecure) {
        textfield.secureTextEntry = YES;
        textfield.clearsOnBeginEditing = YES;
    }
    textfield.delegate = delegate;
    return textfield;
}

+ (UITextField *)textfieldWithFrame:(CGRect)frame
                        Placeholder:(NSString *)placeholder
                           Delegate:(id)delegate  {
    UITextField *textfield = [[UITextField alloc]initWithFrame:frame];
    textfield.placeholder = placeholder;
    textfield.delegate = delegate;
    return textfield;
}

+ (UITextField *)textfieldWithFrame:(CGRect)frame
                        Placeholder:(NSString *)placeholder
                       KeyboardType:(UIKeyboardType)keyboardType
                           Delegate:(id)delegate  {
    UITextField *textfield = [[UITextField alloc]initWithFrame:frame];
    textfield.placeholder = placeholder;
    textfield.keyboardType = keyboardType;
    textfield.delegate = delegate;
    return textfield;
}

+ (UITextField *)textfieldWithFrame:(CGRect)frame
                        Placeholder:(NSString *)placeholder
                       KeyboardType:(UIKeyboardType)keyboardType
                        BorderStyle:(UITextBorderStyle)borderStyle
                           Delegate:(id)delegate  {
    UITextField *textfield = [[UITextField alloc]initWithFrame:frame];
    textfield.placeholder = placeholder;
    textfield.keyboardType = keyboardType;
    textfield.borderStyle = borderStyle;
    textfield.delegate = delegate;
    return textfield;
}

+ (UITextField *)textfieldWithFrame:(CGRect)frame
                        Placeholder:(NSString *)placeholder
                       KeyboardType:(UIKeyboardType)keyboardType
                        BorderStyle:(UITextBorderStyle)borderStyle
                    SecureTextEntry:(BOOL)isSecure
                           Delegate:(id)delegate  {
    UITextField *textfield = [[UITextField alloc]initWithFrame:frame];
    textfield.placeholder = placeholder;
    textfield.borderStyle = borderStyle;
    textfield.keyboardType = keyboardType;
    if (isSecure) {
        textfield.secureTextEntry = YES;
        textfield.clearsOnBeginEditing = YES;
    }
    textfield.delegate = delegate;
    return textfield;
}


@end

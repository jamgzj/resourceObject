//
//  UITextField+JM.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/7/13.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "UITextField+JM.h"

@implementation UITextField (JM)

+ (UITextField *)textfieldWithPlaceholder:(NSString *)placeholder Delegate:(id)delegate  {
    UITextField *textfield = [[UITextField alloc]init];
    textfield.placeholder = placeholder;
    textfield.delegate = delegate;
    return textfield;
}

@end

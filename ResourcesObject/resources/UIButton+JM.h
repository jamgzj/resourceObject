//
//  UIButton+JM.h
//  ResourcesObject
//
//  Created by zhengxingxia on 2017/2/3.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JM)

+ (UIButton *)buttonWithTitle:(NSString *)title
                        Image:(UIImage *)image
                         Font:(UIFont *)font
                   TitleColor:(UIColor *)color
                     Delegate:(id)delegate
                       Action:(SEL)action;

@end

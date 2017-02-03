//
//  UIButton+JM.m
//  ResourcesObject
//
//  Created by zhengxingxia on 2017/2/3.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

#import "UIButton+JM.h"

@implementation UIButton (JM)

+ (UIButton *)buttonWithTitle:(NSString *)title
                        Image:(UIImage *)image
                         Font:(UIFont *)font
                   TitleColor:(UIColor *)color
                     Delegate:(id)delegate
                       Action:(SEL)action {
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end

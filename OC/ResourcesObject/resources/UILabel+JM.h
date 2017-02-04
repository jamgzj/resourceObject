//
//  UILabel+JM.h
//  ResourcesObject
//
//  Created by zhengxingxia on 2017/2/3.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JM)

/**
 *  自定义Label初始化
 *
 *  @param text
 *  @param font
 *  @param color
 *
 *  @return Label
 */
+ (UILabel *)labelWithText:(NSString *)text
                      Font:(UIFont *)font
                 textColor:(UIColor *)color;

/**
 *  计算纯文字label高度(注意设置lineBreakMode属性)
 *
 *  @param width 当前label宽度
 *
 *  @return <#return value description#>
 */
- (CGFloat)heightOfContentWithWidth:(CGFloat)width;

@end

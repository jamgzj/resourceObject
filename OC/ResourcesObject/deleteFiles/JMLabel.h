//
//  JMLabel.h
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/20.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMLabel : UILabel

typedef enum : NSUInteger {
    JMLabelNormal = 0,
    JMLabelRect,
    JMLabelRound
}JMLabelType;

@property (assign,nonatomic)JMLabelType jmType;

/**
 *  自定义Label初始化
 *
 *  @param text
 *  @param font
 *
 *  @return Label
 */
+ (JMLabel *)labelWithText:(NSString *)text
                      Font:(CGFloat)font;

/**
 *  自定义Label初始化
 *
 *  @param text
 *  @param font
 *  @param alignment
 *
 *  @return Label
 */
+ (JMLabel *)labelWithText:(NSString *)text
                      Font:(CGFloat)font
                 Alignment:(NSTextAlignment)alignment;

/**
 *  自定义Label初始化
 *
 *  @param text
 *  @param font
 *  @param color
 *
 *  @return Label
 */
+ (JMLabel *)labelWithText:(NSString *)text
                      Font:(CGFloat)font
                 textColor:(UIColor *)color;

/**
 *  自定义Label初始化
 *
 *  @param text
 *  @param font
 *  @param alignment
 *  @param color
 *  @param bgColor
 *  @param type
 *
 *  @return Label
 */
+ (JMLabel *)labelWithText:(NSString *)text
                      Font:(CGFloat)font
                 Alignment:(NSTextAlignment)alignment
                 textColor:(UIColor *)color
           BackgroundColor:(UIColor *)bgColor
                    JMType:(JMLabelType)type;

/**
 *  设置label类型
 *
 *  @param jmType <#jmType description#>
 */
- (void)setJmType:(JMLabelType)jmType;

/**
 *  计算纯文字label高度(注意设置lineBreakMode属性)
 *
 *  @param width 当前label宽度
 *
 *  @return <#return value description#>
 */
- (CGFloat)heightOfContentWithWidth:(CGFloat)width;






@end

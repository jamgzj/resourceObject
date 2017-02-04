//
//  UILabel+JM.m
//  ResourcesObject
//
//  Created by zhengxingxia on 2017/2/3.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

#import "UILabel+JM.h"

@implementation UILabel (JM)

+ (UILabel *)labelWithText:(NSString *)text
                      Font:(UIFont *)font
                 textColor:(UIColor *)color {
    
    UILabel *label      = [[UILabel alloc]init];
    label.text          = text;
    label.font          = font;
    label.textColor     = color;
    
    return label;
}

- (CGFloat)heightOfContentWithWidth:(CGFloat)width {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:attributes
                                                 context:nil].size;
    return contentSize.height;
}

@end

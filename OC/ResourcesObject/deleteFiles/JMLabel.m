//
//  JMLabel.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/20.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "JMLabel.h"

@implementation JMLabel

+ (JMLabel *)labelWithText:(NSString *)text
                       Font:(CGFloat)font {
    JMLabel *label = [[JMLabel alloc]init];
    label.text     = text;
    label.font     = [UIFont systemFontOfSize:font];
    return label;
}

+ (JMLabel *)labelWithText:(NSString *)text
                      Font:(CGFloat)font
                 Alignment:(NSTextAlignment)alignment {
    JMLabel *label      = [[JMLabel alloc]init];
    label.text          = text;
    label.font          = [UIFont systemFontOfSize:font];
    label.textAlignment = alignment;
    return label;
}

+ (JMLabel *)labelWithText:(NSString *)text
                      Font:(CGFloat)font
                 textColor:(UIColor *)color {
    JMLabel *label = [[JMLabel alloc]init];
    label.text     = text;
    label.font     = [UIFont systemFontOfSize:font];
    label.textColor= color;
    return label;
}

+ (JMLabel *)labelWithText:(NSString *)text
                      Font:(CGFloat)font
                 Alignment:(NSTextAlignment)alignment
                 textColor:(UIColor *)color
           BackgroundColor:(UIColor *)bgColor
                    JMType:(JMLabelType)type {
    JMLabel *label      = [[JMLabel alloc]init];
    label.text          = text;
    label.font          = [UIFont systemFontOfSize:font];
    label.textAlignment = alignment;
    label.textColor     = color;
    label.backgroundColor = bgColor;
    label.adjustsFontSizeToFitWidth = YES;
    
    label.jmType = type;
    
    return label;
}

- (void)setJmType:(JMLabelType)jmType {
    if (!jmType) {
        jmType = JMLabelNormal;
    }
    switch (jmType) {
        case JMLabelRect:
            self.layer.cornerRadius = 5;
            self.layer.masksToBounds = YES;
            break;
            
        case JMLabelRound:
        {
            CGFloat cornerRadius = self.bounds.size.height/2.f;
            self.layer.cornerRadius = cornerRadius;
            self.layer.masksToBounds = YES;
        }
            break;
            
        default:
            break;
    }
    _jmType = jmType;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

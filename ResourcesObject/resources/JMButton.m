//
//  JMButton.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/5/30.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "JMButton.h"

@implementation JMButton

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                      title_X:(float)title_x
                      title_Y:(float)title_y
                      title_W:(float)title_w
                      title_H:(float)title_h
                        img_X:(float)img_x
                        img_Y:(float)img_y
                        img_W:(float)img_w
                        img_H:(float)img_h {
    if (self = [super init]) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateNormal];
        self.title_X = title_x;
        self.title_Y = title_y;
        self.title_W = title_w;
        self.title_H = title_h;
        self.img_X = img_x;
        self.img_Y = img_y;
        self.img_W = img_w;
        self.img_H = img_h;
    }
    return self;
}

+ (JMButton *)JMButtonWithTitle:(NSString *)title
                  SelectedTitle:(NSString *)selectedTitle
                           Font:(CGFloat)font
                     TitleColor:(UIColor *)color
                   JMButtonType:(JMButtonType)type {
    JMButton *jmBtn = [[JMButton alloc]init];
    [jmBtn setTitle:title forState:UIControlStateNormal];
    [jmBtn setTitle:selectedTitle forState:UIControlStateSelected];
    jmBtn.titleLabel.font = [UIFont systemFontOfSize:font];
    jmBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [jmBtn setTitleColor:color forState:UIControlStateNormal];
    jmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    jmBtn.jmType = type;
    return jmBtn;
}

+ (JMButton *)JMButtonWithTitle:(NSString *)title
                  SelectedTitle:(NSString *)selectedTitle
                           Font:(CGFloat)font
                     TitleColor:(UIColor *)color
                   JMButtonType:(JMButtonType)type
                       Delegate:(id)delegate
                         Action:(SEL)action{
    JMButton *jmBtn = [[JMButton alloc]init];
    [jmBtn setTitle:title forState:UIControlStateNormal];
    [jmBtn setTitle:selectedTitle forState:UIControlStateSelected];
    jmBtn.titleLabel.font = [UIFont systemFontOfSize:font];
    jmBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [jmBtn setTitleColor:color forState:UIControlStateNormal];
    jmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    jmBtn.jmType = type;
    [jmBtn addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
    
    return jmBtn;
}

+ (JMButton *)JMButtonWithImage:(NSString *)imgName
                  SelectedImage:(NSString *)selImgName
                   JMButtonType:(JMButtonType)type
                       Delegate:(id)delegate
                         Action:(SEL)action{
    JMButton *jmBtn = [[JMButton alloc]init];
    [jmBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [jmBtn setImage:[UIImage imageNamed:selImgName] forState:UIControlStateSelected];
    [jmBtn addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
    
    jmBtn.jmType = type;
    
    return jmBtn;
}

+ (JMButton *)JMButtonWithImage:(NSString *)imgName
                  SelectedImage:(NSString *)selImgName
                   JMButtonType:(JMButtonType)type {
    JMButton *jmBtn = [[JMButton alloc]init];
    [jmBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [jmBtn setImage:[UIImage imageNamed:selImgName] forState:UIControlStateSelected];
    
    jmBtn.jmType = type;
    
    return jmBtn;
}

- (void)setJmType:(JMButtonType)jmType {
    if (!jmType) {
        jmType = JMButtonNormal;
    }
    switch (jmType) {
        case JMButtonRect:
            self.layer.cornerRadius = 5;
            self.layer.masksToBounds = YES;
            break;
            
        case JMButtonRound:
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

//重写父类UIButton的方法
//更具button的rect设定并返回文本label的rect
- ( CGRect )titleRectForContentRect:( CGRect )contentRect
{
    if (_title_H == 0) {
        [super titleRectForContentRect:contentRect];
        return contentRect;
    }
    contentRect = ( CGRect ){{_title_X,_title_Y},{_title_W,_title_H}};
    return contentRect;
}
//更具button的rect设定并返回UIImageView的rect
- ( CGRect )imageRectForContentRect:( CGRect )contentRect
{
    if (_img_H == 0) {
        [super imageRectForContentRect:contentRect];
        return contentRect;
    }
    contentRect = ( CGRect ){{_img_X,_img_Y},{_img_W,_img_H}};
    return contentRect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

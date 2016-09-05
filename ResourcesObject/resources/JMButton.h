//
//  JMButton.h
//  ResourcesObject
//
//  Created by zhengxingxia on 16/5/30.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMButton : UIButton

@property (assign,nonatomic)float title_X;
@property (assign,nonatomic)float title_Y;
@property (assign,nonatomic)float title_W;
@property (assign,nonatomic)float title_H;

@property (assign,nonatomic)float img_X;
@property (assign,nonatomic)float img_Y;
@property (assign,nonatomic)float img_W;
@property (assign,nonatomic)float img_H;

typedef enum {
    JMButtonNormal = 0,
    JMButtonRect,
    JMButtonRound
}JMButtonType;

@property (assign,nonatomic)JMButtonType jmType;

/**
 *  图文按钮的初始化方法
 *
 *  @param title
 *  @param image
 *  @param title_x
 *  @param title_y
 *  @param title_w
 *  @param title_h
 *  @param img_x
 *  @param img_y
 *  @param img_w
 *  @param img_h
 *
 *  @return
 */
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                      title_X:(float)title_x
                      title_Y:(float)title_y
                      title_W:(float)title_w
                      title_H:(float)title_h
                        img_X:(float)img_x
                        img_Y:(float)img_y
                        img_W:(float)img_w
                        img_H:(float)img_h;

/**
 *  普通纯文字按钮的初始化
 *
 *  @param title         标题
 *  @param selectedTitle 被选中时的标题
 *  @param font          标题大小
 *  @param color         标题颜色
 *  @param type          按钮类型
 *
 *  @return 自定义Btn
 */
+ (JMButton *)JMButtonWithTitle:(NSString *)title
                SelectedTitle:(NSString *)selectedTitle
                        Font:(CGFloat)font
                TitleColor:(UIColor *)color
                JMButtonType:(JMButtonType)type;

/**
 *  普通纯图片按钮的初始化
 *
 *  @param imgName    图片
 *  @param selImgName 选中时的图片
 *  @param type       按钮类型
 *
 *  @return 自定义Btn
 */
+ (JMButton *)JMButtonWithImage:(NSString *)imgName
                  SelectedImage:(NSString *)selImgName
                   JMButtonType:(JMButtonType)type;

/**
 *  设置按钮类型
 *
 *  @param jmType 按钮类型
 */
- (void)setJmType:(JMButtonType)jmType;







@end

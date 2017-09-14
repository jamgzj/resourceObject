//
//  JMNavView.h
//  Tou-Time
//
//  Created by zhengxingxia on 16/10/10.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMNavView : UIView

@property (copy,nonatomic)NSString *title;

@property (weak,nonatomic)UILabel *titleLabel;

@property (weak,nonatomic)UIButton *jmLeftBarBtn;

@property (weak,nonatomic)UIButton *jmRightBarBtn;

@property (weak,nonatomic)UIView *line;


- (void)addJmLeftBarBtnWithTitle:(NSString *)title Target:(id)target;

/**
 *  添加左侧按钮
 *
 *  @param image    图片
 *  @param target   代理目标
 *
 *  @return
 */
- (void)addJmLeftBarBtnWithImage:(UIImage *)image Target:(id)target;

- (void)addJmRightBarBtnWithTitle:(NSString *)title Target:(id)target;

/**
 *  添加右侧按钮
 *
 *  @param image    图片
 *  @param target   代理目标
 *
 *  @return
 */
- (void)addJmRightBarBtnWithImage:(UIImage *)image Target:(id)target;

- (UIButton *)addButtonWithTitle:(NSString *)title OriginX:(float)originX;

/**
 *  添加其余按钮
 *
 *  @param image        图片
 *  @param originX      x位置
 *
 *  @return
 */
- (UIButton *)addButtonWithImage:(UIImage *)image OriginX:(float)originX;

/**
 *  添加底部阴影
 *
 *  @return
 */
- (void)addGrayShadow;

/**
 *  添加底部线条
 *
 *  @return
 */
- (void)addBottomLine;

@end

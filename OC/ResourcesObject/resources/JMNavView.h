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

- (void)addJmLeftBarBtnWithImage:(UIImage *)image Target:(id)target;

- (void)addJmRightBarBtnWithImage:(UIImage *)image Target:(id)target;

- (UIButton *)addButtonWithImage:(UIImage *)image OriginX:(float)originX;

- (void)addGrayShadow;

@end

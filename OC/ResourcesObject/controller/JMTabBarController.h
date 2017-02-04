//
//  JMTabBarController.h
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/27.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMTabBarController : UITabBarController

/**
 *  设置选中bar的背景图片
 *
 *  @param image
 */
- (void)setSelectedBackgroundImage:(UIImage *)image;

/**
 *  设置背景颜色
 *
 *  @param color 
 */
- (void)setJMBackgroundColor:(UIColor *)color;

/**
 *  添加子控制器
 *
 *  @param childVc
 *  @param title
 *  @param imageName
 *  @param selectedImageName
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;





@end

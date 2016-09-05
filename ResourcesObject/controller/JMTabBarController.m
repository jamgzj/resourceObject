//
//  JMTabBarController.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/27.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "JMTabBarController.h"
#import "JMNavController.h"

@interface JMTabBarController ()

@end

@implementation JMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  设置tabbar高度
 */
//- (void)viewWillLayoutSubviews{
//    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
//    tabFrame.size.height = 60;
//    tabFrame.origin.y = self.view.frame.size.height - 60;
//    self.tabBar.frame = tabFrame;
//    
//}

/**
 *  设置选中背景图片
 *
 *  @param image <#image description#>
 */
- (void)setSelectedBackgroundImage:(UIImage *)image {
    self.tabBar.selectionIndicatorImage = image;
}

/**
 *  设置背景图片
 *
 *  @param image <#image description#>
 */
- (void)setJMBackgroundImage:(UIImage *)image {
    UIImageView *backImgView = [[UIImageView alloc] initWithFrame:self.tabBar.bounds];
    backImgView.image = image;
    [self.tabBar insertSubview:backImgView atIndex:0];
}

/**
 *  设置背景颜色
 *
 *  @param color <#color description#>
 */
- (void)setJMBackgroundColor:(UIColor *)color {
    UIView *backView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    backView.backgroundColor = color;
    [self.tabBar insertSubview:backView atIndex:0];
}

/**
 *  删除tabbar的分割线
 */
- (void)deleteTopLine {
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

/**
 *  tabbar controller 添加子控制器
 *
 *  @param childVc           子控制器
 *  @param title             标题
 *  @param imageName         图片名
 *  @param selectedImageName 选中的图片名
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 设置标题
    childVc.title = title;
    
    // 设置图标
    UIImage *image = [UIImage imageNamed:imageName];
    // 声明这张图片用原图(别渲染)
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.image = image;
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    JMNavController *nav = [[JMNavController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  JMNavController.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/27.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "JMNavController.h"

@interface JMNavController ()

@end

@implementation JMNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)setTitleVerticalOffset:(float)offset {
    [self.navigationBar setTitleVerticalPositionAdjustment:5 forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavigationBarColor:(UIColor *)color {
    self.navigationBar.barTintColor = color;
}

- (void)setTitleColor:(UIColor *)color {
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = color;
    [self.navigationBar setTitleTextAttributes:textAttrs];
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

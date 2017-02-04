//
//  JMTabBarController.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/27.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "JMTabBarController.h"
#import "JMNavController.h"
//#import "HomeViewController.h"
//#import "ZFPlayer.h"
#import "JMTool.h"
//#import "JPUSHService.h"


@interface JMTabBarController ()

@end

@implementation JMTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self deleteTopLine];
    
//    HomeViewController *homeVC = [[HomeViewController alloc]init];
//    
//    [self addOneChlildVc:homeVC title:@"首页" imageName:@"main_home.png" selectedImageName:@"main_home_select.png"];
    
    
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidSetup:)
//                          name:kJPFNetworkDidSetupNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidClose:)
//                          name:kJPFNetworkDidCloseNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidRegister:)
//                          name:kJPFNetworkDidRegisterNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidLogin:)
//                          name:kJPFNetworkDidLoginNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidReceiveMessage:)
//                          name:kJPFNetworkDidReceiveMessageNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(serviceError:)
//                          name:kJPFServiceErrorNotification
//                        object:nil];


}

/**
 *  设置tabbar高度
 */
- (void)viewWillLayoutSubviews{
    if (SCREEN_HEIGHT >568) {
        CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
        tabFrame.size.height = 60;
        tabFrame.origin.y = self.view.frame.size.height - 60;
        self.tabBar.frame = tabFrame;
    }else {
        CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
        tabFrame.size.height = 50;
        tabFrame.origin.y = self.view.frame.size.height - 50;
        self.tabBar.frame = tabFrame;
    }
}

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
    textAttrs[NSForegroundColorAttributeName] = MainFontColor;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = MainColor;
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

//// 哪些页面支持自动转屏
//- (BOOL)shouldAutorotate{
//    
//    UINavigationController *nav = self.viewControllers[0];
//    
//    // MoviePlayerViewController 、ZFTableViewController 控制器支持自动转屏
//    if ([nav.topViewController isKindOfClass:[PlayMoviewViewController class]]) {
//        // 调用ZFPlayerSingleton单例记录播放状态是否锁定屏幕方向
//        return !ZFPlayerShared.isLockScreen;
//    }
//    return NO;
//}

//// viewcontroller支持哪些转屏方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    
//    UINavigationController *nav = self.viewControllers[0];
//    if ([nav.topViewController isKindOfClass:[PlayMoviewViewController class]]) { // MoviePlayerViewController这个页面支持转屏方向
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    } else {
//            return UIInterfaceOrientationMaskPortrait;
//        }
//    // 其他页面
//    return UIInterfaceOrientationMaskPortrait;
//}

//- (void)dealloc {
//    [self unObserveAllNotifications];
//}

//- (void)unObserveAllNotifications {
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidSetupNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidCloseNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidRegisterNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidLoginNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidReceiveMessageNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFServiceErrorNotification
//                           object:nil];
//}

//- (void)networkDidSetup:(NSNotification *)notification {
//    NSLog(@"已连接");
//}
//
//- (void)networkDidClose:(NSNotification *)notification {
//    NSLog(@"未连接");
//}
//
//- (void)networkDidRegister:(NSNotification *)notification {
//    NSLog(@"%@", [notification userInfo]);
//    
//    NSLog(@"已注册");
//}
//
//- (void)networkDidLogin:(NSNotification *)notification {
//    NSLog(@"已登录");
//    if ([JPUSHService registrationID]) {
//        [self resetAliasAndTag];
//
//    }
//}
//
//- (void)networkDidReceiveMessage:(NSNotification *)notification {
//    //    NSDictionary *userInfo = [notification userInfo];
//    //    NSString *title = [userInfo valueForKey:@"title"];
//    //    NSString *content = [userInfo valueForKey:@"content"];
//    //    NSDictionary *extra = [userInfo valueForKey:@"extras"];
//    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //
//    //    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    //
//    //    NSString *currentContent = [NSString
//    //                                stringWithFormat:
//    //                                @"收到自定义消息:%@\ntitle:%@\ncontent:%@\nextra:%@\n",
//    //                                [NSDateFormatter localizedStringFromDate:[NSDate date]
//    //                                                               dateStyle:NSDateFormatterNoStyle
//    //                                                               timeStyle:NSDateFormatterMediumStyle],
//    //                                title, content, [self logDic:extra]];
//    //    NSLog(@"%@", currentContent);
//    //    [self setNotification];
//}
//
//
//
//#pragma mark -- 设置本地通知
//- (void)setNotification{
//    
//    //    // v2.1.9版以后方式
//    //    JPushNotificationContent *content = [[JPushNotificationContent alloc] init];
//    //    content.body = @"TT通行本地"; // 推送内容
//    //    content.badge = [NSNumber numberWithInt:-1]; //// 角标的数字。如果不需要改变角标传@(-1)
//    //    content.action = @"新消息哦"; // // 弹框的按钮显示的内容（IOS 8默认为"打开", 其他默认为"启动",iOS10以上无效）
//    //    content.title = @"TT通行标题";
//    //    content.subtitle = @"TT通行副标题";
//    //    JPushNotificationTrigger *trigger = [[JPushNotificationTrigger alloc] init];
//    //
//    //    NSDate *NowDate = [[NSDate alloc] init];
//    //    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
//    //        trigger.timeInterval = [dbSystemManager getSysteTimestamp]; // iOS10以上有效
//    ////        NSLog(@"timeInterval--->%f",trigger.timeInterval);
//    //    }
//    //    else {
//    ////        NSLog(@"fireDate--->%@",trigger.fireDate);
//    ////        trigger.fireDate = notificationDatePicker.date; // iOS10以下有效
//    //        trigger.fireDate = NowDate; // iOS10以下有效
//    //    }
//    //    JPushNotificationRequest *request = [[JPushNotificationRequest alloc] init];
//    //    request.content = content;
//    //    request.trigger = trigger;
//    //    request.requestIdentifier = @"TT通行"; // 推送请求标识
//    //    request.completionHandler = ^(id result) {
//    //        NSLog(@"%@", result); // iOS10以上成功则result为UNNotificationRequest对象，失败则result为nil;iOS10以下成功result为UILocalNotification对象，失败则result为nil
//    //        _notification = result;
//    //        if (result) {
//    //            void (^block)() = ^() {
//    //                //      [self clearAllInput];
//    //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置"
//    //                                                                message:@"设置成功"
//    //                                                               delegate:self
//    //                                                      cancelButtonTitle:@"确定"
//    //                                                      otherButtonTitles:nil, nil];
//    //                [alert show];
//    //            };
//    //            if ([NSThread isMainThread]) {
//    //                block();
//    //            }
//    //            else {
//    //                dispatch_async(dispatch_get_main_queue(), block);
//    //            }
//    //        }
//    //    };
//    //    [JPUSHService addNotification:request];
//    
//}
//
//
//// log NSSet with UTF8
//// if not ,log will be \Uxxx
//- (NSString *)logDic:(NSDictionary *)dic {
//    if (![dic count]) {
//        return nil;
//    }
//    NSString *tempStr1 =
//    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
//                                                 withString:@"\\U"];
//    NSString *tempStr2 =
//    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    NSString *tempStr3 =
//    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
//    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *str =
//    [NSPropertyListSerialization propertyListFromData:tempData
//                                     mutabilityOption:NSPropertyListImmutable
//                                               format:NULL
//                                     errorDescription:NULL];
//    return str;
//}
//
//- (void)serviceError:(NSNotification *)notification {
//    NSDictionary *userInfo = [notification userInfo];
//    NSString *error = [userInfo valueForKey:@"error"];
//    NSLog(@"%@", error);
//}
//
//#pragma mark - 设置标签别名
//- (void)resetAliasAndTag
//{
//    if ([JMTool isLogin]) {
//        NSString *userId = [NSString stringWithFormat:@"%@",[UserInfo getUserInfo].userId];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//             [JPUSHService setTags:nil alias:userId callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
//        });
//    }
//}
//
//- (void)tagsAliasCallback:(int)iResCode tags:(NSSet *)tags alias:(NSString *)alias
//{
//    switch (iResCode) {
//        case 6002:
//            [self resetAliasAndTag];
//            break;
//        default:;
//    }
//}


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

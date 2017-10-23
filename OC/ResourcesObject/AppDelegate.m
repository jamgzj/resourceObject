//
//  AppDelegate.m
//  Tou-Time
//
//  Created by zhengxingxia on 16/9/21.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//
#import "TestViewController.h"
#import "AppDelegate.h"
#import "JMTabBarController.h"
#import "IQKeyboardManager/IQKeyboardManager.h"
#import "JMTool.h"
//#import "ChooseRootTool.h"
//#import <BaiduMapAPI_Base/BMKMapManager.h>
//#import <AlipaySDK/AlipaySDK.h>
//#import "WXApiManager.h"
//#import <BaiduMapAPI_Location/BMKLocationService.h>
//#import <RongIMKit/RongIMKit.h>
//#import <UMSocialCore/UMSocialCore.h>
//#import <UMMobClick/MobClick.h>
//// 引入JPush功能所需头文件
//#import "JPUSHService.h"
//// iOS10注册APNs所需头文件
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//#import <UserNotifications/UserNotifications.h>
//#endif

#define BAIDUMAP_KEY @""
#define RONGCLOUD_IM_APPKEY @""

#define acessToken @""

@interface AppDelegate ()/*<RCIMUserInfoDataSource,JPUSHRegisterDelegate>*/
//{
//    BMKMapManager* _mapManager;
//    BMKLocationService  *_locService;  // 百度地图定位
//    NSString *_RCUserId;
//}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    // 设置根视图控制器
//    [ChooseRootTool chooseRootViewController:self.window];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[TestViewController alloc]init]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    // 设置键盘管理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    [manager setToolbarDoneBarButtonItemText:@"完成"];
    manager.enable = YES;
    
    manager.shouldResignOnTouchOutside = YES;
    
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    
    [JMHttp checkNetStatus];
    
//    //请先启动BaiduMapManager
//    _mapManager = [[BMKMapManager alloc]init];
//    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
//    BOOL ret = [_mapManager start:BAIDUMAP_KEY generalDelegate:nil];
//    if (ret) {
//        NSLog(@"百度地图打开成功");
//    }
//    
//    //向微信注册wxd930ea5d5a258f4f
//    [WXApi registerApp:WeiXinAppKey withDescription:@"Tou-Time"];
//    
//    // 初始化百度地图定位服务
//    _locService = [[BMKLocationService alloc]init];
//    
//    //允许PGS访问定位
//    [_locService startUserLocationService];
//    [_locService stopUserLocationService];
//    //初始化融云SDK
//    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
//    
//#pragma mark - 融云access token
//    [[RCIM sharedRCIM] connectWithToken:acessToken success:^(NSString *userId) {
//        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
//        
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"登陆的错误码为:%ld", (long)status);
//    } tokenIncorrect:^{
//        //token过期或者不正确。
//        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
//        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
//        NSLog(@"token错误");
//        //[[RCIM sharedRCIM]disconnect];
//    }];
//    
//    
//    // Override point for customization after application launch.
//    //打开日志
//    [[UMSocialManager defaultManager] openLog:YES];
//    //设置友盟appkey
//    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAppKey];
//    
//    // 获取友盟social版本号
//    NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
//    
//    //各平台的详细配置
//    //设置微信的appId和appKey
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeiXinAppKey appSecret:WeiXinAppSecret redirectURL:@"http://mobile.umeng.com/social"];
//    
//    //设置分享到QQ互联的appId和appKey
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppId  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//    
//    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformType:UMSocialPlatformType_WechatFavorite];
//    
//    // 获取版本号
//    // 友盟SDK为了兼容Xcode3的工程，默认取的是Build号，如果需要取Xcode4及以上版本的Version，可以在StartWithAppkey之前调用下面的方法：
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    [MobClick setAppVersion:version];
//    
//    // 设置友盟统计
//    [MobClick setLogEnabled:YES];
//    UMConfigInstance.appKey = @"582970c8bbea837c70002100";
//    UMConfigInstance.channelId = @"App Store";
//    //    UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
//    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
//    
//    [MobClick setEncryptEnabled:YES];
//    //    [MobClick setBackgroundTaskEnabled:YES];
//    
//    //Required
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    }
//    // ios 10
//    //entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
//    
//    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                          UIUserNotificationTypeSound |
//                                                          UIUserNotificationTypeAlert)
//                                              categories:nil];
//    }
//    else {
//        //categories 必须为nil
//        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                          UIRemoteNotificationTypeSound |
//                                                          UIRemoteNotificationTypeAlert)
//                                              categories:nil];
//    }
//    
//    [JPUSHService setupWithOption:launchOptions appKey:JPush_APPKEY channel:channel apsForProduction:isProduction];
//      [JPUSHService setDebugMode];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
//    if ([url.scheme isEqualToString:WeiXinAppKey] && [url.absoluteString containsString:@"pay"])
//    {
//        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//    }
//    
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
//    if (!result) {
//        // 其他如支付等SDK的回调
//        if ([url.host isEqualToString:@"safepay"]) {
//            // 支付跳转支付宝钱包进行支付，处理支付结果
//            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//                NSLog(@"result = %@",resultDic);
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"safepay" object:nil userInfo:resultDic];
//            }];
//            
//            //            // 授权跳转支付宝钱包进行支付，处理支付结果
//            //            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            //                NSLog(@"result = %@",resultDic);
//            //                // 解析 auth code
//            //                NSString *result = resultDic[@"result"];
//            //                NSString *authCode = nil;
//            //                if (result.length>0) {
//            //                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//            //                    for (NSString *subResult in resultArr) {
//            //                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//            //                            authCode = [subResult substringFromIndex:10];
//            //                            break;
//            //                        }
//            //                    }
//            //                }
//            //                NSLog(@"授权结果 authCode = %@", authCode?:@"");
//            //            }];
//        }
//        
//        return YES;
//        
//    }
//    return result;
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
//    if ([url.scheme isEqualToString:WeiXinAppKey] && [url.absoluteString containsString:@"pay"])
//    {
//        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//    }
//    
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
//    if (!result) {
//        // 其他如支付等SDK的回调
//        if ([url.host isEqualToString:@"safepay"]) {
//            // 支付跳转支付宝钱包进行支付，处理支付结果
//            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//                NSLog(@"result = %@",resultDic);
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"safepay" object:nil userInfo:resultDic];
//            }];
//            
//            //            // 授权跳转支付宝钱包进行支付，处理支付结果
//            //            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            //                NSLog(@"result = %@",resultDic);
//            //                // 解析 auth code
//            //                NSString *result = resultDic[@"result"];
//            //                NSString *authCode = nil;
//            //                if (result.length>0) {
//            //                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//            //                    for (NSString *subResult in resultArr) {
//            //                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//            //                            authCode = [subResult substringFromIndex:10];
//            //                            break;
//            //                        }
//            //                    }
//            //                }
//            //                NSLog(@"授权结果 authCode = %@", authCode?:@"");
//            //            }];
//        }
//        
//        return YES;
//        
//    }
//    return result;
    return YES;
}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}
//#pragma mark -- JPush 注册APNs成功并上报DeviceToken
//- (void)application:(UIApplication *)application
//didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    
//    /// Required - 注册 DeviceToken
//    [JPUSHService registerDeviceToken:deviceToken];
//}
//
//#pragma mark -- JPush 实现注册APNs失败接口（可选）
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    //Optional
//    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
//}
//
//- (void)application:(UIApplication *)application
//didRegisterUserNotificationSettings:
//(UIUserNotificationSettings *)notificationSettings {
//}
//
//- (void)application:(UIApplication *)application
//handleActionWithIdentifier:(NSString *)identifier
//forLocalNotification:(UILocalNotification *)notification
//  completionHandler:(void (^)())completionHandler {
//}
//// iOS 10 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
//    // Required
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    
//    UNNotificationRequest *request = notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {//iOS10 前台收到远程通知
//        [JPUSHService handleRemoteNotification:userInfo];
//        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
//    }
//    else {
//        // 判断为本地通知
//        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
//    }
//    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否
//}
//
// iOS 10 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
//    // Required
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
//    }
//    completionHandler();  // 系统要求执行这个方法
//}

// Required,For systems with less than or equal to iOS6
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
//    [JPUSHService handleRemoteNotification:userInfo];
//    NSLog(@"接收到的通知为:%@",[self logDic:userInfo]);
}
// IOS 7 Support Required
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
//    [JPUSHService handleRemoteNotification:userInfo];
//    NSLog(@"接收到的通知为:%@",[self logDic:userInfo]);
//    // 如果程序为活跃状态
//    if (application.applicationState == UIApplicationStateActive) {
//        
//        UILocalNotification *localNotification = [[UILocalNotification alloc]init];
//        localNotification.userInfo = userInfo;
//        localNotification.soundName = UILocalNotificationDefaultSoundName;
//        localNotification.alertBody = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
//        localNotification.fireDate = [NSDate date];
//        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//    }
//    else
//    {
//        
//    }
//    
//    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
//    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}
@end

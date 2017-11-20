//
//  Header.h
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/20.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#ifndef Header_h
#define Header_h



#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define coefficient     (SCREEN_WIDTH/375.f)

#define CURRENT_SIZE(_SIZE) _SIZE/375.0*SCREEN_WIDTH //当前的宽高比

#define WeakSelf __weak typeof(self) weakSelf = self;

// 主题颜色
#define MainColor             [JMTool colorWithHexString:@"#c09961"]  // 类咖啡色
// 字体主色调
#define MainFontColor         [JMTool colorWithHexString:@"#3e3a39"]  // 类似黑色
// 间距背景主色调
#define backGroundColor       [UIColor colorWithWhite:0.961 alpha:1]  // 淡灰色

#define shadow_Color           [UIColor colorWithWhite:0.3 alpha:0.3]

#define lineColor             [UIColor colorWithRed:0.914 green:0.918 blue:0.922 alpha:1.000]

#define RGB(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define isIOS7  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)?YES:NO)

#define isIOS8  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0)?YES:NO)

#define isIOS9  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0)?YES:NO)

#define isIOS10  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 10.0)?YES:NO)

#define isIOS11  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 11.0)?YES:NO)


#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define MAIN_FONT(a)  isIOS9?[UIFont fontWithName:ping_fang_regular size:(a)]:[UIFont fontWithName:@"HelveticaNeue" size:(a)]
#define MAIN_BOLD_FONT(a)  isIOS9?[UIFont fontWithName:ping_fang_bold size:(a)]:[UIFont fontWithName:@"HelveticaNeue-Bold" size:(a)]

#define navHeight (40*coefficient+statusbarHeight())

// 用户信息KEY
#define USER_INFO_KEY @"userInfoKey"
#define lat_KEY @"lat"
#define lng_KEY @"lng"

#define acessToken @""

// 各平台key值

static NSString *const UMAppKey = @"";

static NSString *const WeiXinAppKey = @"";
static NSString *const WeiXinAppSecret = @"";
static NSString *const QQAppId = @"";
static NSString *const QQAppKey = @"";


static const float shoppingcarHeight = 40.f;        // 购物车高度

// 字体
static NSString *const ping_fang_bold = @"PingFangSC-Semibold";

static NSString *const ping_fang_regular = @"PingFangSC-Regular";

/**系统粗体*/
static NSString *const SYSTEM_BOLD = @"Helvetica-Bold";

// NSUserdefault Keys
static NSString *const IS_NETCONNECT_LOST = @"isNetConnectLost";

static NSString *const REFRESH_UI = @"refreshUI";


// URL

// IP 正式地址

#define IP_ADRESS_URL(...)          [NSString stringWithFormat:@"http://www.toutime.com.cn/coffeeInterface/%@",##__VA_ARGS__]

//// IP 测试地址
////
//#define IP_ADRESS_URL(...)          [NSString stringWithFormat:@"http://192.168.1.110:8089/coffeeInterface/%@",##__VA_ARGS__]












#endif /* Header_h */












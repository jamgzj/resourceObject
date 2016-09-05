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



#define isIOS6  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 6.0)?YES:NO)

#define isIOS7  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)?YES:NO)

#define isIOS8  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0)?YES:NO)



#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)


// URL

// IP 正式地址
#define IP_ADRESS_URL(...)          [NSString stringWithFormat:@"http://soft.lvtaosoft.com/duanxinInterface/%@",##__VA_ARGS__]

// static NSString const *












#endif /* Header_h */

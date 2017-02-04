//
//  MBProgressHUD+NJ.h
//  NJWisdomCard
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (NJ)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showText:(NSString *)text ToView:(UIView *)view;

///**
// *  （废弃）
// */
//+ (MBProgressHUD *)showMessage:(NSString *)message;

/**
 *  view不能为nil,需要使用GCD在主线程
 *
 *  @param message <#message description#>
 *  @param view    <#view description#>
 *
 *  @return <#return value description#>
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

///**
// *  （废弃）
// */
//+ (void)hideHUD;

/**
 *  view不能为nil
 *
 *  @param view <#view description#>
 */
+ (void)hideHUDForView:(UIView *)view;

/**
 *  view不能为nil(为空只能显示2秒)
 *
 *  @param imgArray <#imgArray description#>
 *  @param view     <#view description#>
 */
+ (void)showLoadingWithImages:(NSArray *)imgArray ToView:(UIView *)view;

@end

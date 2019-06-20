//
//  MBProgressHUD+NJ.m
//  NJWisdomCard
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import "MBProgressHUD+NJ.h"

@implementation MBProgressHUD (NJ)

/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    
//    dispatch_async(dispatch_get_main_queue(), ^{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.bezelView.backgroundColor = [UIColor blackColor];
//    hud.contentColor = [UIColor whiteColor];
//    hud.detailsLabel.textColor = [UIColor whiteColor];
//    hud.detailsLabel.text = text;
//    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15*coefficient];
    hud.labelText = text;
    
    /*图片加文字提示 */
    // 设置图片ycf 去除图片
    //hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    hud.mode = MBProgressHUDModeCustomView;
    // 再设置模式
//    hud.mode =  MBProgressHUDModeText;

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:2.0];
//    [hud hideAnimated:YES afterDelay:1.f];
//    });
}

+ (MBProgressHUD *)showProgressWithText:(NSString *)text toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

//+ (void)showText:(NSString *)text ToView:(UIView *)view {
//    BOOL isViewExist = YES;
//    if (!view) {
//        view = [UIApplication sharedApplication].windows.lastObject;
//        isViewExist = NO;
//    }
//    
////    dispatch_async(dispatch_get_main_queue(), ^{
//    // hud初始化
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.bezelView.backgroundColor = [UIColor blackColor];
//    hud.contentColor = [UIColor whiteColor];
//    hud.detailsLabel.textColor = [UIColor whiteColor];
//    
//    // 设置hud模式
//    hud.mode = MBProgressHUDModeCustomView;
//    
//    // 设置hud宽高相等
////    hud.square = YES;
//    
//    // 设置页面动画
//    hud.label.text = text;
//    hud.label.numberOfLines = 0;
//    hud.label.preferredMaxLayoutWidth = 150.f*coefficient;
//    
////        // 设置hud文字
////        hud.labelText = @"loading...";
//    
//    // 设置hud隐藏时从父视图移除
//    hud.removeFromSuperViewOnHide = YES;
//    
//    if (!isViewExist) {
//        [hud hide:YES afterDelay:2.f];
//    }
////    });
//    
//}

/**
 *  显示动画读取
 *
 *  @param imgArray <#imgArray description#>
 *  @param view     <#view description#>
 */
+ (MBProgressHUD *)showLoadingWithImages:(NSArray *)imgArray ToView:(UIView *)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
//    dispatch_async(dispatch_get_main_queue(), ^{
    // hud初始化
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // 设置hud模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 设置hud宽高相等
    hud.square = YES;
    
    if (imgArray.count > 0) {
        UIImage *image = imgArray[0];
        CGFloat width = image.size.width;
        CGFloat rate = width==0 ? 0:image.size.height/width;
        // 设置页面动画
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100*rate)];
        imgView.animationImages = imgArray;
        imgView.animationDuration = 1.f;
        imgView.animationRepeatCount = 0;
        [imgView startAnimating];
        
        hud.customView = imgView;
    }
    
    
    // 设置hud文字
    hud.labelText = @"Loading...";
    
    // 设置hud隐藏时从父视图移除
    hud.removeFromSuperViewOnHide = YES;
    
//    });
    return hud;
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}


/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

/**
 *  显示错误信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
     //YES代表需要蒙版效果
    hud.dimBackground = YES;
//    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    
    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
//    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideHUDForView:view animated:YES];
//    });
}

@end

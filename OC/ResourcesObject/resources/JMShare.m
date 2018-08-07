//
//  JMShare.m
//  Seen
//
//  Created by CMVIOS1 on 2017/7/17.
//  Copyright © 2017年 Amor. All rights reserved.
//

#import "JMShare.h"
#import "JMTool.h"
#import <UShareUI/UShareUI.h>

@implementation JMShare

+ (void)getUserInfoWithPlatform:(UMSocialPlatformType)platformType
                     completion:(UMSocialRequestCompletionHandler)completion {
    
    if (platformType == UMSocialPlatformType_QQ || platformType == UMSocialPlatformType_Qzone) {
        if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_QQ]) {
            [self alertForDownloadQQ];
            return;
        }
    }
    
    if (platformType == UMSocialPlatformType_WechatSession || platformType == UMSocialPlatformType_WechatTimeLine) {
        if (![[UMSocialManager defaultManager]isInstall:platformType]) {
            [self alertForDownloadWeixin];
            return;
        }
    }
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        if (completion) {
            completion(result,error);
        }
    }];
}

+ (void)shareWebViewWithLinkURL:(NSString *)urlString
                          Title:(NSString *)title
                    Description:(NSString *)description
                     ThumbImage:(id)image {
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [self shareWebViewWithLinkURL:urlString Title:title Description:description ThumbImage:image Platform:platformType];
    }];
}

+ (void)shareWebViewWithLinkURL:(NSString *)urlString
                          Title:(NSString *)title
                    Description:(NSString *)description
                     ThumbImage:(id)image
                       Platform:(UMSocialPlatformType)platformType {
    if (platformType == UMSocialPlatformType_QQ || platformType == UMSocialPlatformType_Qzone) {
        if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_QQ]) {
            [self alertForDownloadQQ];
            return;
        }
    }
    
    if (platformType == UMSocialPlatformType_WechatSession || platformType == UMSocialPlatformType_WechatTimeLine) {
        if (![[UMSocialManager defaultManager]isInstall:platformType]) {
            [self alertForDownloadWeixin];
            return;
        }
    }
    
//    if (platformType == UMSocialPlatformType_Sina) {
//        if (![[UMSocialManager defaultManager]isInstall:platformType]) {
//            [self alertForDownloadSina];
//            return;
//        }
//    }
    
    id thumbImage;
    if ([image isKindOfClass:[NSString class]]) {
        NSString *imageString = (NSString *)image;
        
        if ([JMTool isStringLegal:imageString ByJudgeString:@"^http[s]?://.*"]) {
            thumbImage = imageString;
        }else {
            thumbImage = [UIImage imageNamed:imageString];
        }
    }else if ([image isKindOfClass:[UIImage class]]) {
        thumbImage = (UIImage *)image;
    }else if ([image isKindOfClass:[NSData class]]) {
        thumbImage = [UIImage imageWithData:(NSData *)image];
    }else if (!image) {
        thumbImage = [UIImage imageNamed:@"icon_img"];
    }
    // 根据获取的platformType确定所选平台进行下一步操作
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:description thumImage:thumbImage];
    //设置网页地址
    shareObject.webpageUrl = urlString;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *currentVC = [JMTool getCurrentVC];
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentVC completion:^(id data, NSError *error) {
            
        }];
    });
}

+ (void)alertForDownloadQQ {
    UIViewController *currentVC = [JMTool getCurrentVC];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否安装QQ" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/qq/id444934666?mt=8"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:sure];
    [alertVC addAction:cancel];
    [currentVC presentViewController:alertVC animated:YES completion:nil];
}

+ (void)alertForDownloadWeixin {
    UIViewController *currentVC = [JMTool getCurrentVC];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否安装微信" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:sure];
    [alertVC addAction:cancel];
    [currentVC presentViewController:alertVC animated:YES completion:nil];
}

+ (void)alertForDownloadSina {
    UIViewController *currentVC = [JMTool getCurrentVC];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否安装新浪微博" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E5%BE%AE%E5%8D%9A/id350962117?mt=8"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:sure];
    [alertVC addAction:cancel];
    [currentVC presentViewController:alertVC animated:YES completion:nil];
}







@end





































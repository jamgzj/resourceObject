//
//  JMShare.h
//  Seen
//
//  Created by CMVIOS1 on 2017/7/17.
//  Copyright © 2017年 Amor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMShare/UMShare.h>

typedef enum : NSUInteger {
    JMShareTypeTimeLine,      //微信好友
    JMShareTypeSession,       //微信朋友圈
    JMShareTypeQQ,            //QQ好友
    JMShareTypeQZone,         //QQ空间
} JMShareType;

@interface JMShare : NSObject

/**
 第三方登录

 @param platformType 平台类型
 @param completion 登录回调
 */
+ (void)getUserInfoWithPlatform:(UMSocialPlatformType)platformType
                     completion:(UMSocialRequestCompletionHandler)completion;

/**
 微信，朋友圈，qq好友，qq空间，新浪 分享

 @param urlString       分享的网页链接
 @param title           分享标题
 @param description     描述
 @param image           分享显示的图片(可以为string，可以是image，可以是data，其余类型直接报错)
 */
+ (void)shareWebViewWithLinkURL:(NSString *)urlString
                          Title:(NSString *)title
                    Description:(NSString *)description
                     ThumbImage:(id)image;


/**
 单个平台的点击分享

 @param urlString <#urlString description#>
 @param title <#title description#>
 @param description <#description description#>
 @param image <#image description#>
 @param platformType <#platformType description#>
 */
+ (void)shareWebViewWithLinkURL:(NSString *)urlString
                          Title:(NSString *)title
                    Description:(NSString *)description
                     ThumbImage:(id)image
                       Platform:(UMSocialPlatformType)platformType;




@end



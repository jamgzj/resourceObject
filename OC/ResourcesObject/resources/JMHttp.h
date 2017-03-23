//
//  JMHttp.h
//  ResourcesObject
//
//  Created by zhengxingxia on 2017/2/20.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


typedef void(^HttpSuccessBlock)(id JSON);
typedef void(^HttpFailureBlock)(id Error);

@interface JMHttp : NSObject

+ (AFHTTPSessionManager *)sharedManager;

/**
 *  判断网络请求返回值
 *
 *  @param dict <#dict description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)isHttpRequestStatusOK:(NSDictionary *)dict;

/**
 *  监测网络状态
 */
+ (void)checkNetStatus;

/**
 *  处理网络请求失败
 */
+ (void)dealWithNetError:(NSError *)error WithTimeOutAction:(void(^)())action;

/**
 *  get请求
 *
 *  @param path    url
 *  @param params  参数
 *  @param isShow  是否显示MB
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (void)getWithThePath:(NSString *)path
                Params:(NSDictionary *)params
             isHudShow:(BOOL)isShow
               Success:(HttpSuccessBlock)success
               Failure:(HttpFailureBlock)failure;

/**
 *  post请求
 *
 *  @param path    url
 *  @param params  参数
 *  @param isShow  是否显示MB
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (void)postWithThePath:(NSString *)path
                 Params:(NSDictionary *)params
              isHudShow:(BOOL)isShow
                Success:(HttpSuccessBlock)success
                Failure:(HttpFailureBlock)failure;

/**
 *  网络请求数据(GET/POST)
 *
 *  @param path    url
 *  @param params  参数
 *  @param method  方法
 *  @param isShow  是否显示MB
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (void)requestWithThePath:(NSString *)path
                    Params:(NSDictionary *)params
                    Method:(NSString *)method
                 isHudShow:(BOOL)isShow
                   Success:(HttpSuccessBlock)success
                   Failure:(HttpFailureBlock)failure;

/**
 *  上传图片
 *
 *  @param path    urlString
 *  @param data    图片data
 *  @param kName   图片对应的key值
 *  @param params  参数
 *  @param isShow  是否显示MB
 *  @param success success description
 *  @param failure failure description
 */
+ (void)requestWithThePath:(NSString *)path
                      Data:(NSData *)data
                   KeyName:(NSString *)kName
                    Params:(NSDictionary *)params
                 isHudShow:(BOOL)isShow
                   Success:(HttpSuccessBlock)success
                   Failure:(HttpFailureBlock)failure;

/**
 *  上传多张图片
 *
 *  @param path       urlString
 *  @param imgArray   图片数组(数组存放的可以是NSData,NSString,UIImage三种类型之一)
 *  @param kNameArray 对应上传图片的key值(字符串数组)
 *  @param params     参数列表
 *  @param isShow     是否显示MB
 *  @param success    success description
 *  @param failure    failure description
 */
+ (void)requestWithThePath:(NSString *)path
                  imgArray:(NSArray *)imgArray
              KeyNameArray:(NSArray *)kNameArray
                    Params:(NSDictionary *)params
                 isHudShow:(BOOL)isShow
                   Success:(HttpSuccessBlock)success
                   Failure:(HttpFailureBlock)failure;















@end




























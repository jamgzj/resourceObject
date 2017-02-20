//
//  JMHttp.m
//  ResourcesObject
//
//  Created by zhengxingxia on 2017/2/20.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

#import "JMHttp.h"
#import "Header.h"
#import "JMTool.h"
#import "MBProgressHUD+NJ.h"

@implementation JMHttp

static AFHTTPSessionManager *_manager;

+ (AFHTTPSessionManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return _manager;
}

+ (void)getWithThePath:(NSString *)path
                Params:(NSDictionary *)params
             isHudShow:(BOOL)isShow
               Success:(HttpSuccessBlock)success
               Failure:(HttpFailureBlock)failure {
    
    [self requestWithThePath:path Params:params Method:@"GET" isHudShow:isShow Success:success Failure:failure];
}

+ (void)postWithThePath:(NSString *)path
                 Params:(NSDictionary *)params
              isHudShow:(BOOL)isShow
                Success:(HttpSuccessBlock)success
                Failure:(HttpFailureBlock)failure {
    
    [self requestWithThePath:path Params:params Method:@"POST" isHudShow:isShow Success:success Failure:failure];
}

+ (void)requestWithThePath:(NSString *)path
                    Params:(NSDictionary *)params
                    Method:(NSString *)method
                 isHudShow:(BOOL)isShow
                   Success:(HttpSuccessBlock)success
                   Failure:(HttpFailureBlock)failure {
    
    UIView *topView = [UIApplication sharedApplication].windows.lastObject;
    
    NSString *urlStr = [JMTool isStringLegal:path ByJudgeString:@"^http://.*"]?path:[NSString stringWithFormat:@"%@",IP_ADRESS_URL(path)];
    
    if (isShow) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MBProgressHUD *hud = [MBProgressHUD showMessage:@"loading..." toView:topView];
            
            [hud hideAnimated:YES afterDelay:13.f];
        });
    }
    
    _manager = [self sharedManager];
    
    if ([method isEqualToString:@"POST"]) {   //发送post请求
        
        [_manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (topView) {
                [MBProgressHUD hideAllHUDsForView:topView animated:YES];
            }
            
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            //传递数据
            success(JSON);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (topView) {
                [MBProgressHUD hideAllHUDsForView:topView animated:YES];
            }
            
            [MBProgressHUD showError:@"网络请求失败,请稍后再试哦"];
            
            //NSLog(@"error:%@",error);
            failure(error);
        }];
        
    }else if ([method isEqualToString:@"GET"]){   //发送get请求
        
        [_manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (topView) {
                [MBProgressHUD hideAllHUDsForView:topView animated:YES];
            }
            
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            //NSLog(@"JSON------>%@",JSON);
            
            //传递数据
            success(JSON);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (topView) {
                [MBProgressHUD hideAllHUDsForView:topView animated:YES];
            }
            
            [MBProgressHUD showError:@"网络请求失败,请稍后再试哦"];
            
            //NSLog(@"error:%@",error);
            failure(error);
        }];
    }
}

+ (void)requestWithThePath:(NSString *)path
                      Data:(NSData *)data
                   KeyName:(NSString *)kName
                    Params:(NSDictionary *)params
                 isHudShow:(BOOL)isShow
                   Success:(HttpSuccessBlock)success
                   Failure:(HttpFailureBlock)failure {
    
    UIView *topView = [UIApplication sharedApplication].windows.lastObject;
    
    NSString *urlStr = [JMTool isStringLegal:path ByJudgeString:@"^http://.*"]?path:[NSString stringWithFormat:@"%@",IP_ADRESS_URL(path)];
    
    if (isShow) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MBProgressHUD *hud = [MBProgressHUD showMessage:@"loading..." toView:topView];
            
            [hud hideAnimated:YES afterDelay:13.f];
        });
    }
    
    _manager = [self sharedManager];
    
    [_manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:kName fileName:[NSString stringWithFormat:@"%@.jpg",[NSDate date]] mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (topView) {
            [MBProgressHUD hideAllHUDsForView:topView animated:YES];
        }
        
        //传递数据
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        //NSLog(@"JSON------>%@",JSON);
        
        //传递数据
        success(JSON);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (topView) {
            [MBProgressHUD hideAllHUDsForView:topView animated:YES];
        }
        
        [MBProgressHUD showError:@"网络请求失败,请稍后再试哦"];
        
        //NSLog(@"error:%@",error);
        
        failure(error);
    }];
}

+ (void)requestWithThePath:(NSString *)path
                  imgArray:(NSArray *)imgArray
              KeyNameArray:(NSArray *)kNameArray
                    Params:(NSDictionary *)params
                 isHudShow:(BOOL)isShow
                   Success:(HttpSuccessBlock)success
                   Failure:(HttpFailureBlock)failure {
    
    for (id object in imgArray) {
        NSAssert([object isKindOfClass:[UIImage class]] || [object isKindOfClass:[NSData class]] || [object isKindOfClass:[NSString class]], @"Undefined symbols in imgArray");
    }
    
    for (id object in kNameArray) {
        NSAssert([object isKindOfClass:[NSString class]], @"Undefined symbols in kNameArray");
    }
    
    UIView *topView = [UIApplication sharedApplication].windows.lastObject;
    
    NSString *urlStr = [JMTool isStringLegal:path ByJudgeString:@"^http://.*"]?path:[NSString stringWithFormat:@"%@",IP_ADRESS_URL(path)];
    
    if (isShow) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MBProgressHUD *hud = [MBProgressHUD showMessage:@"loading..." toView:topView];
            
            [hud hideAnimated:YES afterDelay:13.f];
        });
    }
    
    _manager = [self sharedManager];
    
    [_manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < (imgArray.count > kNameArray.count?kNameArray.count:imgArray.count) ; i++) {
            if ([imgArray[i] isKindOfClass:[NSData class]]) {
                [formData appendPartWithFileData:imgArray[i] name:kNameArray[i] fileName:[NSString stringWithFormat:@"%@.jpg",[NSDate date]] mimeType:@"image/jpeg"];
            }else if ([imgArray[i] isKindOfClass:[UIImage class]]) {
                UIImage *image = imgArray[i];
                NSData *data;
                if (UIImagePNGRepresentation(image) == nil) {
                    
                    data = UIImageJPEGRepresentation(image, 1);
                    
                } else {
                    
                    data = UIImagePNGRepresentation(image);
                }
                [formData appendPartWithFileData:data name:kNameArray[i] fileName:[NSString stringWithFormat:@"%@.jpg",[NSDate date]] mimeType:@"image/jpeg"];
            }else if ([imgArray[i] isKindOfClass:[NSString class]]) {
                UIImage *image = [UIImage imageNamed:imgArray[i]];
                NSData *data;
                if (UIImagePNGRepresentation(image) == nil) {
                    
                    data = UIImageJPEGRepresentation(image, 1);
                    
                } else {
                    
                    data = UIImagePNGRepresentation(image);
                }
                [formData appendPartWithFileData:data name:kNameArray[i] fileName:[NSString stringWithFormat:@"%@.jpg",[NSDate date]] mimeType:@"image/jpeg"];
            }
            
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (topView) {
            [MBProgressHUD hideAllHUDsForView:topView animated:YES];
        }
        
        //传递数据
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        //NSLog(@"JSON------>%@",JSON);
        
        //传递数据
        success(JSON);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (topView) {
            [MBProgressHUD hideAllHUDsForView:topView animated:YES];
        }
        
        [MBProgressHUD showError:@"网络请求失败,请稍后再试哦"];
        
        //NSLog(@"error:%@",error);
        
        failure(error);
    }];
}




















@end






























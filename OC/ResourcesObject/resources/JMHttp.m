//
//  JMHttp.m
//  ResourcesObject
//
//  Created by zhengxingxia on 2017/2/20.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

#import "JMHttp.h"
#import "JMTool.h"
#import "MBProgressHUD+NJ.h"
#import <CoreTelephony/CTCellularData.h>
//#import "NetErrorViewController.h"
//#import "Advertisement_VC.h"
#import "AppDelegate.h"

@implementation JMHttp

static AFHTTPSessionManager *_manager;

+ (AFHTTPSessionManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 20.f;
    });
    return _manager;
}

+ (BOOL)isHttpRequestStatusOK:(NSDictionary *)dict {
    if ([dict[@"code"] integerValue] == 1) {
        return YES;
    }else {
        return NO;
    }
}

+ (AFNetworkReachabilityStatus)currentNetStatus {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    return [reachabilityManager networkReachabilityStatus];
}

// 监测网络
+ (void)checkNetStatus {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];//打开监测
    
    //监测网络状态回调
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown://未知
            {
                
            }
                break;
                
            case AFNetworkReachabilityStatusNotReachable://无连接
            {
                //基本上监测到无连接 给出友好提示就够了
//                [MBProgressHUD showError:@"当前无网络"];
                
//                UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[NetErrorViewController alloc]init]];
//                AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//                if ([appDelegate.window.rootViewController isKindOfClass:[UINavigationController class]]) {
//                    UINavigationController *viewController = (UINavigationController*)appDelegate.window.rootViewController;
//                    UIView *subview = appDelegate.window.subviews.lastObject;
//                    if ([subview.viewController isKindOfClass:[Advertisement_VC class]]) {
//                        //不进行操作
//
//                    }else if (![viewController.viewControllers[0] isKindOfClass:[NetErrorViewController class]]) {
//                        appDelegate.window.rootViewController = navVC;
//                        [viewController removeFromParentViewController];
//                        viewController.view = nil;
//                    }
//                }
                
                setObjectForKey(@YES, IS_NETCONNECT_LOST);
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN://3G
            {
                if (getObject(IS_NETCONNECT_LOST) && [getObject(IS_NETCONNECT_LOST) boolValue]) {
                    setObjectForKey(@NO, IS_NETCONNECT_LOST);
                }
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi://WiFi
            {
                if (getObject(IS_NETCONNECT_LOST) && [getObject(IS_NETCONNECT_LOST) boolValue]) {
                    setObjectForKey(@NO, IS_NETCONNECT_LOST);
                }
            }
                break;
                
            default:
                
                break;
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:NetworkStatusDidChangeNotification object:nil userInfo:nil];
    }];
}

+ (void)dealWithNetError:(NSError *)error WithTimeOutAction:(void(^)())action {
    static int times = 0;
    switch (error.code) {
        case NSURLErrorTimedOut: //网络请求超时
            if (times < 2) {
                times++;
                action();
            }else {
                times = 0;
            }
            break;
        case NSURLErrorNotConnectedToInternet: //网络连接失败
        {
            CTCellularData *cellularData = [[CTCellularData alloc]init];
            CTCellularDataRestrictedState state = cellularData.restrictedState;
            switch (state) {
                case kCTCellularDataRestricted: //
                {
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"已为应用关闭数据权限" message:@"你可以在设置中为此应用打开权限" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    [alertVC addAction:cancel];
                    [alertVC addAction:sure];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[JMTool getCurrentVC] presentViewController:alertVC animated:YES completion:nil];
                    });
                }
                    break;
                case kCTCellularDataNotRestricted:
                    [MBProgressHUD showError:@"网络连接失败，请稍后再试哦"];
                    break;
                case kCTCellularDataRestrictedStateUnknown:
                    [MBProgressHUD showError:@"网络连接失败，请稍后再试哦"];
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
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
    
    NSString *urlStr = [JMTool isStringLegal:path ByJudgeString:@"^http[s]?://.*"]?path:[NSString stringWithFormat:@"%@",IP_ADRESS_URL(path)];
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    if (isShow) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MBProgressHUD *hud = [MBProgressHUD showMessage:@"loading..." toView:topView];
            
            [hud hide:YES afterDelay:_manager.requestSerializer.timeoutInterval];
        });
    }
    
    _manager = [self sharedManager];
    
    if ([method isEqualToString:@"POST"]) {   //发送post请求
        
        [_manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
            
            //            [self dealWithNetError:error WithTimeOutAction:^{
            //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //                    [self requestWithThePath:path Params:params Method:method isHudShow:isShow Success:success Failure:failure];
            //                });
            //            }];
            
            //NSLog(@"error:%@",error);
            failure(error);
        }];
    }else if ([method isEqualToString:@"GET"]){   //发送get请求
        [_manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
            
            //            [self dealWithNetError:error WithTimeOutAction:^{
            //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //                    [self requestWithThePath:path Params:params Method:method isHudShow:isShow Success:success Failure:failure];
            //                });
            //            }];
            
            //NSLog(@"error:%@",error);
            failure(error);
        }];
    }
}

+ (void)multPostWithThePath:(NSString *)path
                     Params:(NSDictionary *)params
           ConstructingBody:(HttpConstructingBody)constructingBody
                   Progress:(HttpProgressBlock)progress
                    Success:(HttpSuccessBlock)success
                    Failure:(HttpFailureBlock)failure {
    
    NSString *urlStr = [JMTool isStringLegal:path ByJudgeString:@"^http[s]?://.*"]?path:[NSString stringWithFormat:@"%@",IP_ADRESS_URL(path)];
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    _manager = [self sharedManager];
    
    [_manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (constructingBody) {
            constructingBody(formData);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        //NSLog(@"JSON------>%@",JSON);
        
        //传递数据
        if (success) {
            success(JSON);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //            [self dealWithNetError:error WithTimeOutAction:^{
        //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //                    [self multPostWithThePath:path Params:params ConstructingBody:constructingBody Progress:progress Success:success Failure:failure];
        //                });
        //            }];
        
        //NSLog(@"error:%@",error);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)requestWithThePath:(NSString *)path
                      Data:(NSData *)data
                   KeyName:(NSString *)kName
                    Params:(NSDictionary *)params
                 isHudShow:(BOOL)isShow
                   Success:(HttpSuccessBlock)success
                   Failure:(HttpFailureBlock)failure {
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[NSDate date]];
    [self requestWithThePath:path Data:data KeyName:kName FileName:fileName Params:params isHudShow:isShow Progress:^(NSProgress *uploadProgress) {
        
    } Success:success Failure:failure];
}

+ (void)requestWithThePath:(NSString *)path
                      Data:(NSData *)data
                   KeyName:(NSString *)kName
                  FileName:(NSString *)fileName
                    Params:(NSDictionary *)params
                 isHudShow:(BOOL)isShow
                  Progress:(HttpProgressBlock)progress
                   Success:(HttpSuccessBlock)success
                   Failure:(HttpFailureBlock)failure {
    
    UIView *topView = [UIApplication sharedApplication].windows.lastObject;
    
    if (isShow) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MBProgressHUD *hud = [MBProgressHUD showMessage:@"loading..." toView:topView];
            
            [hud hide:YES afterDelay:_manager.requestSerializer.timeoutInterval];
        });
    }
    [self multPostWithThePath:path Params:params ConstructingBody:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:kName fileName:[NSString stringWithFormat:@"%@.jpg",fileName] mimeType:@"image/jpeg"];
    } Progress:progress Success:^(id JSON) {
        if (topView) {
            [MBProgressHUD hideAllHUDsForView:topView animated:YES];
        }
        success(JSON);
    } Failure:^(id Error) {
        if (topView) {
            [MBProgressHUD hideAllHUDsForView:topView animated:YES];
        }
        failure(Error);
    }];
}





+ (void)requestWithThePath:(NSString *)path
                  imgArray:(NSArray *)imgArray
              KeyNameArray:(NSArray *)kNameArray
                    Params:(NSDictionary *)params
                 isHudShow:(BOOL)isShow
                   Success:(HttpSuccessBlock)success
                   Failure:(HttpFailureBlock)failure {
    [self requestWithThePath:path imgArray:imgArray KeyNameArray:kNameArray Params:params isHudShow:isShow Progress:^(NSProgress *uploadProgress) {
        
    } Success:success Failure:failure];
}

+ (void)requestWithThePath:(NSString *)path
                  imgArray:(NSArray *)imgArray
              KeyNameArray:(NSArray *)kNameArray
                    Params:(NSDictionary *)params
                 isHudShow:(BOOL)isShow
                  Progress:(HttpProgressBlock)progress
                   Success:(HttpSuccessBlock)success
                   Failure:(HttpFailureBlock)failure {
    
    for (id object in imgArray) {
        NSAssert([object isKindOfClass:[UIImage class]] || [object isKindOfClass:[NSData class]] || [object isKindOfClass:[NSString class]], @"Undefined symbols in imgArray");
    }
    
    for (id object in kNameArray) {
        NSAssert([object isKindOfClass:[NSString class]], @"Undefined symbols in kNameArray");
    }
    
    UIView *topView = [UIApplication sharedApplication].windows.lastObject;
    
    if (isShow) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MBProgressHUD *hud = [MBProgressHUD showMessage:@"loading..." toView:topView];
            
            [hud hide:YES afterDelay:_manager.requestSerializer.timeoutInterval];
        });
    }
    
    [self multPostWithThePath:path Params:params ConstructingBody:^(id<AFMultipartFormData>  _Nonnull formData) {
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
    } Progress:progress Success:^(id JSON) {
        if (topView) {
            [MBProgressHUD hideAllHUDsForView:topView animated:YES];
        }
        success(JSON);
    } Failure:^(id Error) {
        if (topView) {
            [MBProgressHUD hideAllHUDsForView:topView animated:YES];
        }
        failure(Error);
    }];
}





+ (void)requestVideoWithThePath:(NSString *)path
                           Data:(NSData *)data
                        KeyName:(NSString *)kName
                         Params:(NSDictionary *)params
                      isHudShow:(BOOL)isShow
                        Success:(HttpSuccessBlock)success
                        Failure:(HttpFailureBlock)failure {
    [self requestVideoWithThePath:path Data:data KeyName:kName Params:params isHudShow:isShow Progress:^(NSProgress *uploadProgress) {
        
    } Success:success Failure:failure];
}

+ (void)requestVideoWithThePath:(NSString *)path
                           Data:(NSData *)data
                        KeyName:(NSString *)kName
                         Params:(NSDictionary *)params
                      isHudShow:(BOOL)isShow
                       Progress:(HttpProgressBlock)progress
                        Success:(HttpSuccessBlock)success
                        Failure:(HttpFailureBlock)failure {
    
    UIView *topView = [UIApplication sharedApplication].windows.lastObject;
    
    if (isShow) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MBProgressHUD *hud = [MBProgressHUD showMessage:@"loading..." toView:topView];
            
            [hud hide:YES afterDelay:_manager.requestSerializer.timeoutInterval];
        });
    }
    
    [self multPostWithThePath:path Params:params ConstructingBody:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:kName fileName:[NSString stringWithFormat:@"%@.mp4",[NSDate date]] mimeType:@"video/mp4"];
    } Progress:progress Success:^(id JSON) {
        if (topView) {
            [MBProgressHUD hideAllHUDsForView:topView animated:YES];
        }
        success(JSON);
    } Failure:^(id Error) {
        if (topView) {
            [MBProgressHUD hideAllHUDsForView:topView animated:YES];
        }
        failure(Error);
    }];
}





+ (void)requestVideoWithThePath:(NSString *)path
                        imgData:(NSData *)imgData
                        imgName:(NSString *)imgName
                      videoData:(NSData *)videoData
                      videoName:(NSString *)videoName
                         Params:(NSDictionary *)params
                      isHudShow:(BOOL)isShow
                        Success:(HttpSuccessBlock)success
                        Failure:(HttpFailureBlock)failure {
    
    [self requestVideoWithThePath:path imgData:imgData imgName:imgName videoData:videoData videoName:videoName Params:params isHudShow:isShow Progress:^(NSProgress *uploadProgress) {
        
    } Success:success Failure:failure];
}

+ (void)requestVideoWithThePath:(NSString *)path
                        imgData:(NSData *)imgData
                        imgName:(NSString *)imgName
                      videoData:(NSData *)videoData
                      videoName:(NSString *)videoName
                         Params:(NSDictionary *)params
                      isHudShow:(BOOL)isShow
                       Progress:(HttpProgressBlock)progress
                        Success:(HttpSuccessBlock)success
                        Failure:(HttpFailureBlock)failure {
    UIView *topView = [UIApplication sharedApplication].windows.lastObject;
    
    if (isShow) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MBProgressHUD *hud = [MBProgressHUD showMessage:@"loading..." toView:topView];
            
            [hud hide:YES afterDelay:_manager.requestSerializer.timeoutInterval];
        });
    }
    
    [self multPostWithThePath:path Params:params ConstructingBody:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imgData name:imgName fileName:[NSString stringWithFormat:@"%@.jpg",[NSDate date]] mimeType:@"image/jpeg"];
        
        [formData appendPartWithFileData:videoData name:videoName fileName:[NSString stringWithFormat:@"%@.mp4",[NSDate date]] mimeType:@"video/mp4"];
    } Progress:progress Success:^(id JSON) {
        if (topView) {
            [MBProgressHUD hideAllHUDsForView:topView animated:YES];
        }
        success(JSON);
    } Failure:^(id Error) {
        if (topView) {
            [MBProgressHUD hideAllHUDsForView:topView animated:YES];
        }
        failure(Error);
    }];
}













@end






























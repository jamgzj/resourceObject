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
#import <CoreTelephony/CTCellularData.h>

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
    if ([dict[@"status"] integerValue] == 200) {
        return YES;
    }else {
        return NO;
    }
}

// 监测网络
+ (void)checkNetStatus
{
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
                [MBProgressHUD showError:@"当前无网络"];
                [JMTool setObject:@YES ForKey:IS_NETCONNECT_LOST];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN://3G
            {
                if ([JMTool getObjectForKey:IS_NETCONNECT_LOST] && [[JMTool getObjectForKey:IS_NETCONNECT_LOST] boolValue]) {
                    [JMTool setObject:@NO ForKey:IS_NETCONNECT_LOST];
                    [[NSNotificationCenter defaultCenter]postNotificationName:REFRESH_UI object:nil userInfo:nil];
                }
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi://WiFi
            {
                if ([JMTool getObjectForKey:IS_NETCONNECT_LOST] && [[JMTool getObjectForKey:IS_NETCONNECT_LOST] boolValue]) {
                    [JMTool setObject:@NO ForKey:IS_NETCONNECT_LOST];
                    [[NSNotificationCenter defaultCenter]postNotificationName:REFRESH_UI object:nil userInfo:nil];
                }
            }
                break;
                
            default:
                
                break;
        }
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
                    [[JMTool getCurrentVC] presentViewController:alertVC animated:YES completion:nil];
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
    
    NSString *urlStr = [JMTool isStringLegal:path ByJudgeString:@"^http://.*"]?path:[NSString stringWithFormat:@"%@",IP_ADRESS_URL(path)];
    
    if (isShow) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MBProgressHUD *hud = [MBProgressHUD showMessage:@"loading..." toView:topView];
            
            [hud hideAnimated:YES afterDelay:_manager.requestSerializer.timeoutInterval];
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
            
            [self dealWithNetError:error WithTimeOutAction:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self requestWithThePath:path Params:params Method:method isHudShow:isShow Success:success Failure:failure];
                });
            }];
            
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
            
            [self dealWithNetError:error WithTimeOutAction:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self requestWithThePath:path Params:params Method:method isHudShow:isShow Success:success Failure:failure];
                });
            }];
            
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
            
            [hud hideAnimated:YES afterDelay:_manager.requestSerializer.timeoutInterval];
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
        
        [self dealWithNetError:error WithTimeOutAction:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self requestWithThePath:path Data:data KeyName:kName Params:params isHudShow:isShow Success:success Failure:failure];
            });
        }];
        
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
            
            [hud hideAnimated:YES afterDelay:_manager.requestSerializer.timeoutInterval];
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
        
        [self dealWithNetError:error WithTimeOutAction:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self requestWithThePath:path imgArray:imgArray KeyNameArray:kNameArray Params:params isHudShow:isShow Success:success Failure:failure];
            });
        }];
        
        //NSLog(@"error:%@",error);
        
        failure(error);
    }];
}




















@end






























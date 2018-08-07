//
//  JMMapSkip.m
//  Seen
//
//  Created by CMVIOS1 on 2017/7/13.
//  Copyright © 2017年 Amor. All rights reserved.
//

#import "JMMapSkip.h"
#import <JZLocationConverter/JZLocationConverter.h>
#import <MapKit/MapKit.h>

@implementation JMMapSkip

//百度地图
static NSString *const Baidu_String = @"baidumap://";

//高德地图
static NSString *const AM_String = @"iosamap://";

//谷歌地图
static NSString *const Google_String = @"comgooglemaps://";

//腾讯地图
static NSString *const QQ_String = @"qqmap://";

static inline BOOL canOpenMapWithString(NSString *string){
    return [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:string]];
}

static inline BOOL canOpenBaiduMap(){
    return canOpenMapWithString(Baidu_String);
}

static inline BOOL canOpenGaodeMap(){
    return canOpenMapWithString(AM_String);
}

static inline BOOL canOpenGoogleMap(){
    return canOpenMapWithString(Google_String);
}

static inline BOOL canOpenQQMap(){
    return canOpenMapWithString(QQ_String);
}

+ (void)skipMapToDestination:(CLLocationCoordinate2D)location WithTitle:(NSString *)title {
    if (!title || [title isEqualToString:@""]) {
        title = @"目的地";
    }
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"导航到该位置" message:@"打开以下地图进行实时车载导航" preferredStyle:UIAlertControllerStyleActionSheet];
    if (canOpenBaiduMap()) {
        UIAlertAction *baiduAction = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self skipBaiduMapToLocation:location WithTitle:title];
        }];
        [alertVC addAction:baiduAction];
    }
    
    if (canOpenGaodeMap()) {
        UIAlertAction *gaodeAction = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self skipAMapToLocation:location WithTitle:title];
        }];
        [alertVC addAction:gaodeAction];
    }
    
    if (canOpenGoogleMap()) {
        UIAlertAction *googleAction = [UIAlertAction actionWithTitle:@"google地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self skipGoogleMapToLocation:location WithTitle:title];
        }];
        [alertVC addAction:googleAction];
    }
    
    if (canOpenQQMap()) {
        UIAlertAction *qqAction = [UIAlertAction actionWithTitle:@"腾讯地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self skipQQMapToLocation:location WithTitle:title];
        }];
        [alertVC addAction:qqAction];
    }
    
    UIAlertAction *orignAction = [UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self skipOrignMapToLocation:location WithTitle:title];
    }];
    [alertVC addAction:orignAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:cancelAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *currentVC = [self getCurrentVC];
        [currentVC presentViewController:alertVC animated:YES completion:nil];
    });
}

/**
 跳转百度地图导航

 @param location <#location description#>
 @param destTitle <#destTitle description#>
 */
+ (void)skipBaiduMapToLocation:(CLLocationCoordinate2D)location WithTitle:(NSString *)destTitle {
    NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=%@&mode=driving&coord_type=gcj02",location.latitude, location.longitude,@"目的地"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

/**
 跳转高德地图导航
 
 @param location <#location description#>
 @param destTitle <#destTitle description#>
 */
+ (void)skipAMapToLocation:(CLLocationCoordinate2D)location WithTitle:(NSString *)destTitle {
    location = [JZLocationConverter bd09ToGcj02:location];
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"看到啦",@"openSeen",location.latitude, location.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

/**
 跳转google地图导航
 
 @param location <#location description#>
 @param destTitle <#destTitle description#>
 */
+ (void)skipGoogleMapToLocation:(CLLocationCoordinate2D)location WithTitle:(NSString *)destTitle {
    location = [JZLocationConverter bd09ToGcj02:location];
    NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"看到啦",@"openSeen",location.latitude, location.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

/**
 跳转腾讯地图导航
 
 @param location <#location description#>
 @param destTitle <#destTitle description#>
 */
+ (void)skipQQMapToLocation:(CLLocationCoordinate2D)location WithTitle:(NSString *)destTitle {
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    CLLocationCoordinate2D currentCoor = [JZLocationConverter wgs84ToGcj02:currentLocation.placemark.coordinate];
    
    location = [JZLocationConverter bd09ToGcj02:location];
    NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&from=%@&fromcoord=%f,%f&to=%@&tocoord=%f,%f&policy=1&referer=%@",@"当前位置",currentCoor.latitude,currentCoor.longitude,destTitle,location.latitude, location.longitude,@"看到啦"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

/**
 跳转苹果原生地图导航
 
 @param location <#location description#>
 @param destTitle <#destTitle description#>
 */
+ (void)skipOrignMapToLocation:(CLLocationCoordinate2D)location WithTitle:(NSString *)destTitle {
    //当前的位置
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    
    //目的地的位置
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:[JZLocationConverter bd09ToWgs84:location] addressDictionary:nil]];
    toLocation.name = destTitle;
    
    NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
    
    //
    NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
    
    //打开苹果自身地图应用，并呈现特定的item
    [MKMapItem openMapsWithItems:items launchOptions:options];
}

+ (UIViewController *)getCurrentVC {
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}






















@end



















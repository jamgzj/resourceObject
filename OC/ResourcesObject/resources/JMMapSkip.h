//
//  JMMapSkip.h
//  Seen
//
//  Created by CMVIOS1 on 2017/7/13.
//  Copyright © 2017年 Amor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

// 跳转第三方地图导航 封装类
@interface JMMapSkip : NSObject

/**
 跳转第三方地图（alert方式）

 @param location 目的地位置
 @param title    目的地标题
 */
+ (void)skipMapToDestination:(CLLocationCoordinate2D)location WithTitle:(NSString *)title;

@end

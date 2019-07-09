//
//  JMReachability.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/17.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    JMReachbilityNetworkStatusNotUnknown       = -1,
    JMReachbilityNetworkStatusNotReachable     = 0,
    JMReachbilityNetworkStatusReachableViaWWAN = 1,
    JMReachbilityNetworkStatusReachableViaWiFi = 2,
} JMReachbilityNetworkStatus;

extern NSString * const JMReachabilityChangedNotification;

@interface JMReachability : NSObject

+ (JMReachbilityNetworkStatus)networkReachabilityStatus;

+ (BOOL)reachable;

+ (BOOL)reachableViaWWAN;

+ (BOOL)reachableViaWiFi;

+ (void)startMonitoring;

+ (void)stopMonitoring;

+ (void)reachbilityNetworkStatusDidChanged:(void(^)(JMReachbilityNetworkStatus status))callback;

@end

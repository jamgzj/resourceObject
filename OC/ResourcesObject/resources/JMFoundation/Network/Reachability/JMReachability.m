//
//  JMReachability.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/17.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "JMReachability.h"
#import <AFNetworking/AFNetworking.h>

NSString * const JMReachabilityChangedNotification = @"JMReachabilityChangedNotification";

@implementation JMReachability

+ (JMReachbilityNetworkStatus)networkReachabilityStatus
{
    return [self convertStatus:[[AFNetworkReachabilityManager manager] networkReachabilityStatus]];
}

+ (BOOL)reachable
{
    return [[AFNetworkReachabilityManager manager] isReachable];
}

+ (BOOL)reachableViaWWAN
{
    return [[AFNetworkReachabilityManager manager] isReachableViaWWAN];
}

+ (BOOL)reachableViaWiFi
{
    return [[AFNetworkReachabilityManager manager] isReachableViaWiFi];
}

+ (void)startMonitoring
{
    [[AFNetworkReachabilityManager manager] startMonitoring];
}

+ (void)stopMonitoring
{
    [[AFNetworkReachabilityManager manager] stopMonitoring];
}

+ (void)reachbilityNetworkStatusDidChanged:(void(^)(JMReachbilityNetworkStatus status))callback
{
    [[AFNetworkReachabilityManager manager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (callback) {
            callback([self convertStatus:status]);
        }
    }];
}

+ (JMReachbilityNetworkStatus)convertStatus:(AFNetworkReachabilityStatus)status
{
    return (JMReachbilityNetworkStatus)status;
}

@end

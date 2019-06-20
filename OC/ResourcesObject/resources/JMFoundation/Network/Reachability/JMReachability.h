//
//  JMReachability.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/17.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    JMReachbilityNetworkStatusNotReachable = 0,
    JMReachbilityNetworkStatusReachableViaWiFi,
    JMReachbilityNetworkStatusReachableViaWWAN
} JMReachbilityNetworkStatus;

extern NSString *JMReachabilityChangedNotification;

@interface JMReachability : NSObject

@end

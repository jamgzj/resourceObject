//
//  JMUtilities.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMUtilities : NSObject

+ (NSString *)stringWithDayMonthHourMinuteFormatDate: (NSDate*)date;
+ (NSString *)stringWithoutZeroWithDayMonthHourMinuteFormatDate: (NSDate*)date;
+ (NSString *)timeLineIssued:(NSTimeInterval)timeInterval;
+ (NSString *)mmddTypeDateStringWithMicrosecond:(NSTimeInterval)microsecond
;
+ (NSString *)mm2_ddBHHmmTypeDateStringWithMicrosecond:(NSTimeInterval)microsecond;
+ (NSString *)mm2_ddBHHmmTypeDateStringWithoutZeroWithMicrosecond:(NSTimeInterval)microsecond;

@end

//
//  JMUtilities.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "JMUtilities.h"
#import "NSDate+JMBase.h"

//Y: 月, R: 日, _: 空格
#define MMYddR_HHmm @"MM月dd日 HH:mm"
#define MM_dd @"MM-dd"
//B: blank 2_: -
#define MM2_ddBHHmm @"MM-dd HH:mm"

@implementation JMUtilities

+ (NSString *)timeLineIssued:(NSTimeInterval)timeInterval
{
    NSTimeInterval timeIntervalSince1970 = [NSDate date].timeIntervalSince1970;
    NSTimeInterval timeIntervalDiff = (timeIntervalSince1970 - timeInterval);
    if (timeIntervalDiff < 60) {
        return @"1分钟内";
    } else if (timeIntervalDiff < 3600 && timeIntervalDiff >= 60 ){
        NSNumber *minitesNum = [NSNumber numberWithInteger: (NSInteger)timeIntervalDiff/60];
        return [NSString stringWithFormat: @"%@分钟前", minitesNum];
    } else if (timeIntervalDiff < 3600*24 && timeIntervalDiff >= 3600 ){
        NSNumber *hoursNum = [NSNumber numberWithInteger: (NSInteger)timeIntervalDiff/3600];
        return [NSString stringWithFormat: @"%@小时前", hoursNum];
    } else {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970: timeInterval];
        NSString *fromatDateString = [date stringWithFormat:MM_dd];
        return fromatDateString;
    }
}

+ (NSString *)dateStringWithMicrosecond:(NSTimeInterval)microsecond
                             formatType:(NSString *)formatType
{
    NSTimeInterval timeIntervalSince1970 = microsecond/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: timeIntervalSince1970];
    NSString *fromatDateString = [date stringWithFormat:formatType];
    return fromatDateString;
}


+ (NSString *)mm2_ddBHHmmTypeDateStringWithMicrosecond:(NSTimeInterval)microsecond
{
    return [self dateStringWithMicrosecond:microsecond formatType:MM2_ddBHHmm];
}

+ (NSString *)mm2_ddBHHmmTypeDateStringWithoutZeroWithMicrosecond:(NSTimeInterval)microsecond
{
    double leftSeconds = fmod(microsecond/1000, 3600*24);
    if (leftSeconds < 60) {
        return [self dateStringWithMicrosecond:microsecond formatType:MM_dd];
    } else {
        return [self dateStringWithMicrosecond:microsecond formatType:MM2_ddBHHmm];
    }
}

+ (NSString *)mmddTypeDateStringWithMicrosecond:(NSTimeInterval)microsecond
{
    return [self dateStringWithMicrosecond:microsecond formatType:MM_dd];
}

+ (NSString *)stringWithDayMonthHourMinuteFormatDate: (NSDate*)date
{
    if (!date) {
        return nil;
    }
    
    NSDateFormatter* timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setTimeStyle: NSDateFormatterShortStyle];
    NSString *formattedTime = [timeFormatter stringFromDate: date];
    
    NSString* formattedDate = [date stringWithFormat:MM_dd];
    return [NSString stringWithFormat:@"%@ %@", formattedDate, formattedTime];
}

+ (NSString *)stringWithoutZeroWithDayMonthHourMinuteFormatDate: (NSDate*)date
{
    if (!date) {
        return nil;
    }
    
    NSString* formattedTime = nil;
    double leftSeconds = fmod(date.timeIntervalSince1970, 3600*24);
    if (leftSeconds >= 60) {
        NSDateFormatter* timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setTimeStyle: NSDateFormatterShortStyle];
        formattedTime = [timeFormatter stringFromDate: date];
    }
    
    NSString* formattedDate = [date stringWithFormat:MM_dd];
    
    if (formattedTime == nil) {
        return [NSString stringWithFormat:@"%@", formattedDate];
    } else {
        return [NSString stringWithFormat:@"%@ %@", formattedDate, formattedTime];
    }
}

@end

//
//  NSDate+JMBase.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "NSDate+JMBase.h"
#import "JMMacro.h"

@implementation NSDate (JMBase)

static NSString* const FORMAT_yyyyMMdd = @"yyyy-MM-dd";

- (NSString *)stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSString *string = [formatter stringFromDate:self];
    return string;
}

+ (NSInteger)currentYear
{
    NSString* year = [[NSDate date] stringWithFormat:@"yyyy"];
    return [year integerValue];
}

+ (NSDate *)beginDate
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components: NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|kCFCalendarUnitMinute|kCFCalendarUnitSecond fromDate: date];
    components.hour = 8;
    components.minute = 0;
    components.second = 0;
    NSDate *beginDate = [calendar dateFromComponents:components];
    return beginDate;
}

+ (instancetype)dateWithDays:(NSInteger)days
                   sinceDate:(NSDate *)date
{
    NSTimeInterval daySeconds = 24*3600.0f*days;
    
    return [self dateWithTimeInterval:daySeconds sinceDate:date];
}

+ (NSDate *)oneWeakBeforeDate
{
    NSDate *beginDate = [self beginDate];
    
    NSDate *oneWeakBeforeDate = [self dateWithDays:-7 sinceDate:beginDate];
    
    return oneWeakBeforeDate;
}

- (NSDate*)dateByAddingNumberOfDays: (NSInteger)numberOfDays
{
    return [NSDate dateWithDays:numberOfDays sinceDate:self];
}

+ (NSDate*)dateFromyyyyMMddFormatString: (NSString*)string
{
    return [self dateFromString:string ofFormat:FORMAT_yyyyMMdd];
}

+ (NSDate*)dateFromyyyyMMddFormatString: (NSString*)string formart:(NSString*)format
{
    return [self dateFromString:string ofFormat:format];
}

+ (NSDate*)dateFromString: (NSString*)string ofFormat: (NSString*)format
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString:string];
}

- (NSString*)stringWithyyyyMMddFormat
{
    return [self stringWithFormat:FORMAT_yyyyMMdd];
}

- (NSString*)stringWithMMddFormat
{
    return [self stringWithFormat:@"MM-dd"];
}

+ (NSString *)currentDateFormated:(NSString *)format
{
    NSDate *date = [NSDate date];
    return [date stringWithFormat:format];
}

// return date string with yyyy-MM-dd format by default
- (NSString*)nextDateWithPeriodType:(JMDatePeriodType)periodType period:(NSInteger)period
{
    return [self nextDateWithPeriodType:periodType period:period dateFormat:nil];
}

- (NSString*)nextDateWithPeriodType:(JMDatePeriodType)periodType period:(NSInteger)period dateFormat:(NSString*)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = !JMIsEmptyString(dateFormat)?dateFormat:@"yyyy-MM-dd";
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    switch (periodType) {
        case JMDatePeriodTypeWeek:
            [components setDay:7 * period];
            break;
        case JMDatePeriodTypeMonth:
            [components setMonth:1 * period];
            break;
    }
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *mDate = [calender dateByAddingComponents:components toDate:self options:0];
    return [formatter stringFromDate:mDate];
}

// yyyy-MM-dd HH:mm:ss format
- (NSString*)stringWithyyyyMMddHHmmssFormat
{
    return [self stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitDay fromDate:self];
    
    return [@(comps.day) stringValue];
}

- (NSString *)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:self];
    
    return [@(comps.month) stringValue];
}

- (NSString *)year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear fromDate:self];
    
    return [@(comps.year) stringValue];
}

@end

//
//  NSDate+JMBase.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JMDatePeriodType) {
    JMDatePeriodTypeWeek,
    JMDatePeriodTypeMonth
};

@interface NSDate (JMBase)

- (NSString *)stringWithFormat:(NSString *)format;
+ (NSInteger)currentYear;

+ (NSDate *)oneWeakBeforeDate;

- (NSDate*)dateByAddingNumberOfDays: (NSInteger)numberOfDays;

// date from string with yyyy-MM-dd format
+ (NSDate*)dateFromyyyyMMddFormatString: (NSString*)string;

+ (NSDate*)dateFromyyyyMMddFormatString: (NSString*)string formart:(NSString*)format;

- (NSString *)day;
- (NSString *)year;
- (NSString *)month;

// yyyy-MM-dd HH:mm:ss format
- (NSString*)stringWithyyyyMMddHHmmssFormat;

- (NSString*)stringWithyyyyMMddFormat;

- (NSString*)stringWithMMddFormat;

+ (NSString*)currentDateFormated:(NSString *)format;

// return date string with yyyy-MM-dd format by default
- (NSString*)nextDateWithPeriodType:(JMDatePeriodType)periodType period:(NSInteger)period;
- (NSString*)nextDateWithPeriodType:(JMDatePeriodType)periodType period:(NSInteger)period dateFormat:(NSString*)dateFormat;

@end

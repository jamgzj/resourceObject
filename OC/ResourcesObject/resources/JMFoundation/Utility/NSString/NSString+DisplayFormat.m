//
//  NSString+DisplayFormat.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "NSString+DisplayFormat.h"
#import "NSString+JMBase.h"

@implementation NSString (DisplayFormat)

static NSString* const SPACE = @" ";
static NSString* const EMPTY = @"";
static NSString* const MASK = @"*";

//去掉字符间的空格
- (NSString *)removeSpace
{
    NSString *tempStr = [self stringByReplacingOccurrencesOfString:SPACE withString:EMPTY];
    return tempStr;
}

//手机号格式化
- (NSString *)phoneNumberRegularization
{
    return [self stringRegularizationByGroupCounts:@[@3, @4, @4]];
}

//银行卡号格式化
- (NSString *)bankCardNumberRegularization
{
    return [self stringRegularizationByGroupCounts:@[@4]];
}

- (NSString*)identificationRegularization
{
    return [self stringRegularizationByGroupCounts:@[@6, @4]];
}

- (NSString*)phoneNumberRegularizationWithMask
{
    NSString* string = [self removeSpace];
    NSRange rangeOfMask = NSMakeRange(3, 4);
    NSString* mask = [MASK stringByRepeating:rangeOfMask.length];
    string = [string stringByReplacingCharactersInRange:rangeOfMask withString:mask];
    return [string phoneNumberRegularization];
}

- (NSString*)identificationRegularizationWithMask
{
    static NSInteger const MASK_LEN = 4;
    NSString* string = [self removeSpace];
    NSRange rangeOfMask;
    if (string.length > MASK_LEN * 2) {
        rangeOfMask = NSMakeRange(MASK_LEN, string.length - MASK_LEN*2);
    } else {
        rangeOfMask = NSMakeRange(0, string.length);
    }
    
    NSString* mask = [MASK stringByRepeating:rangeOfMask.length];
    string = [string stringByReplacingCharactersInRange:rangeOfMask withString:mask];
    return [string identificationRegularization];
}

- (NSString*)stringRegularizationByGroupCounts: (NSArray<NSNumber*>*)groupCounts
{
    return [self stringRegularizationByGroupCounts:groupCounts needToTrimSpace:YES];
}

- (NSString*)stringRegularizationByGroupCounts: (NSArray<NSNumber*>*)groupCounts
                               needToTrimSpace: (BOOL)needToTrimSpace
{
    if (!groupCounts || groupCounts.count == 0) {
        return self;
    }
    
    NSString* plain = [self removeSpace];
    NSMutableString* regularized = [[NSMutableString alloc] init];
    NSInteger currentPos = 0;
    NSInteger countIndex = 0;
    while (currentPos < plain.length) {
        NSNumber* countNumber = countIndex < groupCounts.count ? [groupCounts objectAtIndex:countIndex] : groupCounts.lastObject;
        NSInteger count = [countNumber integerValue];
        if (currentPos + count > plain.length) {
            [regularized appendString:[plain substringFromIndex:currentPos]];
            break;
        } else {
            [regularized appendString:[plain substringWithRange:NSMakeRange(currentPos, count)]];
            currentPos += count;
            [regularized appendString:SPACE];
        }
        countIndex++;
    }
    
    NSString* result = needToTrimSpace ? [regularized stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] : [regularized copy];
    return result;
}

#pragma mark - 时间处理

//转换时间格式
- (NSString *)dateRegularization
{
    if (![NSString isStringContainNumberWith:self]) {
        return self;
    }
    
    NSString *date = self;
    //将时间字符转date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [dateFormatter setTimeZone:timeZone];
    NSDate* inputDate = [dateFormatter dateFromString:date];
    
    if (inputDate == nil) {
        inputDate = [NSString getValidDateWithDateTime:date];
    }
    
    if (!inputDate) {
        return self;
    }
    
    //将date转字符
    NSDateFormatter* toFormatter = [[NSDateFormatter alloc] init];
    [toFormatter setDateStyle:NSDateFormatterMediumStyle];
    [toFormatter setTimeStyle:NSDateFormatterShortStyle];
    [toFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *targetTime = [toFormatter stringFromDate:inputDate];
    
    return targetTime;
}

+ (NSDate *)getValidDateWithDateTime:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* validDate = [dateFormatter dateFromString:date];
    
    NSInteger dateIntegerValue = date.integerValue;
    static NSInteger const DayIndex = 6;
    while (validDate == nil) {
        
        dateIntegerValue--;
        
        NSString *dateString = @(dateIntegerValue).stringValue;
        if (dateString.length <=  DayIndex) {
            break;
        }
        
        NSInteger dayIntegerValue = [dateString substringFromIndex:DayIndex].integerValue;
        if (dayIntegerValue < 28) {
            break;
        }
        
        validDate = [dateFormatter dateFromString:dateString];
    }
    
    return validDate;
}

+ (BOOL)isStringContainNumberWith:(NSString *)str {
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    //count是str中包含[0-9]数字的个数，只要count>0，说明str中包含数字
    if (count > 0) {
        return YES;
    }
    return NO;
}

+ (NSString *)remainTime:(NSTimeInterval)timeInterval
{
    return [self remainTime:timeInterval showHour:NO];
}

+ (NSString *)remainTime:(NSTimeInterval)timeInterval showHour:(BOOL)showHour
{
    NSInteger ti = (NSInteger)timeInterval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600) % 60;
    NSString *remainTime = [NSString stringWithFormat:@"%02ld:%02ld",(long)minutes,(long)seconds];
    if (hours > 0 || showHour) {
        remainTime = [NSString stringWithFormat:@"%02ld:%@",(long)hours,remainTime];
    }
    return remainTime;
}

@end

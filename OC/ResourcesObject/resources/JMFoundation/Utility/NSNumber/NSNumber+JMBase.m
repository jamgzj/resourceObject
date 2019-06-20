//
//  NSNumber+LBKBase.m
//  LBKFoundation
//
//  Created by Terry Tan on 07/08/2017.
//  Copyright © 2017 Shanghai DataSeed Information Technology Co.,Ltd. All rights reserved.
//

#import "NSNumber+JMBase.h"

@implementation NSNumber (JMBase)

- (double)doubleValuePrecised
{
    NSDecimal decimal = [self decimalValue];
    NSDecimalNumber* decimalNumber = [NSDecimalNumber decimalNumberWithDecimal:decimal];
    return [decimalNumber doubleValue];
}

#pragma mark - Formatters
+ (NSNumberFormatter*)decimalFormatter
{
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.positiveFormat = @",###";
    return formatter;
}

+ (NSNumberFormatter*)decimalFormatterAndTwoDigits
{
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.positiveFormat = @"###,##0.00;";
    return formatter;
}

+ (NSNumberFormatter*)decimalFormatterAndDigits
{
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return formatter;
}

#pragma mark - Number Calculation
- (NSNumber*)numberByDividingByOneHundred
{
    return [[NSDecimalNumber decimalNumberWithString:self.stringValue] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
}

#pragma mark - Formatting
- (NSString*)stringWithDecimalFormat
{
    return [[NSNumber decimalFormatter] stringFromNumber:self];
}

- (NSString*)stringWithDecimalFormatAndDigits
{
    return [[NSNumber decimalFormatterAndDigits] stringFromNumber:self];
}

- (NSString*)stringWithDecimalFormatAndTwoDigits
{
    return [[NSNumber decimalFormatterAndTwoDigits] stringFromNumber:self];
}

- (NSString*)stringWithPercenatgeFormat
{
    NSString* decimal = [self stringWithDecimalFormat];
    return [NSString stringWithFormat:@"%@%%", decimal];
}

@end

//
//  NSNumber+LBKBase.h
//  LBKFoundation
//
//  Created by Terry Tan on 07/08/2017.
//  Copyright © 2017 Shanghai DataSeed Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (JMBase)

- (double)doubleValuePrecised;

+ (NSNumberFormatter*)decimalFormatterAndTwoDigits;
+ (NSNumberFormatter*)decimalFormatter;

- (NSNumber*)numberByDividingByOneHundred;

- (NSString*)stringWithDecimalFormat;
- (NSString*)stringWithDecimalFormatAndDigits;
- (NSString*)stringWithDecimalFormatAndTwoDigits;
- (NSString*)stringWithPercenatgeFormat;

@end

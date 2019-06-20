//
//  NSString+JMBase.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (JMBase)

+ (BOOL)jm_isStringNullOrEmpty: (id)string;
+ (NSString *)uniqueUUID;
+ (BOOL)isNullEmptyOrEmptyUUIDString: (NSString*)string;
+ (NSString*)queryStringByAppendingArrayURLQueryValue: (NSArray*)array withKey: (NSString*)key;
+ (BOOL)isString: (NSString*)string equalToAnotherString: (NSString*)anotherString;

- (NSNumber *)isNumberGreaterThanZero;
- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options;
- (BOOL)containsString:(NSString *)string;
- (NSString *)urlencode;
- (NSString *)urldecode;
- (NSString *)md5HexDigest;
- (NSString *)base64encode;
- (NSString *)base64decode;
- (NSString *)stringByAddParams:(NSDictionary *)params;

- (NSDictionary *) toDictionary;

- (NSUInteger)numberOfOcurrenceOfSubString: (NSString*)subString;
- (NSInteger)numberOfLines;

- (NSString *)appendLineWrap:(NSUInteger)lineWrapCount;

- (NSString *)domainFieldUrlString;

- (NSString*)maskedMobileNumber;

- (NSString*)stringByAppendingArrayURLQueryValue: (NSArray*)array withKey: (NSString*)key;

- (NSString*)stringByRemovingSpaces;

- (NSString*)stringByRepeating: (NSInteger)times;

- (BOOL)hasHttpPrefix;

+ (NSString*)stringForPathOfApplicationSupportFolder;

- (NSData*)dataWithMD5Hash;
- (NSString*)hashSHA256;

- (double)doubleValuePrecised;

- (BOOL)isValidPhoneNumber;

- (NSInteger)integerValueByParseAsDecimalString;

- (NSString*)stringByRemovingPhoneNumberSpecialChars;

- (NSString*)removeSubfixAllZeroDigits;

- (NSRange)rangeOfStringByTrimmingCharactersNotInSet: (NSCharacterSet*)charset;

- (NSString*)stringByTrimmingCharactersNotInSet: (NSCharacterSet*)charset;

- (CGSize)sizeWithFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize;

@end

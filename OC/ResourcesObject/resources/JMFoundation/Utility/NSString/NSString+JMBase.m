//
//  NSString+JMBase.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "NSString+JMBase.h"
#import "NSURL+JMBase.h"
#import <CommonCrypto/CommonCrypto.h>
#import "JMMacro.h"

@implementation NSString (JMBase)

+ (BOOL)jm_isStringNullOrEmpty: (id)string
{
    if (string == nil) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]]) {
        return ((NSString*)string).length == 0;
    } else {
        return YES;
    }
}

- (NSDictionary *) toDictionary
{
    NSError *error = nil;
    
    NSDictionary *toDictionary = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    
    if (error) {
        return nil;
    }else {
        if ([toDictionary isKindOfClass:[NSDictionary class]]) {
            return toDictionary;
        }
        return nil;
    }
}

+ (NSString *)uniqueUUID
{
    return [self generateUUID];
}

+ (NSString *)generateUUID
{
    NSString *result = nil;
    
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid)
    {
        result = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
    }
    
    return result;
}

- (NSString *)stringByAddParams:(NSDictionary *)params
{
    if (!params || params.count == 0) {
        return self;
    }
    
    NSURL* url = [NSURL URLWithString:self];
    url = [url URLByAddParams:params];
    return [url absoluteString];
}

- (NSNumber *)isNumberGreaterThanZero
{
    NSString *regEx = @"^[1-9]\\d*|0$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    BOOL isMatch = [pred evaluateWithObject:self];
    if (isMatch) {
        return [NSNumber numberWithDouble:[self integerValue]];
    }
    return nil;
}

- (NSString *)base64encode
{
    NSData* originData = [self dataUsingEncoding:NSASCIIStringEncoding];
    
    return [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
- (NSString *)base64decode
{
    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
}

-(NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++)
        
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash lowercaseString];
}

- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions)options {
    NSRange rng = [self rangeOfString:string options:options];
    return rng.location != NSNotFound;
}

- (BOOL)containsString:(NSString *)string {
    return [self containsString:string options:0];
}

- (NSString *)urldecode {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlencode {
    NSString *encUrl = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSUInteger len = [encUrl length];
    const char *c;
    c = [encUrl UTF8String];
    NSString *ret = @"";
    for(int i = 0; i < len; i++) {
        switch (*c) {
            case '~':
                ret = [ret stringByAppendingString:@"%7E"];
                break;
            case '/':
                ret = [ret stringByAppendingString:@"%2F"];
                break;
            case '\'':
                ret = [ret stringByAppendingString:@"%27"];
                break;
            case ';':
                ret = [ret stringByAppendingString:@"%3B"];
                break;
            case '?':
                ret = [ret stringByAppendingString:@"%3F"];
                break;
            case ':':
                ret = [ret stringByAppendingString:@"%3A"];
                break;
            case '@':
                ret = [ret stringByAppendingString:@"%40"];
                break;
            case '&':
                ret = [ret stringByAppendingString:@"%26"];
                break;
            case '=':
                ret = [ret stringByAppendingString:@"%3D"];
                break;
            case '+':
                ret = [ret stringByAppendingString:@"%2B"];
                break;
            case '$':
                ret = [ret stringByAppendingString:@"%24"];
                break;
            case ',':
                ret = [ret stringByAppendingString:@"%2C"];
                break;
            case '[':
                ret = [ret stringByAppendingString:@"%5B"];
                break;
            case ']':
                ret = [ret stringByAppendingString:@"%5D"];
                break;
            case '#':
                ret = [ret stringByAppendingString:@"%23"];
                break;
            case '!':
                ret = [ret stringByAppendingString:@"%21"];
                break;
            case '(':
                ret = [ret stringByAppendingString:@"%28"];
                break;
            case ')':
                ret = [ret stringByAppendingString:@"%29"];
                break;
            case '*':
                ret = [ret stringByAppendingString:@"%2A"];
                break;
            default:
                ret = [ret stringByAppendingFormat:@"%c", *c];
        }
        c++;
    }
    
    return ret;
}

- (NSUInteger)numberOfOcurrenceOfSubString: (NSString*)subString
{
    if (!subString) {
        return 0;
    }
    
    return [[self mutableCopy] replaceOccurrencesOfString:subString withString:@"" options:NSLiteralSearch range:NSMakeRange(0, self.length)];
}

- (NSInteger)numberOfLines
{
    return [self numberOfOcurrenceOfSubString:@"\n"] + 1;
}

+ (BOOL)isString: (NSString*)string equalToAnotherString: (NSString*)anotherString
{
    if (string) {
        return [anotherString isEqualToString:string];
    } else {
        return string == anotherString;
    }
}

- (NSString *)appendLineWrap:(NSUInteger)lineWrapCount
{
    NSMutableString *lineWraps = [[NSMutableString alloc] init];
    
    for (NSUInteger i = 0; i < lineWrapCount; i++)
    {
        [lineWraps appendString:JMLineBreakString];
    }
    
    return [self stringByAppendingString:lineWraps];
}

- (NSString *)domainFieldUrlString
{
    NSString *domainFieldString = nil;
    
    if (NSNotFound != [self rangeOfString:@"?"].location) {
        domainFieldString = [self substringToIndex:[self rangeOfString:@"?"].location];
    } else {
        domainFieldString = self;
    }
    return domainFieldString;
}

- (NSString*)maskedMobileNumber
{
    static NSString* const MobileMask = @"****";
    static NSInteger const NumberOfCharsToEndToReplace = 4;
    
    NSString* mobile = self;
    
    if (!JMIsEmptyString(mobile) && mobile.length > (MobileMask.length + NumberOfCharsToEndToReplace)) {
        NSUInteger replaceStart = 0;
        NSUInteger replaceLen = MobileMask.length;
        if (mobile.length >= (NumberOfCharsToEndToReplace + replaceLen)) {
            replaceStart = mobile.length - (NumberOfCharsToEndToReplace + replaceLen);
        } else {
            replaceStart = 0;
            replaceLen = MIN(replaceLen, mobile.length);
        }
        
        mobile = [mobile stringByReplacingCharactersInRange:NSMakeRange(replaceStart, replaceLen) withString:MobileMask];
    }
    
    return mobile;
}

+ (BOOL)isNullEmptyOrEmptyUUIDString: (NSString*)string
{
    return JMIsEmptyString(string) || [string isEqualToString:JMEmptyUUIDString];
}

+ (NSString*)queryStringByAppendingArrayURLQueryValue: (NSArray*)array withKey: (NSString*)key
{
    static NSString* const KV_PAIR_CONNECTOR = @"&";
    
    NSMutableString* query = [[NSMutableString alloc] init];
    for (id value in array) {
        NSString* stringValue = nil;
        if ([value isKindOfClass:[NSString class]]) {
            stringValue = value;
        } else if ([value respondsToSelector:@selector(stringValue)]) {
            stringValue = [value stringValue];
        } else if ([value respondsToSelector:@selector(description)]) {
            stringValue = [value description];
        } else {
            // Do nothing
        }
        
        if (!stringValue) {
            continue;
        }
        
        if (query.length > 0) {
            [query appendString:KV_PAIR_CONNECTOR];
        }
        
        [query appendFormat:@"%@=%@", [key urlencode], [stringValue urlencode]];
    }
    return query;
}

- (NSString*)stringByAppendingArrayURLQueryValue: (NSArray*)array withKey: (NSString*)key
{
    static NSString* const KV_PAIR_CONNECTOR = @"&";
    static NSString* const QUERY_BEGIN = @"?";
    
    NSString* string = self;
    if (!array || array.count == 0) {
        return string;
    }
    
    NSString *queryString = [NSString queryStringByAppendingArrayURLQueryValue:array withKey:key];
    NSMutableString *query  =[[NSMutableString alloc]initWithString:queryString];;
    if ([string containsString:QUERY_BEGIN]) {
        if (![string hasSuffix:QUERY_BEGIN] && ![string hasSuffix:KV_PAIR_CONNECTOR]) {
            [query insertString:KV_PAIR_CONNECTOR atIndex:0];
            
        }
    } else {
        [query insertString:QUERY_BEGIN atIndex:0];
    }
    
    string = [string stringByAppendingString:query];
    return string;
}

- (NSString*)stringByRemovingSpaces
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString*)stringByRepeating: (NSInteger)times
{
    if (times <= 1) {
        return self;
    }
    
    NSString* string = @"";
    while (times > 0) {
        times--;
        string = [string stringByAppendingString:self];
    }
    
    return string;
}

- (BOOL)hasHttpPrefix
{
    NSString* string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    string = [string lowercaseString];
    NSURL* url = [NSURL URLWithString:string];
    return [url isHttpURL];
}

+ (NSString*)stringForPathOfApplicationSupportFolder
{
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

- (NSData*)dataWithMD5Hash
{
    NSString* hash = [self md5HexDigest];
    return [hash dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString*)hashSHA256
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (uint)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (double)doubleValuePrecised
{
    NSDecimalNumber* decimalNumber = [NSDecimalNumber decimalNumberWithString:self];
    return [decimalNumber doubleValue];
}


- (BOOL)isValidPhoneNumber {
    static NSInteger const PHONE_NUMBER_LEN = 11;
    
    if (JMIsEmptyString(self)) {
        return NO;
    }
    
    NSString* trimed = [self stringByRemovingSpaces];
    if (trimed.length != PHONE_NUMBER_LEN) {
        return NO;
    }
    
    return YES;
}

- (NSInteger)integerValueByParseAsDecimalString
{
    if (JMIsEmptyString(self)) {
        return 0;
    }
    NSDecimalNumber *numberValue = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *multiplyingBy = [NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber *integerNumber = [numberValue decimalNumberByMultiplyingBy:multiplyingBy];
    return integerNumber.integerValue;
}

- (NSString*)stringByRemovingPhoneNumberSpecialChars
{
    static NSString* const NUMBERS = @"0123456789";
    static NSString* const COUNTRY_CODE = @"86";
    
    NSMutableString* phone = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < self.length; i++) {
        NSString* str = [self substringWithRange:NSMakeRange(i, 1)];
        if ([NUMBERS containsString:str]) {
            [phone appendString:str];
        }
    }
    
    if ([phone hasPrefix:COUNTRY_CODE]) {
        [phone deleteCharactersInRange:NSMakeRange(0, COUNTRY_CODE.length)];
    }
    
    return [phone copy];
}

- (NSString*)removeSubfixAllZeroDigits
{
    static NSString *const DECIMAL_POINT = @".";
    if (![self containsString:DECIMAL_POINT]) {
        return self;
    }
    NSString *text = self;
    NSRange range = [text rangeOfString:DECIMAL_POINT];
    NSString *zeroDigits = DECIMAL_POINT;
    for (int i = 0; i < text.length - 1 - range.location; i++) {
        zeroDigits = [zeroDigits stringByAppendingString:@"0"];
        if ([text hasSuffix:zeroDigits]) {
            NSRange range = [text rangeOfString:zeroDigits];
            text = [text substringToIndex:range.location];
            break;
        }
    }
    return text;
}

- (NSRange)rangeOfStringByTrimmingCharactersNotInSet: (NSCharacterSet*)charset
{
    NSInteger startIndex = 0;
    NSInteger endIndex = self.length - 1;
    
    while (startIndex < self.length) {
        unichar ch = [self characterAtIndex:startIndex];
        if ([charset characterIsMember:ch]) {
            break;
        }
        
        startIndex++;
    }
    
    while (endIndex >= 0) {
        unichar ch = [self characterAtIndex:endIndex];
        if ([charset characterIsMember:ch]) {
            break;
        }
        
        endIndex--;
    }
    
    if (startIndex > endIndex) {
        return NSMakeRange(NSNotFound, 0);
    }
    
    NSInteger len = endIndex - startIndex + 1;
    NSRange range = NSMakeRange(startIndex, len);
    return range;
}

- (NSString*)stringByTrimmingCharactersNotInSet: (NSCharacterSet*)charset
{
    NSRange range = [self rangeOfStringByTrimmingCharactersNotInSet:charset];
    if (range.location == NSNotFound) {
        return JMEmptyString;
    }
    
    return [self substringWithRange:range];
}

- (CGSize)sizeWithFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}

@end

//
//  NSURL+JMBase.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "NSURL+JMBase.h"
#import "JMMacro.h"
#import "NSString+JMBase.h"
#import "NSDictionary+JMBase.h"

@implementation NSURL (JMBase)

- (NSURL *)URLByAddParams:(NSDictionary*)params
{
    if (!params || params.count == 0) {
        return self;
    }
    
    NSMutableDictionary* existingParams = [[self params] mutableCopy];
    [existingParams addEntriesFromDictionary:params];
    params = [existingParams copy];
    
    NSString *query = [params queryStringByEntryKeyAscOrder];
    NSString* urlWithoutQuery = [self urlStringWithoutQuery];
    NSString* urlString = [NSString stringWithFormat:@"%@?%@", urlWithoutQuery, query];
    return [NSURL URLWithString:urlString];
}

- (NSDictionary *)params
{
    NSMutableDictionary* pairs = [[NSMutableDictionary alloc] init];
    if (NSNotFound != [self.absoluteString rangeOfString:@"?"].location) {
        NSString *paramString = [self.absoluteString substringFromIndex:
                                 ([self.absoluteString rangeOfString:@"?"].location + 1)];
        NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
        NSScanner* scanner = [[NSScanner alloc] initWithString:paramString];
        while (![scanner isAtEnd]) {
            NSString* pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
            if (kvPair.count == 2) {
                NSString* key = [[kvPair objectAtIndex:0] urldecode];
                NSString* value = [[kvPair objectAtIndex:1] urldecode];
                [pairs setValue:value forKey:key];
            }
        }
    }
    
    return [pairs copy];
}

- (NSString*)urlStringWithoutQuery
{
    NSString* query = [self query];
    NSString* absolue = [self absoluteString];
    NSString* urlWithoutQuery = absolue;
    if (absolue && absolue.length > query.length && query && query.length > 0) {
        urlWithoutQuery = [absolue substringToIndex: (absolue.length - (query.length + 1))];
    }
    return urlWithoutQuery;
}

- (BOOL)isHttpURL
{
    return [self.scheme isEqualToString:JMSchemeHttp] || [self.scheme isEqualToString:JMSchemeHttps];
}

- (BOOL)isNoneHttpURL
{
    return ![self isNoneHttpURL];
}

- (NSURL*)urlByRemovingParamWithKey: (NSString*)key
{
    static NSString* const VALUE_CONNECTOR = @"=";
    static NSString* const PARAM_CONNECTOR = @"&";
    if (!key) {
        return self;
    }
    
    NSString* urlString = [self absoluteString];
    NSString* paramsPrefix = [key stringByAppendingString:VALUE_CONNECTOR];
    NSRange range = [urlString rangeOfString:paramsPrefix];
    while (range.location != NSNotFound) {
        if (range.location > PARAM_CONNECTOR.length) {
            NSRange rangeOfParamConnector = NSMakeRange(range.location - PARAM_CONNECTOR.length, PARAM_CONNECTOR.length);
            NSString* strInRange = [urlString substringWithRange:rangeOfParamConnector];
            if ([strInRange isEqualToString:PARAM_CONNECTOR]) {
                range.location -= PARAM_CONNECTOR.length;
            }
            
            NSInteger lastCharIndexOfRange = range.location + range.length;
            NSRange rangeOfNextConnector = [urlString rangeOfString:PARAM_CONNECTOR options:(NSLiteralSearch) range:NSMakeRange(lastCharIndexOfRange, urlString.length - lastCharIndexOfRange)];
            if (rangeOfNextConnector.location != NSNotFound) {
                range.length = rangeOfNextConnector.location - range.location;
            } else {
                range.length = urlString.length - range.location;
            }
        }
        
        urlString = [urlString stringByReplacingCharactersInRange:range withString:JMEmptyString];
        
        range = [urlString rangeOfString:paramsPrefix];
    }
    
    return [NSURL URLWithString:urlString];
}

- (BOOL)isEqualToURLWithoutQuery: (NSURL*)url
{
    if ([NSString isString:url.host equalToAnotherString:self.host]) {
        NSCharacterSet* separatorSet = [NSCharacterSet characterSetWithCharactersInString:@"/"];
        NSString* path = [url.path stringByTrimmingCharactersInSet:separatorSet];
        NSString* currentPath = [self.path stringByTrimmingCharactersInSet:separatorSet];
        return [NSString isString:path equalToAnotherString:currentPath];
    }
    
    return NO;
}

@end

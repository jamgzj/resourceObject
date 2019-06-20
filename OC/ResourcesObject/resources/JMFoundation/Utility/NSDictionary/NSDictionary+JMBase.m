//
//  NSDictionary+JMBase.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "NSDictionary+JMBase.h"
#import "NSString+JMBase.h"

@implementation NSDictionary (JMBase)

- (NSString*)queryStringByEntryKeyAscOrder
{
    NSDictionary *params = [self copy];
    
    NSMutableString *query = [[NSMutableString alloc] init];
    for (NSString* key in [params allKeys]) {
        id value = [params objectForKey:key];
        if (!value || [value isKindOfClass:[NSNull class]]) {
            continue;
        }
        
        NSString* stringValue = nil;
        
        if ([value isKindOfClass:[NSArray class]]) {
            stringValue = [NSString queryStringByAppendingArrayURLQueryValue:value withKey:key];
        }else if ([value isKindOfClass:[NSString class]]) {
            stringValue = value;
        } else if ([value respondsToSelector:@selector(stringValue)]) {
            stringValue = [value stringValue];
        } else if ([value respondsToSelector:@selector(description)]) {
            stringValue = [value description];
        } else {
            // Do nothing
        }
        
        if (!stringValue || [stringValue length] <= 0) {
            continue;
        }
        
        if (query.length > 0) {
            [query appendString:@"&"];
        }
        
        if ([value isKindOfClass:[NSArray class]]) {
            [query appendString:stringValue];
        } else {
            stringValue = [stringValue urlencode];
            [query appendFormat:@"%@=%@", key, stringValue];
        }
    }
    return query;
}

+ (NSDictionary *)attributesWithColor:(UIColor *)color font:(UIFont *)font
{
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    
    if (color != nil) {
        [attributes setObject:color forKey:NSForegroundColorAttributeName];
    }
    
    if (font != nil) {
        [attributes setObject:font forKey:NSFontAttributeName];
    }
    
    return attributes;
}

@end

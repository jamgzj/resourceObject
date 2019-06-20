//
//  NSDictionary+JMGetValueUtil.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "NSDictionary+JMGetValueUtil.h"

@implementation NSDictionary (JMGetValueUtil)

- (BOOL)boolValueForKey: (NSString*)key
{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(boolValue)]) {
        return [object boolValue];
    }
    return NO;
}

- (NSInteger)integerValueForKey: (NSString*)key
{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(integerValue)]) {
        return [object integerValue];
    }
    return 0;
}

- (NSString*)stringValueForKey: (NSString*)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    } else if ([object respondsToSelector:@selector(stringValue)]) {
        return [object stringValue];
    } else {
        // Do nothing
    }
    return nil;
}

- (float)floatValueForKey: (NSString*)key
{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(floatValue)]) {
        return [object floatValue];
    }
    return 0;
}

- (double)doubleValueForKey: (NSString*)key
{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(doubleValue)]) {
        return [object doubleValue];
    }
    return 0;
}

- (NSDictionary*)dictionaryValueForKey: (NSString*)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSDictionary class]]) {
        return object;
    }
    return nil;
}

- (NSNumber*)numberValueForKey: (NSString*)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return object;
    }
    
    return nil;
}

- (NSNumber*)integerNumberValueForKey:(NSString *)key {
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return object;
    } else if ([object isKindOfClass:[NSString class]]) {
        NSInteger value = [(NSString*)object integerValue];
        return [NSNumber numberWithInteger:value];
    }
    return nil;
}

- (NSNumber*)doubleNumberValueForKey:(NSString *)key {
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return object;
    } else if ([object isKindOfClass:[NSString class]]) {
        double value = [(NSString*)object doubleValue];
        return [NSNumber numberWithDouble:value];
    }
    return nil;
}

- (NSArray*)arrayValueForKey: (NSString*)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSArray class]]) {
        return object;
    }
    
    return nil;
}

@end

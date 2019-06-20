//
//  DMInfoPlistHelper.m
//  dmlib
//
//  Created by Terry Tan on 06/03/2017.
//  Copyright © 2017 Shanghai DataSeed Information Technology Co.,Ltd. All rights reserved.
//

#import "JMInfoPlistHelper.h"
#import "NSDictionary+JMGetValueUtil.h"
#import "JMMacro.h"

@implementation JMInfoPlistHelper

+ (id)objectForKey: (NSString*)key
{
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    id value = [infoDictionary objectForKey:key];
    if ([value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    return value;
}

+ (BOOL)boolValueForKey: (NSString*)key
{
    id obj = [self objectForKey:key];
    if ([obj respondsToSelector:@selector(boolValue)]) {
        return [obj boolValue];
    }
    
    return NO;
}

+ (NSArray<NSString*>*)schemeArrayByURLIdentifier: (NSString*)identifier
{
    if (JMIsEmptyString(identifier)) {
        return @[];
    }
    
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSArray<NSDictionary*>* urlTypes = [infoDictionary arrayValueForKey:@"CFBundleURLTypes"];
    for (NSDictionary* urlTypeDic in urlTypes) {
        NSString* schemeName = [urlTypeDic stringValueForKey:@"CFBundleURLName"];
        if ([schemeName isEqualToString:identifier]) {
            return [urlTypeDic arrayValueForKey:@"CFBundleURLSchemes"];
        }
    }
    
    return @[];
}

+ (NSString*)schemeByURLIdentifier: (NSString*)identifier
{
    return [[self schemeArrayByURLIdentifier:identifier] firstObject];
}

+ (NSArray<NSString*>*)defaultSchemeArray
{
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSDictionary* defaultSchemeDic = [[infoDictionary arrayValueForKey:@"CFBundleURLTypes"] firstObject];
    NSArray* schemes = [defaultSchemeDic arrayValueForKey:@"CFBundleURLSchemes"];
    return schemes ?: @[];
}

@end

//
//  NSBundle+JMExtension.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/4.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "NSBundle+JMExtension.h"
#import "NSArray+JSON.h"
#import "NSDictionary+JSON.h"

@implementation NSBundle (JMExtension)

- (NSString*)jm_contentOfFileWithName: (NSString*)name extension: (NSString*)ext
{
    NSURL* url = [self URLForResource:name withExtension:ext];
    if (url) {
        return [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    }
    return nil;
}

- (NSDictionary*)jm_dictionaryFromJSONFileWithName: (NSString*)name
{
    NSString* string = [self jm_contentOfFileWithName:name extension:@"json"];
    return [NSDictionary dictionaryWithJSONString:string];
}

- (NSArray*)jm_arrayFromJSONFileWithName: (NSString*)name
{
    NSString* string = [self jm_contentOfFileWithName:name extension:@"json"];
    return [NSArray arrayWithJSONString:string];
}

@end

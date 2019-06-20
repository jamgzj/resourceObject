//
//  NSDictionary+JSON.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "NSDictionary+JSON.h"
#import <Foundation/Foundation.h>
#import "JMMacro.h"

@implementation NSDictionary (JSON)

- (NSString*)toJSONString
{
    NSError* error = nil;
    NSData* data = [NSJSONSerialization dataWithJSONObject:self options:(NSJSONWritingOptions)0 error:&error];
    if (!error && data) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (NSDictionary*)dictionaryWithJSONString: (NSString*)JSONString
{
    if (JMIsEmptyString(JSONString)) {
        return nil;
    }
    
    NSError* error = nil;
    NSData* data = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return nil;
    }
    
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        return nil;
    }
    return object;
}

@end

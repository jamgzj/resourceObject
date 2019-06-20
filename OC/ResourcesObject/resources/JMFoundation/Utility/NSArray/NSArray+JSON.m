//
//  NSArray+JSON.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/30.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "NSArray+JSON.h"
#import "JMMacro.h"

@implementation NSArray (JSON)

- (NSString*)toJSONString
{
    NSError* error = nil;
    NSData* data = [NSJSONSerialization dataWithJSONObject:self options:(NSJSONWritingOptions)0 error:&error];
    if (!error && data) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (NSArray*)arrayWithJSONString: (NSString*)JSONString
{
    if (JMIsEmptyString(JSONString)) {
        return nil;
    }
    
    NSError* error = nil;
    NSData* data = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error || ![object isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return object;
}

@end

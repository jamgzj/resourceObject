//
//  NSMutableDictionary+JMCrash.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/21.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "NSMutableDictionary+JMCrash.h"
#import "NSObject+JMSwizzle.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (JMCrash)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self jm_trySwizzleMethod:@selector(setObject:forKey:) withMethod:@selector(jm_setObject:forKey:) inClass:objc_getClass("__NSDictionaryM")];
    });
}

- (void)jm_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    NSAssert(anObject, @"%s: object is nil",__FUNCTION__);
    NSAssert(aKey, @"%s: key is nil",__FUNCTION__);
    if (anObject && aKey) {
        [self jm_setObject:anObject forKey:aKey];
    }
}

@end

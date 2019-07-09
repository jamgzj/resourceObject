//
//  NSMutableSet+JMCrash.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/21.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "NSMutableSet+JMCrash.h"
#import "NSObject+JMSwizzle.h"
#import <objc/runtime.h>

@implementation NSMutableSet (JMCrash)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self jm_trySwizzleMethod:@selector(addObject:) withMethod:@selector(jm_addObject:) inClass:objc_getClass("__NSSetM")];
    });
}

- (void)jm_addObject:(id)anObject
{
    NSAssert(anObject, @"%s: object is nil",__FUNCTION__);
    if (anObject) {
        [self jm_addObject:anObject];
    }
}

@end

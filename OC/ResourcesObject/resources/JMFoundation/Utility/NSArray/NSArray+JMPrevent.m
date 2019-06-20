//
//  NSArray+JMBase.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/20.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "NSArray+JMPrevent.h"
#import "NSObject+JMSwizzle.h"

@implementation NSArray (JMPrevent)

+ (void)load
{
    [self jm_trySwizzleMethod:@selector(objectAtIndex:) withMethod:@selector(jm_ObjectAtIndex:)];
    [self jm_trySwizzleMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(jm_ObjectAtIndexedSubscript:)];
    [self jm_trySwizzleMethod:@selector(indexOfObject:) withMethod:@selector(jm_IndexOfObject:)];
}

- (id)jm_ObjectAtIndex:(NSInteger)index
{
    if (index < [self count]) {
        return [self jm_ObjectAtIndex:index];
    }
    NSAssert(0, @"%s:index %ld beyond bounds for NSArray count %ld",__FUNCTION__,(long)index,self.count);
    return nil;
}

- (id)jm_ObjectAtIndexedSubscript:(NSInteger)index
{
    if (index < [self count]) {
        return [self jm_ObjectAtIndexedSubscript:index];
    }
    NSAssert(0, @"%s:index %ld beyond bounds for NSArray count %ld",__FUNCTION__,(long)index,self.count);
    return nil;
}

- (NSUInteger)jm_IndexOfObject:(id)anObject
{
    if (anObject) {
        return [self jm_IndexOfObject:anObject];
    }
    NSAssert(0, @"%s:object is nil",__FUNCTION__);
    return NSNotFound;
}

@end

@implementation NSMutableArray (JMPrevent)

+ (void)load
{
    [self jm_trySwizzleMethod:@selector(addObject:) withMethod:@selector(jm_AddObject:)];
    [self jm_trySwizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(jm_InsertObject:atIndex:)];
    [self jm_trySwizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(jm_removeObjectAtIndex:)];
}

- (void)jm_AddObject:(id)anObject
{
    if (anObject) {
        [self jm_AddObject:anObject];
        return;
    }
    NSAssert(0,@"%s:object is nil", __FUNCTION__);
}

- (void)jm_InsertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject) {
        [self jm_InsertObject:anObject atIndex:index];
        return;
    }
    NSAssert(0, @"%s:object is nil", __FUNCTION__);
}

- (void)jm_removeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        [self jm_removeObjectAtIndex:index];
        return;
    }
    NSAssert(0, @"%s:index %ld beyond bounds for NSArray count %ld",__FUNCTION__,(long)index,self.count);
}

@end

//
//  JMWeakRefArray.m
//  JMlib
//
//  Created by Terry Tan on 8/12/16.
//  Copyright © 2016 Shanghai DataSeed Information Technology Co.,Ltd. All rights reserved.
//

#import "JMWeakRefArray.h"
#import "JMWeakRefObject.h"

@interface JMWeakRefArray ()

@property (strong, nonatomic) NSMutableArray* array;

@end

@implementation JMWeakRefArray

- (instancetype)init
{
    self = [super init];
    self.array = [[NSMutableArray alloc] init];
    return self;
}

- (void)addWeafRefObject: (id)object
{
    id value = [JMWeakRefObject weakRefWithObject:object];
    [_array addObject:value];
}

- (NSArray*)retainedObjects
{
    NSMutableArray* retainedObject = [[NSMutableArray alloc] init];
    for (JMWeakRefObject* value in [_array copy]) {
        id object = value.object;
        if (object) {
            [retainedObject addObject:object];
        } else {
            [_array removeObject:value];
        }
    }
    
    return retainedObject;
}

- (id)lastReferredObject
{
    JMWeakRefObject* lastObject = _array.lastObject;
    return lastObject.object;
}

- (id)popLastObject
{
    JMWeakRefObject* lastObject = _array.lastObject;
    [_array removeLastObject];
    return lastObject.object;
}

@end

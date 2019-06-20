//
//  JMWeakReafObject.m
//  JMlib
//
//  Created by Terry Tan on 31/05/2017.
//  Copyright © 2017 Shanghai DataSeed Information Technology Co.,Ltd. All rights reserved.
//

#import "JMWeakRefObject.h"

@implementation JMWeakRefObject

+ (instancetype)weakRefWithObject: (id)object
{
    JMWeakRefObject* refObject = [[JMWeakRefObject alloc] init];
    refObject.object = object;
    return refObject;
}

@end

//
//  NSObject+LBASwizzle.m
//  LBAnalyticsKit
//
//  Created by Terry Tan on 5/9/16.
//  Copyright © 2016 caijiajia. All rights reserved.
//

#import "NSObject+JMSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (JMSwizzle)

+ (BOOL)jm_trySwizzleMethod: (SEL)originSel withMethod: (SEL)alterSel
{
    return [self jm_trySwizzleMethod:originSel withMethod:alterSel inClass:self];
}

+ (BOOL)jm_trySwizzleClassMethod: (SEL)originSel withMethod: (SEL)alterSel
{
    if (!originSel) {
        NSLog(@"originSel is empty");
        return NO;
    }
    
    if (!alterSel) {
        NSLog(@"alterSel is empty");
        return NO;
    }
    
    Class class = self;
    Method alterMethod = class_getClassMethod(class, alterSel);
    if (!alterMethod) {
        NSLog(@"cannot find alternative method impl by alterSel: %@", NSStringFromSelector(alterSel));
        return NO;
    }
    
    Method originMethod = class_getClassMethod(class, originSel);
    if (!originMethod) {
        NSLog(@"cannot find original method impl by originSel: %@", NSStringFromSelector(originSel));
        return NO;
    }
    
    method_exchangeImplementations(originMethod, alterMethod);
    return YES;
}

+ (BOOL)jm_trySwizzleMethod: (SEL)originSel withMethod: (SEL)alterSel inClass: (Class)class
{
    if (!originSel) {
        NSLog(@"originSel is empty");
        return NO;
    }
    
    Method alterMethod = class_getInstanceMethod(class, alterSel);
    if (!alterMethod) {
        NSLog(@"cannot find alternative method impl by alterSel: %@", NSStringFromSelector(alterSel));
        return NO;
    }
    
    Method originMethod = class_getInstanceMethod(class, originSel);
    if (!originMethod) {
        NSLog(@"cannot find original method impl by originSel: %@", NSStringFromSelector(originSel));
    }
    
    method_exchangeImplementations(originMethod, alterMethod);
    return YES;
}

@end

//
//  NSObject+JMCrash.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/21.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "NSObject+JMCrash.h"
#import <objc/runtime.h>
#import "NSObject+JMSwizzle.h"

@implementation NSObject (JMCrash)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self jm_trySwizzleMethod:@selector(forwardingTargetForSelector:) withMethod:@selector(jm_forwardingTargetForSelector:)];
    });
}

- (id)jm_forwardingTargetForSelector:(SEL)aSelector {
    
    // 获取NSObject的消息转发方法
    SEL sel = NSSelectorFromString(@"forwardingTargetForSelector:");
    Method method = class_getInstanceMethod(NSClassFromString(@"NSObject"), sel);
    // 获取当前类的消息转发方法
    Method _m = class_getInstanceMethod([self class],sel);
    
    // 类本身有没有实现消息转发流程
    BOOL transmit = method_getImplementation(_m) == method_getImplementation(method);
    
    /// 有木有实现下一步消息转发流程
    if (transmit) {
        /// 判断有没有实现第三步消息转发
        SEL sel1 = NSSelectorFromString(@"methodSignatureForSelector:");
        Method method1 = class_getInstanceMethod(NSClassFromString(@"NSObject"), sel1);
        
        Method _m1 = class_getInstanceMethod([self class], sel1);
        transmit = method_getImplementation(_m1) == method_getImplementation(method1);
        
        NSAssert(!transmit, @"%s:unrecognized selector sent to instance",sel_getName(aSelector));
        
        if (transmit) {
            // 创建一个新类
            NSString *errClassName = NSStringFromClass([self class]);
            NSString *errSel   = NSStringFromSelector(aSelector);
            NSLog(@"出问题的类，出问题的方法 == %@ %@", errClassName, errSel);
            
            NSString *className = @"JMCrachClass";
            Class cls = NSClassFromString(className);
            /// 如果类不存在 动态创建一个类
            if (!cls) {
                Class superCls = [NSObject class];
                cls = objc_allocateClassPair(superCls, className.UTF8String, 0);
                /// 给类添加方法
                class_addMethod(cls, aSelector, (IMP)Crash, "@@:@");
                objc_registerClassPair(cls);
            }
            /// 如果类没有对应的方法，则动态添加一个
            if (!class_getInstanceMethod(NSClassFromString(className), aSelector)) {
                class_addMethod(cls, aSelector, (IMP)Crash, "@@:@");
            }
            /// 把消息转发到当前动态生成类的实例上
            return [[NSClassFromString(className) alloc] init];
        }
    }
    return [self jm_forwardingTargetForSelector:aSelector];
}

static int Crash(id slf, SEL selector) {
    return 0;
}

@end

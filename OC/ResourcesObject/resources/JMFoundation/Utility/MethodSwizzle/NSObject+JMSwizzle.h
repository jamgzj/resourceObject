//
//  NSObject+JMSwizzle.h
//  LBAnalyticsKit
//
//  Created by Terry Tan on 5/9/16.
//  Copyright © 2016 caijiajia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JMSwizzle)

+ (BOOL)jm_trySwizzleMethod: (SEL)originSel withMethod: (SEL)alterSel;
+ (BOOL)jm_trySwizzleClassMethod: (SEL)originSel withMethod: (SEL)alterSel;

@end

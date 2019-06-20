//
//  NSDictionary+JMGetValueUtil.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JMGetValueUtil)

- (BOOL)boolValueForKey: (NSString*)key;
- (NSInteger)integerValueForKey: (NSString*)key;
- (NSString*)stringValueForKey: (NSString*)key;
- (float)floatValueForKey: (NSString*)key;
- (double)doubleValueForKey: (NSString*)key;
- (NSNumber*)numberValueForKey: (NSString*)key;
- (NSNumber*)integerNumberValueForKey: (NSString*)key;
- (NSNumber*)doubleNumberValueForKey: (NSString*)key;
- (NSDictionary*)dictionaryValueForKey: (NSString*)key;
- (NSArray*)arrayValueForKey: (NSString*)key;

@end

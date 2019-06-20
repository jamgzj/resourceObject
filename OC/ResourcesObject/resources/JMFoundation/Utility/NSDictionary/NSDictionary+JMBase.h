//
//  NSDictionary+JMBase.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (JMBase)

- (NSString*)queryStringByEntryKeyAscOrder;

+ (NSDictionary *)attributesWithColor:(UIColor *)color font:(UIFont *)font;

@end

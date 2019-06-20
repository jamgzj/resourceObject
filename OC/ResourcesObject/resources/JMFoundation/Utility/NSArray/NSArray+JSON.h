//
//  NSArray+JSON.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/30.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JSON)

- (NSString*)toJSONString;

+ (NSArray*)arrayWithJSONString: (NSString*)JSONString;

@end

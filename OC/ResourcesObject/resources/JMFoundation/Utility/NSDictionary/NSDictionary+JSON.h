//
//  NSDictionary+JSON.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)

- (NSString*)toJSONString;
+ (NSDictionary*)dictionaryWithJSONString: (NSString*)JSONString;

@end

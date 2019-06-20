//
//  NSURL+JMBase.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (JMBase)

- (NSURL *)URLByAddParams:(NSDictionary*)params;
- (NSString*)urlStringWithoutQuery;
- (NSDictionary *)params;
- (BOOL)isHttpURL;
- (BOOL)isNoneHttpURL;
- (NSURL*)urlByRemovingParamWithKey: (NSString*)key;
- (BOOL)isEqualToURLWithoutQuery: (NSURL*)url;

@end

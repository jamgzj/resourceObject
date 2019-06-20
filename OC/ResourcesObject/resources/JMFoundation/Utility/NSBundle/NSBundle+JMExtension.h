//
//  NSBundle+JMExtension.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/4.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (JMExtension)

- (NSString*)jm_contentOfFileWithName: (NSString*)name extension: (NSString*)ext;
- (NSDictionary*)jm_dictionaryFromJSONFileWithName: (NSString*)name;
- (NSArray*)jm_arrayFromJSONFileWithName: (NSString*)name;

@end

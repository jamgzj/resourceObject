//
//  JMResourceManager.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/30.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JMResourceManager : NSObject

+ (UIStoryboard*)storyboardWithName:(NSString *)storyboardName;

+ (UINib*)bundleNibNamed: (NSString*)name;

+ (NSString*)fileContentWithName:(NSString *)name extension:(NSString *)extension;

+ (NSDictionary*)dictionaryWithJSONFileOfName: (NSString*)fileName;
+ (NSArray*)arrayWithJSONFileOfName: (NSString*)fileName;

+ (id)instantiateViewFromNibWithClass: (Class)viewClass;

+ (id)instantiateViewFromNibWithName: (NSString*)viewName;

@end

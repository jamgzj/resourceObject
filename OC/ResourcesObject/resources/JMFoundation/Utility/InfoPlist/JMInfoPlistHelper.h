//
//  DMInfoPlistHelper.h
//  dmlib
//
//  Created by Terry Tan on 06/03/2017.
//  Copyright © 2017 Shanghai DataSeed Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMInfoPlistHelper : NSObject

+ (BOOL)boolValueForKey: (NSString*)key;
+ (id)objectForKey: (NSString*)key;
+ (NSArray<NSString*>*)schemeArrayByURLIdentifier: (NSString*)identifier;
+ (NSString*)schemeByURLIdentifier: (NSString*)identifier;
+ (NSArray<NSString*>*)defaultSchemeArray;

@end

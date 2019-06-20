//
//  JMMacro.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+JMBase.h"

#pragma mark - Macros
#define JM_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define JM_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define JM_SCREEN_MAX_LENGTH (MAX(JM_SCREEN_WIDTH, JM_SCREEN_HEIGHT))
#define JM_SCREEN_MIN_LENGTH (MIN(JM_SCREEN_WIDTH, JM_SCREEN_HEIGHT))
#define JM_SCREEN_SCALE [UIScreen mainScreen].scale
#define JM_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define JM_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define JM_SCREEN_MAX_LENGTH (MAX(JM_SCREEN_WIDTH, JM_SCREEN_HEIGHT))
#define JM_SCREEN_MIN_LENGTH (MIN(JM_SCREEN_WIDTH, JM_SCREEN_HEIGHT))
#define JM_SCREEN_SCALE [UIScreen mainScreen].scale
#define JM_SEPARATOR_DIMENSION (JM_SCREEN_SCALE < 3.0 ? 0.5 : 0.5)
#define JM_IS_IPHONE_4_OR_LESS (JM_SCREEN_MAX_LENGTH < 568.0)
#define JM_IS_IPHONE_5 (JM_SCREEN_MAX_LENGTH == 568.0)
#define JM_IS_IPHONE_6 (JM_SCREEN_MAX_LENGTH == 667.0)
#define JM_IS_IPHONE_6P (JM_SCREEN_MAX_LENGTH > 667.0)
#define JM_IS_IPHONE_5_OR_LESS (JM_SCREEN_MAX_LENGTH <= 568.0)
#define JM_IS_IPHONE_X (JM_SCREEN_MAX_LENGTH == 812.0)
#define JM_IS_IPHONE_X_OR_LATER (JM_SCREEN_MAX_LENGTH >= 812.0)
#define JM_IS_IOS_10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define JM_IS_IOS_9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define JM_IS_IOS_11_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

#pragma mark - Constants
extern NSString* const JMSchemeHttp;
extern NSString* const JMSchemeHttps;

extern NSString* const JMEmptyString;
extern NSString* const JMEmptyUUIDString;
extern NSString* const JMLineBreakString;

extern NSString* const JMPathSeparator;

#pragma mark - Blocks
typedef void(^JMAction)(void);
typedef BOOL(^JMPredicate)(void);

#pragma mark - Functions
extern BOOL JMIsEmptyString(NSString* string);
extern UIColor* JMColorHex(NSString* colorHex);
extern CGRect JMRectSetOriginX(CGRect rect, CGFloat originX);
extern void JMDispatchSyncOnMainQueue(void (^block)(void));



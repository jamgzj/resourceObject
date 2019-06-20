//
//  NSString+DisplayFormat.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DisplayFormat)

//去掉字符间的空格
- (NSString *)removeSpace;
//手机号格式化
- (NSString *)phoneNumberRegularization;
- (NSString *)phoneNumberRegularizationWithMask;
//银行卡号格式化
- (NSString *)bankCardNumberRegularization;
//身份证
- (NSString*)identificationRegularization;
- (NSString*)identificationRegularizationWithMask;

// 如果字符串按照3,4,4d格式分割，则传入@[@3, @4, @4]
- (NSString*)stringRegularizationByGroupCounts: (NSArray<NSNumber*>*)groupCounts;
- (NSString*)stringRegularizationByGroupCounts: (NSArray<NSNumber*>*)groupCounts
                               needToTrimSpace: (BOOL)needToTrimSpace;

/*************--------- 时间处理 ---------************/
//转换时间格式
- (NSString *)dateRegularization;

//format 00:00:00
+ (NSString *)remainTime:(NSTimeInterval)timeInterval;
+ (NSString *)remainTime:(NSTimeInterval)timeInterval showHour:(BOOL)showHour;

@end

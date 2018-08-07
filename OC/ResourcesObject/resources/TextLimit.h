//
//  TextLimit.h
//  TextInputLimit
//
//  Created by wangguoliang on 15/12/15.
//  Copyright © 2015年 wangguoliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITextField (limit)

@end

@interface UITextView (limit)

@end

@interface TextLimit : NSObject

+ (TextLimit *)sharedTextLimit;

@end

//
//  JMMacro.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/29.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "JMMacro.h"

#pragma mark - Constants
NSString* const JMSchemeHttp = @"http";
NSString* const JMSchemeHttps = @"https";

NSString* const JMEmptyString = @"";
NSString* const JMEmptyUUIDString = @"00000000-0000-0000-0000-000000000000";
NSString* const JMLineBreakString = @"\n";

NSString* const JMPathSeparator = @"/";

#pragma mark - Functions
BOOL JMIsEmptyString(NSString* string)
{
    return [NSString jm_isStringNullOrEmpty:string];
}

UIColor* JMColorHex(NSString* color)
{
    static NSString* const CLEAR_COLOR = @"CLEAR";
    if ([color isEqualToString:CLEAR_COLOR]) {
        return [UIColor clearColor];
    }
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

CGRect JMRectSetOriginX(CGRect rect, CGFloat originX) {
    CGPoint origin = rect.origin;
    origin.x = originX;
    rect.origin = origin;
    return rect;
}

void JMDispatchSyncOnMainQueue(void (^block)(void))
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

//
//  UIDevice+iOSVersionUtil.m
//  DMFoundation
//
//  Created by Terry Tan on 9/10/15.
//  Copyright (c) 2015 zhoujun. All rights reserved.
//

#import "UIDevice+iOSVersionUtil.h"

@implementation UIDevice (iOSVersionUtil)

+ (BOOL)currentOSUnderiOS8
{
    return [[UIDevice currentDevice].systemVersion compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending;
}

@end

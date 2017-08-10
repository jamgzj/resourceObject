//
//  UserInfo.m
//  Tou-Time
//
//  Created by zhengxingxia on 16/10/12.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "UserInfo.h"
#import "JMTool.h"
#import "Header.h"

@implementation UserInfo

+ (instancetype)getUserInfo {
    NSError *error;
    UserInfo *info = [[UserInfo alloc]initWithDictionary:getObject(USER_INFO_KEY) error:&error];
    if (error) {
        return nil;
    }
    return info;
}

@end

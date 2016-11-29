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
#import "MJExtension/MJExtension.h"
@implementation UserInfo

+ (instancetype)getUserInfo
{
    UserInfo *info = [UserInfo mj_objectWithKeyValues:[JMTool getObjectForKey:USER_INFO_KEY]];
    
    return info;
}

@end

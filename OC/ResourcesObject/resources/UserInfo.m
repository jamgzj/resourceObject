//
//  UserInfo.m
//  Tou-Time
//
//  Created by zhengxingxia on 16/10/12.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "UserInfo.h"
#import "JMTool.h"

@implementation UserInfo

+ (instancetype)getUserInfo {
    NSError *error;
    UserInfo *info = [[UserInfo alloc]initWithDictionary:[getObject(USER_INFO_KEY) jsonValueDecoded] error:&error];
    if (error) {
        return nil;
    }
    return info;
}

+ (BOOL)saveUserInfo:(id)userInfo {
    NSDictionary *dataDict;
    if ([userInfo isKindOfClass:[NSDictionary class]]) {
        dataDict = userInfo;
    }
    if ([userInfo isKindOfClass:[self class]]) {
        UserInfo *model = userInfo;
        dataDict = model.toDictionary;
    }
    if (!dataDict) {
        return NO;
    }
    NSString *userJson = [dataDict jsonStringEncoded];
    setObjectForKey(userJson, USER_INFO_KEY);
    return YES;
}

- (void)save {
    NSDictionary *dataDict = self.toDictionary;
    NSString *userJson = [dataDict jsonStringEncoded];
    setObjectForKey(userJson, USER_INFO_KEY);
}

@end

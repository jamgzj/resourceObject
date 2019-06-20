//
//  JMResourceManager.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/5/30.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "JMResourceManager.h"
#import "NSDictionary+JSON.h"
#import "NSArray+JSON.h"

@implementation JMResourceManager

+ (UIStoryboard*)storyboardWithName:(NSString *)storyboardName
{
    return [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
}

+ (UINib*)bundleNibNamed: (NSString*)name
{
    return [UINib nibWithNibName:name bundle:[NSBundle mainBundle]];
}

+ (NSString*)fileContentWithName:(NSString *)name extension:(NSString *)extension
{
    NSBundle* bundle = [NSBundle mainBundle];
    if (!bundle) {
        return nil;
    }
    
    NSURL* urlOfFile = [bundle URLForResource:name withExtension:extension subdirectory:nil];
    if (!urlOfFile) {
        return nil;
    }
    
    NSString* contentOfFile = [NSString stringWithContentsOfURL:urlOfFile encoding:NSUTF8StringEncoding error:nil];
    return contentOfFile;
}

+ (NSDictionary*)dictionaryWithJSONFileOfName: (NSString*)fileName
{
    NSString* JSONString = [self fileContentWithName:fileName extension:@"json"];
    return [NSDictionary dictionaryWithJSONString:JSONString];
}

+ (NSArray*)arrayWithJSONFileOfName: (NSString*)fileName
{
    NSString* JSONString = [self fileContentWithName:fileName extension:@"json"];
    return [NSArray arrayWithJSONString:JSONString];
}

+ (id)instantiateViewFromNibWithClass: (Class)viewClass
{
    NSString* name = NSStringFromClass(viewClass);
    return [self instantiateViewFromNibWithName:name];
}

+ (id)instantiateViewFromNibWithName: (NSString*)viewName
{
    UINib* nib = [self bundleNibNamed:viewName];
    return [nib instantiateWithOwner:nil options:nil][0];
}


@end

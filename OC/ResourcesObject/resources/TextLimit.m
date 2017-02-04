//
//  TextLimit.m
//  TextInputLimit
//
//  Created by wangguoliang on 15/12/15.
//  Copyright © 2015年 wangguoliang. All rights reserved.
//

#import "TextLimit.h"
#import <objc/runtime.h>

@implementation UITextField (limit)

- (id)valueForUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"limit"]) {
        return objc_getAssociatedObject(self, key.UTF8String);
    }
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"limit"]) {
        objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_RETAIN);
    }
}

@end

@implementation UITextView (limit)

- (id)valueForUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"limit"]) {
        return objc_getAssociatedObject(self, key.UTF8String);
    }
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"limit"]) {
        objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_RETAIN);
    }
}

@end

@implementation TextLimit

+ (void)load
{
    [super load];
    [TextLimit sharedTextLimit];
}

+ (TextLimit *)sharedTextLimit
{
    static TextLimit *textLimit;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textLimit = [[TextLimit alloc] init];
    });
    return textLimit;
}

- (id)init
{
    if (self = [super init]) {
        // 通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object: nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textViewDidChange:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object: nil];
    }
    return self;
}
#pragma mark - 通知事件
- (void)textFieldDidChange:(NSNotification*)notification
{
    UITextField *textField = (UITextField *)notification.object;
    
    NSNumber *number = [textField valueForKey:@"limit"];
    if (number && textField.text.length > [number integerValue] && textField.markedTextRange == nil) {
        textField.text = [textField.text substringWithRange: NSMakeRange(0, [number integerValue])];
    }
}


- (void)textViewDidChange: (NSNotification *) notificaiton
{
    UITextView *textView = (UITextView *)notificaiton.object;
    
    NSNumber *number = [textView valueForKey:@"limit"];
    if (number && textView.text.length > [number integerValue] && textView.markedTextRange == nil) {
        textView.text = [textView.text substringWithRange: NSMakeRange(0, [number integerValue])];
    }
}
@end

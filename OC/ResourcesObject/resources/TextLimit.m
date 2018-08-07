//
//  TextLimit.m
//  TextInputLimit
//
//  Created by wangguoliang on 15/12/15.
//  Copyright © 2015年 wangguoliang. All rights reserved.
//

#import "TextLimit.h"
#import <objc/runtime.h>

@interface NSString (Limit)

@property (readonly,assign,nonatomic)BOOL containsEmoji;

@end

@implementation NSString (Limit)

- (BOOL)containsEmoji {
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];
    
    return returnValue;
}

@end

@implementation UITextField (limit)

- (id)valueForUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"limit"]) {
        return objc_getAssociatedObject(self, key.UTF8String);
    }
    if ([key isEqualToString:@"noEmoji"]) {
        return objc_getAssociatedObject(self, key.UTF8String);
    }
    if ([key isEqualToString:@"byte"]) {
        return objc_getAssociatedObject(self, key.UTF8String);
    }
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"limit"]) {
        objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_RETAIN);
    }
    if ([key isEqualToString:@"noEmoji"]) {
        objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_RETAIN);
    }
    if ([key isEqualToString:@"byte"]) {
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
    if ([key isEqualToString:@"noEmoji"]) {
        return objc_getAssociatedObject(self, key.UTF8String);
    }
    if ([key isEqualToString:@"byte"]) {
        return objc_getAssociatedObject(self, key.UTF8String);
    }
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"limit"]) {
        objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_RETAIN);
    }
    if ([key isEqualToString:@"noEmoji"]) {
        objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_RETAIN);
    }
    if ([key isEqualToString:@"byte"]) {
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
    
    NSNumber *noEmoji = [textField valueForKey:@"noEmoji"];
    if (noEmoji.boolValue && textField.markedTextRange == nil) {
        if (textField.text.containsEmoji) {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
            NSString *modifiedString = [regex stringByReplacingMatchesInString:textField.text
                                                                       options:0
                                                                         range:NSMakeRange(0, [textField.text length])
                                                                  withTemplate:@""];
            textField.text = modifiedString;
        }
    }
    
    NSNumber *number = [textField valueForKey:@"limit"];
    if (number && textField.text.length > [number integerValue] && textField.markedTextRange == nil) {
        textField.text = [textField.text substringWithRange: NSMakeRange(0, [number integerValue])];
    }
    
    NSNumber *byte = [textField valueForKey:@"byte"];
    NSString *string = textField.text;
    NSInteger byteLength = [self getByteLengthForString:string];
    if (byte && byte.integerValue > 0 && byteLength > byte.integerValue && textField.markedTextRange == nil) {
        while ([self getByteLengthForString:string] > byte.integerValue) {
            string = [string substringToIndex:string.length-1];
        }
        textField.text = string;
    }
}


- (void)textViewDidChange: (NSNotification *) notificaiton
{
    UITextView *textView = (UITextView *)notificaiton.object;
    
    NSNumber *noEmoji = [textView valueForKey:@"noEmoji"];
    if (noEmoji.boolValue && textView.markedTextRange == nil) {
        if (textView.text.containsEmoji) {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
            NSString *modifiedString = [regex stringByReplacingMatchesInString:textView.text
                                                                       options:0
                                                                         range:NSMakeRange(0, [textView.text length])
                                                                  withTemplate:@""];
            textView.text = modifiedString;
        }
    }
    
    NSNumber *number = [textView valueForKey:@"limit"];
    if (number && textView.text.length > [number integerValue] && textView.markedTextRange == nil) {
        textView.text = [textView.text substringWithRange: NSMakeRange(0, [number integerValue])];
    }
    
    NSNumber *byte = [textView valueForKey:@"byte"];
    NSString *string = textView.text;
    NSInteger byteLength = [self getByteLengthForString:string];
    if (byte && byte.integerValue > 0 && byteLength > byte.integerValue && textView.markedTextRange == nil) {
        while ([self getByteLengthForString:string] > byte.integerValue) {
            string = [string substringToIndex:string.length-1];
        }
        textView.text = string;
    }
}

- (NSInteger)getByteLengthForString:(NSString *)string {
    NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [string dataUsingEncoding:encode];
    return [data length];
}

@end

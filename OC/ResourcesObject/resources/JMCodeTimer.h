//
//  JMCodeTimer.h
//  Seen
//
//  Created by CMVIOS1 on 2018/6/22.
//  Copyright © 2018年 Amor. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const CodeTimeDidStopNotification = @"CodeTimeDidStop";
static NSString *const CodeTimeDidChangeNotification = @"CodeTimeDidChange";

@interface JMCodeTimer : NSObject   // 验证码计时器

// 剩余时间
@property (readonly,assign,nonatomic)NSInteger time;

+ (instancetype)sharedInstance;

- (void)startTimer;



@end

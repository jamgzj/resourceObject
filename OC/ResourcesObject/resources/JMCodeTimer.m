//
//  JMCodeTimer.m
//  Seen
//
//  Created by CMVIOS1 on 2018/6/22.
//  Copyright © 2018年 Amor. All rights reserved.
//

#import "JMCodeTimer.h"

@interface JMCodeTimer ()

@property (strong,nonatomic)NSTimer *timer;

@property (readwrite,assign,nonatomic)NSInteger time;

@end

@implementation JMCodeTimer

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(timerRepeat) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)startTimer {
    self.time = 60;
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer setFireDate:[NSDate date]];
}

- (void)timerRepeat {
    if (_time == 0) {
        [_timer setFireDate:[NSDate distantFuture]];
        [[NSNotificationCenter defaultCenter]postNotificationName:CodeTimeDidStopNotification object:nil userInfo:nil];
        return;
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:CodeTimeDidChangeNotification object:nil userInfo:@{@"time":@(self.time)}];
    _time--;
}



@end









//
//  JMAlertView.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/22.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "JMAlertView.h"

@implementation JMAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)titles
                        block:(JMAlertAction)block {
    if (self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil]) {
        NSUInteger count = titles.count;
        for (int i = 0; i < count; i++) {
            [self addButtonWithTitle:titles[i]];
        }
        _block = block;
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.block) {
        self.block(buttonIndex);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


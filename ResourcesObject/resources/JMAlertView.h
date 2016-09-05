//
//  JMAlertView.h
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/22.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JMAlertAction)(NSInteger index);

@interface JMAlertView : UIAlertView<UIAlertViewDelegate>

@property (copy,nonatomic)JMAlertAction block;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)titles
                        block:(JMAlertAction)block;

@end

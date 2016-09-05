//
//  JMLoopScrollView.h
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/20.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import <UIKit/UIKit.h>

// 引导页
@interface JMScrollView : UIView<UIScrollViewDelegate>

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIPageControl *pageCtl;

+ (JMScrollView *)scrollViewWithFrame:(CGRect)frame
                               Images:(NSMutableArray *)imgArray;

@end

//
//  JMLoopScrollView.h
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/20.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMScrollViewDelegate <NSObject>

@optional
-(void)lastPageClick;

@end
// 引导页
@interface JMScrollView : UIView<UIScrollViewDelegate>

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIPageControl *pageCtl;
@property (weak,nonatomic)id<JMScrollViewDelegate> scrollViewDelegate;
+ (JMScrollView *)scrollViewWithFrame:(CGRect)frame
                               Images:(NSMutableArray *)imgArray;

@end

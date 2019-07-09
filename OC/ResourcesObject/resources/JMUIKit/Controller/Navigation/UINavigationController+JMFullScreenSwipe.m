//
//  UINavigationController+JMFullScreenSwipe.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/7/2.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "UINavigationController+JMFullScreenSwipe.h"
#import <objc/runtime.h>
#import "NSObject+JMSwizzle.h"

@interface UINavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation UINavigationController (JMFullScreenSwipe)

+ (void)load
{
    [self jm_trySwizzleMethod:@selector(viewDidLoad) withMethod:@selector(jm_viewDidLoad)];
}

- (void)jm_viewDidLoad
{
    [self jm_viewDidLoad];
    id target = self.interactivePopGestureRecognizer.delegate;
    
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    //  获取添加系统边缘触发手势的View
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    
    UIPanGestureRecognizer * fullScreenGesture = [[UIPanGestureRecognizer alloc]initWithTarget:target action:handler];
    fullScreenGesture.delegate = self;
    [targetView addGestureRecognizer:fullScreenGesture];
    
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    [self.interactivePopGestureRecognizer setEnabled:NO];
    self.enableSwipeToDismiss = YES;
}

- (BOOL)enableSwipeToDismiss
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEnableSwipeToDismiss:(BOOL)enableSwipeToDismiss
{
    [self.interactivePopGestureRecognizer setEnabled:!enableSwipeToDismiss];
    objc_setAssociatedObject(self, @selector(enableSwipeToDismiss), [NSNumber numberWithBool:enableSwipeToDismiss], OBJC_ASSOCIATION_ASSIGN);
}

//  防止导航控制器只有一个rootViewcontroller时触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (!self.enableSwipeToDismiss) {
        return NO;
    }
    
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
    //解决与左滑手势冲突
    CGPoint translation = [pan translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    // 过滤执行过渡动画时的手势处理
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    return self.childViewControllers.count == 1 ? NO : YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    UIView *view = otherGestureRecognizer.view;
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        if (scrollView.bounces) {
            return NO;
        }
        if (scrollView.contentOffset.x == 0) {
            return YES;
        }
    }
    return NO;
}

@end

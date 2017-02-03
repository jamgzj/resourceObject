//
//  UIView+ExtensionUIView.m
//  MySNweibo
//
//  Created by sq-ios08 on 16/1/30.
//  Copyright © 2016年 shangqian. All rights reserved.
//

#import "UIView+ExtensionUIView.h"
#import "Header.h"
#import <Masonry/Masonry.h>

static const void *badgeViewKey = &badgeViewKey;
static const void *badgeValueKey = &badgeValueKey;

@implementation UIView (ExtensionUIView)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x =x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y =y;
    self.frame = frame;

}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height =height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size =size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin =origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)left {
    return self.origin.x;
}

- (CGFloat)top {
    return self.origin.y;
}

- (CGFloat)right {
    return self.origin.x + self.width;
}

- (CGFloat)bottom {
    return self.origin.y + self.height;
}

- (void)addShadowAroundWithCornerRadius:(float)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.shadowColor = [UIColor colorWithWhite:0.3 alpha:0.3].CGColor;
    self.layer.shadowRadius = 2*coefficient;
    self.layer.shadowOpacity = 1.f;
    self.layer.shadowOffset = CGSizeZero;
}

- (NSString *)badgeValue {
    return objc_getAssociatedObject(self, badgeValueKey);
}

- (void)setBadgeValue:(NSString *)badgeValue {
    if (badgeValue) {
        if ([badgeValue isEqualToString:@"0"]) {
            [self.badgeView removeFromSuperview];
        }else {
            self.badgeView = [[UILabel alloc]init];
            self.badgeView.text = badgeValue;
            self.badgeView.font = [UIFont systemFontOfSize:11];
            self.badgeView.textColor = [UIColor whiteColor];
            self.badgeView.textAlignment = NSTextAlignmentCenter;
            self.badgeView.backgroundColor = [UIColor redColor];
            [self addSubview:self.badgeView];
            [self.badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.mas_right);
                make.centerY.mas_equalTo(self.mas_top);
                if (self.width>self.height) {
                    make.width.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
                }else {
                    make.width.height.mas_equalTo(self.mas_width).multipliedBy(0.3);
                }
            }];
            [self setNeedsLayout];
            [self layoutIfNeeded];
            self.badgeView.layer.cornerRadius = self.badgeView.width/2.f;
            self.badgeView.layer.masksToBounds = YES;
        }
    }
    objc_setAssociatedObject(self, badgeValueKey, badgeValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UILabel *)badgeView {
    return objc_getAssociatedObject(self, badgeViewKey);
}

- (void)setBadgeView:(UILabel *)badgeView {
    if (!self.badgeView) {
        objc_setAssociatedObject(self, badgeViewKey, badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)removeBadge {
    [self.badgeView removeFromSuperview];
}

@end

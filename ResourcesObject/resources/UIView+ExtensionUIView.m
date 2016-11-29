//
//  UIView+ExtensionUIView.m
//  MySNweibo
//
//  Created by sq-ios08 on 16/1/30.
//  Copyright © 2016年 shangqian. All rights reserved.
//

#import "UIView+ExtensionUIView.h"
#import "Header.h"

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

@end

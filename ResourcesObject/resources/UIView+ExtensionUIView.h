//
//  UIView+ExtensionUIView.h
//  MySNweibo
//
//  Created by sq-ios08 on 16/1/30.
//  Copyright © 2016年 shangqian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ExtensionUIView)

@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGSize size;
@property (nonatomic)CGPoint origin;
@property (nonatomic, assign, readonly) CGFloat left;
@property (nonatomic, assign, readonly) CGFloat top;
@property (nonatomic, assign, readonly) CGFloat right;
@property (nonatomic, assign, readonly) CGFloat bottom;


/**
 *  添加view四周的阴影
 *
 *  @param cornerRadius <#cornerRadius description#>
 */
- (void)addShadowAroundWithCornerRadius:(float)cornerRadius;

@end

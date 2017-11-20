//
//  DistanceLineTableViewCell.h
//  ResourcesObject
//
//  Created by CMVIOS1 on 2017/11/20.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistanceLineTableViewCell : UITableViewCell

// 线条从左到右
- (void)getAnimationLayerToRight;

// 线条从右到左
- (void)getAnimationLayerToLeft;

@end

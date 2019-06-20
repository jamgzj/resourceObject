//
//  UIImage+JMImageCategory.h
//  JMFoundation
//
//  Created by zhoujun on 15/10/19.
//  Copyright © 2015年 zhoujun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JMImageCategory)

+ (UIImage *)getImageFromURLString:(NSString *)imageURLString;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage*)imageMaskedWithColor: (UIColor*)color;

- (UIImage*)imageByMirroring;

+ (UIImage*)imageFromPhotoLibararyURLString: (NSString*)urlString;

+ (UIImage*)gifImageWithName: (NSString*)imageName bundle: (NSBundle*)bundle;

- (NSString*)base64StringRepresentation;

@end

//
//  UIImage+JMImageCategory.m
//  JMFoundation
//
//  Created by zhoujun on 15/10/19.
//  Copyright © 2015年 zhoujun. All rights reserved.
//

#import "UIImage+JMImageCategory.h"
#import <Photos/Photos.h>
#import <SDWebImage/UIImage+GIF.h>

@implementation UIImage (JMImageCategory)

+ (UIImage *)getImageFromURLString:(NSString *)imageURLString
{
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLString]];
    
    result = [UIImage imageWithData:data];
    
    return result;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage*)imageMaskedWithColor: (UIColor*)color
{
    color = color ?: [UIColor whiteColor];
    
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextScaleCTM(context, 1.0f, -1.0f);
        CGContextTranslateCTM(context, 0.0f, -(imageRect.size.height));
        
        CGContextClipToMask(context, imageRect, self.CGImage);
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, imageRect);
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage*)imageByMirroring
{
    return [UIImage imageWithCGImage:self.CGImage
                               scale:self.scale
                         orientation:UIImageOrientationUpMirrored];
}

+ (UIImage*)imageFromPhotoLibararyURLString: (NSString*)urlString
{
    if (!urlString) {
        return nil;
    }
    
    __block UIImage* image = nil;
    PHFetchResult<PHAsset*>* result = [PHAsset fetchAssetsWithALAssetURLs:@[[NSURL URLWithString:urlString]] options:nil];
    PHAsset* asset = result.firstObject;
    
    if (asset) {
        PHImageRequestOptions* options = [[PHImageRequestOptions alloc] init];
        [options setSynchronous:YES];
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:(PHImageContentModeAspectFit) options:options resultHandler:^(UIImage* result, NSDictionary* info) {
            image = result;
        }];
    }

    return image;
}

+ (UIImage*)gifImageWithName: (NSString*)imageName bundle: (NSBundle*)bundle
{
    static NSString *const GifType = @"gif";
    NSString *path = [bundle pathForResource:imageName ofType:GifType];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    return image;
}

- (NSString*)base64StringRepresentation
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0f);
    NSString *base64Encoded = [data  base64EncodedStringWithOptions:0];
    return base64Encoded;
}

@end

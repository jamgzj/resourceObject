//
//  JMWebImage.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/17.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "JMWebImage.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>

@implementation JMWebImage

+ (void)downloadImageWithURL: (NSURL*)url
{
    [self downloadImageWithURL:url completion:nil];
}

+ (void)downloadImageWithURL: (NSURL*)url completion: (JMImageDownloadCompletion)completion
{
    [[SDWebImageManager sharedManager] downloadImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (completion && finished) {
            completion(image, error);
        }
    }];
}

+ (UIImage*)cachedImageWithURL: (NSURL*)url
{
    if (!url) {
        return nil;
    }
    
    SDImageCache* cache = [SDImageCache sharedImageCache];
    NSString* key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    return [cache imageFromMemoryCacheForKey:key] ?: [cache imageFromDiskCacheForKey:key];
}

@end

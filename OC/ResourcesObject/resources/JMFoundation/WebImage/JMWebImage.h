//
//  JMWebImage.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/17.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JMImageDownloadCompletion)(UIImage* image, NSError *error);

@interface JMWebImage : NSObject

+ (void)downloadImageWithURL: (NSURL*)url;

+ (void)downloadImageWithURL: (NSURL*)url completion: (JMImageDownloadCompletion)completion;

+ (UIImage*)cachedImageWithURL: (NSURL*)url;

@end

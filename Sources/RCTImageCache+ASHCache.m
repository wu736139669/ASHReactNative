//
//  RCTImageCache+ASHCache.m
//  ASHReactNative
//
//  Created by xmfish on 17/4/10.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "RCTImageCache+ASHCache.h"
#import <SDImageCache.h>
@implementation RCTImageCache (ASHCache)

- (void)addImageToCache:(UIImage *)image
                    URL:(NSString *)url
                   size:(CGSize)size
                  scale:(CGFloat)scale
             resizeMode:(RCTResizeMode)resizeMode
           responseDate:(NSString *)responseDate
{
    [[SDImageCache sharedImageCache] storeImage:image forKey:url completion:nil];
}

- (UIImage *)imageForUrl:(NSString *)url
                    size:(CGSize)size
                   scale:(CGFloat)scale
              resizeMode:(RCTResizeMode)resizeMode
            responseDate:(NSString *)responseDate;
{
    UIImage* image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
    return image;
}

@end

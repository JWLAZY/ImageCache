//
//  UIImageView+JWCache.m
//  JWImageCache
//
//  Created by 郑建文 on 15/12/23.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "UIImageView+JWCache.h"
#import "JWImageDownloader.h"
#import "JWImageOperation.h"
#import "JWImageManager.h"


@implementation UIImageView (JWCache)


- (void)jw_setImageWithURL:(NSURL *)imageUrl
{
    //通过manager去查找
    __weak __typeof(self) wself = self;
    //获取到一个操作,同时进行下载
    id<JWImageOperation> operation = [[JWImageManager sharedManager] downloadImageWithURL:imageUrl progress:^(NSInteger receivedSize, NSInteger expectedSize) {

    } completed:^(UIImage *image, JWImageCacheType cacheType, NSError *error, BOOL finished) {
        wself.image = image;
        [wself setNeedsLayout];
    }];
}

@end

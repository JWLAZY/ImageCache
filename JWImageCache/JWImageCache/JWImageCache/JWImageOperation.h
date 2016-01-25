//
//  JWImageOperation.h
//  JWImageCache
//
//  Created by 郑建文 on 15/12/23.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JWImageCache.h"

@protocol JWImageOperation <NSObject>

- (void)cancel;

@end

typedef void(^JWImageDownloaderProgressBlock)(NSInteger receivedSize,NSInteger expectedSize);

typedef void(^JWImageDownloaderCompletedBlock)(UIImage *image,JWImageCacheType cacheType,NSError *error,BOOL finished);
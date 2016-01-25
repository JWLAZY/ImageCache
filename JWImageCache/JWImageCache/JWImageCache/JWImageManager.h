//
//  JWImageManager.h
//  JWImageCache
//
//  Created by 郑建文 on 15/12/23.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JWImageCache.h"
#import "JWImageDownloader.h"


@class JWImageManager;
@protocol JWImageManagerDelegate <NSObject>

@optional
- (BOOL)imageManager:(JWImageManager *)manager shouldDownloadImageForURL:(NSURL *)URL;

@end

@interface JWImageManager : NSObject

//用来缓存相关操作
@property (nonatomic,strong) JWImageCache * imageCache;
//用来下载图片相关操作
@property (nonatomic,strong) JWImageDownloader * imageDownloader;

+ (instancetype)sharedManager;


@end

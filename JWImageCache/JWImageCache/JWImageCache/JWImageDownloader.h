//
//  JWImageDownloader.h
//  JWImageCache
//
//  Created by 郑建文 on 15/12/24.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JWImageOperation.h"


typedef NS_OPTIONS(NSUInteger, JWImageDownloaderOptions) {
    JWImageDownloaderLowPriority = 1 << 0,
    JWImageDownloaderProgressiveDownload = 1 << 1,

    /**
     * 利用urlcache下载
     */
    JWImageDownloaderUseNSURLCache = 1 << 2,

    /**
     * Call completion block with nil image/imageData if the image was read from NSURLCache
     * (to be combined with `JWImageDownloaderUseNSURLCache`).
     */

    JWImageDownloaderIgnoreCachedResponse = 1 << 3,
    /**
     * In iOS 4+, continue the download of the image if the app goes to background. This is achieved by asking the system for
     * extra time in background to let the request finish. If the background task expires the operation will be cancelled.
     */

    JWImageDownloaderContinueInBackground = 1 << 4,

    /**
     * Handles cookies stored in NSHTTPCookieStore by setting
     * NSMutableURLRequest.HTTPShouldHandleCookies = YES;
     */
    JWImageDownloaderHandleCookies = 1 << 5,

    /**
     * Enable to allow untrusted SSL certificates.
     * Useful for testing purposes. Use with caution in production.
     */
    JWImageDownloaderAllowInvalidSSLCertificates = 1 << 6,

    /**
     * Put the image in the high priority queue.
     */
    SDWebImageDownloaderHighPriority = 1 << 7,
};


@interface JWImageDownloader : NSObject

+ (instancetype)sharedImageDownloader;

- (id<JWImageOperation>)downloadImageWithURL:(NSURL *)url options:(JWImageDownloaderOptions)option progressBlock:(JWImageDownloaderProgressBlock)progressBlock completedBlock:(JWImageDownloaderCompletedBlock)completedBlock;

@end

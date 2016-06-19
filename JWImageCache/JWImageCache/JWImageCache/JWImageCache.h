//
//  JWImageCache.h
//  JWImageCache
//
//  Created by 郑建文 on 15/12/23.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


/**
 *  图片缓存类型
 */
typedef NS_ENUM(NSUInteger, JWImageCacheType) {
    /**
     *  不缓存
     */
    JWImageCacheNone,
    /**
     *  缓存到沙盒
     */
    JWImageCacheTypeDisk,
    /**
     *  缓存到内存
     */
    JWImageCacheTypeMemory,
};

typedef void (^JWImageQueryCompletedBlock)(UIImage *image, JWImageCacheType cacheType);
typedef void (^JWImageCheckCacheCompletionBlock)(BOOL isInCache);


/**
 *  内存缓存关键类
 */
@interface JWImageCache : NSObject

+ (instancetype)sharedCache;

/**
 *  根据key 去查找图片
 *
 *  @param key       <#key description#>
 *  @param doneBlock <#doneBlock description#>
 *
 *  @return <#return value description#>
 */
- (NSOperation *)queryDiskCacheForKey:(NSString *)key done:(JWImageQueryCompletedBlock)doneBlock;

@end

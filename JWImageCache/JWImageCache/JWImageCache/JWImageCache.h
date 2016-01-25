//
//  JWImageCache.h
//  JWImageCache
//
//  Created by 郑建文 on 15/12/23.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

typedef NS_ENUM(NSUInteger, JWImageCacheType) {
    JWImageCacheNone,
    JWImageCacheTypeDisk,
    JWImageCacheTypeMemory,
};

typedef void(^JWImageQueryCompletedBlock)(UIImage *image,JWImageCacheType cacheType);
typedef void(^JWImageCheckCacheCompletionBlock)(BOOL isInCache);

@interface JWImageCache : NSObject

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

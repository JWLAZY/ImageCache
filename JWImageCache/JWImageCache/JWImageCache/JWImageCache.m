//
//  JWImageCache.m
//  JWImageCache
//
//  Created by 郑建文 on 15/12/23.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "JWImageCache.h"
#import <CommonCrypto/CommonDigest.h>

static __inline__ NSUInteger JWCacheCostForImage(UIImage *image){
    return image.size.height * image.size.width * image.scale * image.scale;
}

@interface JWImageCache ()


@property (nonatomic,strong) NSCache * memCache;
@property (nonatomic,strong) dispatch_queue_t ioQueue;
@property (nonatomic,strong) NSString * diskCachePath;

@end

@implementation JWImageCache


#pragma mark - 路径问题


//获取指定路径的文件路径
- (NSString *)cachePathForKey:(NSString *)key inPath:(NSString *)path{
    NSString *fileName = [self cachedFileNameForKey:key];
    return [path stringByAppendingPathComponent:fileName];
}

- (NSString *)defaultCachePathForKey:(NSString *)key{
    //TODO: 设置缓存路径
    return [self cachePathForKey:key inPath:self.diskCachePath];
}

//根据key获取到文件存储的名字
- (NSString *)cachedFileNameForKey:(NSString *)key{
    const char *str = [key UTF8String];
    
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    
    NSString *fileName = @"";
    for (int i = 0; i < 16; i++) {
        fileName = [fileName stringByAppendingString:[NSString stringWithFormat:@"%02x",r[i]]];
    }
    return [fileName stringByAppendingString:[[key pathExtension] isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@",[key pathExtension]]];
}


- (NSOperation *)queryDiskCacheForKey:(NSString *)key done:(JWImageQueryCompletedBlock)doneBlock{
    //如果么有传入找到图片后的block,那就什么都不做
    if (!doneBlock) {
        return nil;
    }
    if (!key) {
        DLOG(@"没有传入key")
        doneBlock(nil,JWImageCacheNone);
        return nil;
    }
    
    UIImage *image = [self imageFromMemoryCacheForKey:key];
    if (image) {
        doneBlock(image,JWImageCacheTypeMemory);
        DLOG(@"在内存中找到看图片,key:%@",key);
        return nil;
    }
    
    //如果内存中没有找到图片,则创建一个操作来去沙盒中找图片
    NSOperation *operation = [NSOperation new];
    dispatch_async(self.ioQueue, ^{
       
        @autoreleasepool {
            UIImage *diskImage = [self diskImageForKey:key];
            if (diskImage) {
                //将沙盒中的数据取出来存放到内存中.
                NSUInteger cost = JWCacheCostForImage(diskImage);
                [self.memCache setObject:diskImage forKey:key cost:cost];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                doneBlock(diskImage,JWImageCacheTypeDisk);
            });
        }
    });
    return operation;
}
// 根据key去沙盒中区寻找文件(nsdata)
- (NSData *)diskImageDataBySearchingAppPathsForKey:(NSString *)key{
    NSString *defaultPath = [self defaultCachePathForKey:key];
    NSData *data = [NSData dataWithContentsOfFile:defaultPath];
    if (data) {
        return data;
    }
    
    //TODO: 查找自定义的缓存文件夹
    return nil;
}
- (UIImage *)diskImageForKey:(NSString*)key{

    NSData *data = [self diskImageDataBySearchingAppPathsForKey:key];
    if (data) {
        //TODO: 应该做data转image的处理,可以写catalog来实现
        UIImage *iamge = [UIImage imageWithData:data];

        return iamge;
    }
    
    return nil;
}

- (UIImage *)imageFromMemoryCacheForKey:(NSString *)key{
    return [_memCache objectForKey:key];
}

@end

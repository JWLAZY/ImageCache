//
//  JWImageManager.m
//  JWImageCache
//
//  Created by 郑建文 on 15/12/23.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "JWImageManager.h"
#import "JWImageOperation.h"


@interface JWImageCombinedOperateion : NSObject <JWImageOperation>

@property (nonatomic, strong) NSOperation *cacheOperation;

@end


@implementation JWImageCombinedOperateion


@end


@interface JWImageManager ()

//存放opation的数组
@property (nonatomic, strong) NSMutableArray *runningOperations;

@end


@implementation JWImageManager

+ (instancetype)sharedManager
{
    static JWImageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JWImageManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _runningOperations = [NSMutableArray new];
        if (true) NSLog(@"test");
    }
    return self;
}


//根据一个链接去获取一个图片
- (id<JWImageOperation>)downloadImageWithURL:(NSURL *)URL progress:(JWImageDownloaderProgressBlock)progressBlock completed:(JWImageDownloaderCompletedBlock)completedBlock
{
    NSAssert(completedBlock != nil, @"完成回调block 不能为空");

    //TODO: 做失败列表判断

    __block JWImageCombinedOperateion *operation = [JWImageCombinedOperateion new];
    __weak JWImageCombinedOperateion *weakOperation = operation;

    //将创建出来的操作添加到数组中去
    [_runningOperations addObject:operation];


    NSString *key = [self cacheKeyForURL:URL];
    weakOperation.cacheOperation = [self.imageCache queryDiskCacheForKey:key done:^(UIImage *image, JWImageCacheType cacheType) {
        //TODO: 做图片和缓存类型的处理.
        //TODO: 如果没有图片返回或者设置为图片都要最新的.
        if (image) {
            if ([NSThread isMainThread]) {
                completedBlock(image, cacheType, nil, YES);
            } else {
                dispatch_block_t block = ^() {
                    completedBlock(image, cacheType, nil, YES);
                };
                dispatch_sync(dispatch_get_main_queue(), block);
            }
        }
    }];

    return operation;
}

- (NSString *)cacheKeyForURL:(NSURL *)url
{
    return [url absoluteString];
}

@end

//
//  JWImageDownloader.m
//  JWImageCache
//
//  Created by 郑建文 on 15/12/24.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "JWImageDownloader.h"

@implementation JWImageDownloader

/**
 *  下载一个图片
 *
 *  @param url            链接地址
 *  @param option         下载策略
 *  @param progressBlock  下载过程回调方法
 *  @param completedBlock 下载成功回调方法
 *
 *  @return 下载的操作
 */
- (id<JWImageOperation>)downloadImageWithURL:(NSURL *)url options:(JWImageDownloaderOptions)option progressBlock:(JWImageDownloaderProgressBlock)progressBlock completedBlock:(JWImageDownloaderCompletedBlock)completedBlock{
    return nil;
}

@end

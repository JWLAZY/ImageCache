//
//  CommonDefine.h
//  JWImageCache
//
//  Created by 郑建文 on 15/12/24.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h


#ifdef DEBUG
#define DLOG(fmt, ...) NSLog((@"%s [line %d] " fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLOG(...)
#endif

#endif /* CommonDefine_h */

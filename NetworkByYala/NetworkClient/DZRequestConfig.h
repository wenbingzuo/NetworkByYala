//
//  DZRequestConfig.h
//  NetworkByYala
//
//  Created by 文兵 左 on 12/11/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#ifndef DZRequestConfig_h
#define DZRequestConfig_h

/**
 *  基类URL的定义
 */
#define DZ_ENVIRONMENT_TEST                      0
#define DZ_ENVIRONMENT_DEVELOPMENT               1

#define DZ_ENVIRONMENT DZ_ENVIRONMENT_TEST

#if DZ_ENVIRONMENT == DZ_ENVIRONMENT_TEST
    #define DZ_BASE_URL                             @"TEST_API"
#elif DZ_ENVIRONMENT == DZ_ENVIRONMENT_DEVELOPMENT
    #define DZ_BASE_URL                             @"DEVELOPMENT_API"
#else
    #define DZ_BASE_URL                             @"NO_API"
#endif


#ifdef DEBUG
    #define DZDebugLog(...)    NSLog(__VA_ARGS__)
    #define DZDebugMethod()    NSLog(@"%s", __func__)
    #define DZDebugError()     NSLog(@"Error at %s Line:%d", __func__, __LINE__)
#else
    #define DZDebugLog(...)
    #define DZDebugMethod()
    #define DZDebugError()
#endif


#endif /* DZRequestConfig_h */

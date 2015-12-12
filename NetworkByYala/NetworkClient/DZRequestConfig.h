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
 *  HTTP请求方式
 */
typedef NS_ENUM(NSInteger, DZRequestMethod) {
    /**
     *  GET请求
     */
    DZRequestMethodGet = 0,
    /**
     *  POST请求
     */
    DZRequestMethodPost,
    /**
     *  PUT请求
     */
    DZRequestMethodPUT,
    /**
     *  DELETE请求
     */
    DZRequestMethodDelete
};

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


#endif /* DZRequestConfig_h */

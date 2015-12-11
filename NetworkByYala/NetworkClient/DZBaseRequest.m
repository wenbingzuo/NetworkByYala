//
//  DZBaseRequest.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/11/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DZBaseRequest.h"
#import "DZRequestConfig.h"

@implementation DZBaseRequest

- (NSString *)baseURL {
    return DZ_ENVIRONMENT;
}

- (DZRequestMethod)requestMethod {
    return DZRequestMethodGet;
}

@end

//
//  DZCacheRequest.h
//  NetworkByYala
//
//  Created by 文兵 左 on 12/13/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DZBaseRequest.h"

@interface DZCacheRequest : DZBaseRequest

// flag - whether load data from cache. default `YES`
@property (nonatomic, assign) BOOL useCache;

// cache data
@property (nonatomic, strong, readonly) id cacheData;

// cache time interval, origin `60` second
@property (nonatomic, assign) NSTimeInterval cacheTimeInterval;

// start ignore cache. `[super start]`will toggle
- (void)startWithoutCache;

@end

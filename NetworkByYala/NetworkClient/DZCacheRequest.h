//
//  DZCacheRequest.h
//  NetworkByYala
//
//  Created by 文兵 左 on 12/13/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DZBaseRequest.h"

@interface DZCacheRequest : DZBaseRequest

@property (nonatomic, assign) BOOL loadCache;

- (id)dataFromCache;

- (void)saveData:(id)responseObject;

@end

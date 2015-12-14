//
//  DoubanRequest.h
//  NetworkByYala
//
//  Created by 文兵 左 on 12/14/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DZCacheRequest.h"

@interface DoubanRequest : DZCacheRequest

@property (nonatomic, assign) BOOL switching;


- (void)startNotToggleWillStartTag;



@end

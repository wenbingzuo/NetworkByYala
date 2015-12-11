//
//  DZRequestManager.h
//  NetworkByYala
//
//  Created by 文兵 左 on 12/11/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZBaseRequest.h"

@interface DZRequestManager : NSObject

+ (instancetype)shareManager;

- (void)addRequest:(DZBaseRequest *)request;
- (void)cancelRequest:(DZBaseRequest *)request;

@end

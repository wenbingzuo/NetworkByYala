//
//  DZRequestManager.h
//  NetworkByYala
//
//  Created by 文兵 左 on 12/11/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZBaseRequest.h"

typedef NS_ENUM(NSInteger, DZRequestReachabilityStatus) {
    DZRequestReachabilityStatusUnknow = 0,
    DZRequestReachabilityStatusNotReachable,
    DZRequestReachabilityStatusViaWWAN,
    DZRequestReachabilityStatusViaWiFi
};

@interface DZRequestManager : NSObject

+ (instancetype)shareManager;

@property (nonatomic, assign, readonly) DZRequestReachabilityStatus reachabilityStatus;

- (void)startRequest:(DZBaseRequest *)request;
- (void)cancelRequest:(DZBaseRequest *)request;
- (void)cancelAllRequests;

// start monitor network status
- (void)startNetworkStateMonitoring;

@end

FOUNDATION_EXPORT NSString * const DZRequestOutOfNetwork;
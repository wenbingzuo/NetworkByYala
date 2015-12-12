//
//  DZBaseRequest.h
//  NetworkByYala
//
//  Created by 文兵 左 on 12/11/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DZBaseRequest;
typedef void(^DZRequestSuccessBlock)(DZBaseRequest *request);
typedef void(^DZRequestFailureBlock)(DZBaseRequest *request);

@interface DZBaseRequest : NSObject

@property (nonatomic, copy) DZRequestSuccessBlock requestSuccessBlock;
@property (nonatomic, copy) DZRequestFailureBlock requestFailureBlock;

- (NSString *)baseURL;
- (NSString *)extendedURL;
- (DZRequestMethod)requestMethod;
- (id)requestParameters;


@end

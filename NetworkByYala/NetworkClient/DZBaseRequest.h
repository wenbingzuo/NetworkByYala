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

@property (nonatomic, strong) NSURLSessionDataTask *task;

@property (nonatomic, copy) DZRequestSuccessBlock requestSuccessBlock;
@property (nonatomic, strong) id responseObject;

@property (nonatomic, copy) DZRequestFailureBlock requestFailureBlock;
@property (nonatomic, strong) NSError *error;

/**
 *  基类URL，可无
 *
 */
- (NSString *)baseURL;

/**
 *  请求的url
 *
 */
- (NSString *)requestURL;
- (DZRequestMethod)requestMethod;
- (id)requestParameters;
- (DZRequestSerializerType)requestSerializerType;


/**
 *  复写时需要调用super
 */
- (void)start;
- (void)stop;


- (void)clearRequestBlock;

@end

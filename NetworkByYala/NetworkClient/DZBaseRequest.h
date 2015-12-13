//
//  DZBaseRequest.h
//  NetworkByYala
//
//  Created by 文兵 左 on 12/11/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DZBaseRequest;
@protocol DZRequestDelegate <NSObject>

@optional
- (void)requestWillStart:(DZBaseRequest *)request;
- (void)requestDidSuccess:(DZBaseRequest *)request;
- (void)requestDidFailure:(DZBaseRequest *)request;

@end

typedef void(^DZConstructionBlock)(id <AFMultipartFormData> formData);

@interface DZBaseRequest : NSObject

@property (nonatomic, strong) NSURLSessionDataTask *task;

//------------------处理返回值的方式----------------------
// block
@property (nonatomic, copy) void(^requestStartBlock)(DZBaseRequest *);

@property (nonatomic, copy) void(^requestSuccessBlock)(DZBaseRequest *);
@property (nonatomic, strong) id responseObject;

@property (nonatomic, copy) void(^requestFailureBlock)(DZBaseRequest *);
@property (nonatomic, strong) NSError *error;

// delegate
@property (nonatomic, weak) id <DZRequestDelegate> delegate;

//-----------------------------------------------------


/**
 *  overrate to custom request
 *
 */
// default is `DZ_ENVIRONMENT`, `DZ_ENVIRONMENT` configured in config.h, or overrate to support special base
- (NSString *)baseURL;

// default is ``
- (NSString *)requestURL;

// default is `DZRequestMethodGET`
- (DZRequestMethod)requestMethod;

// default is `nil`
- (id)requestParameters;

// default is `DZRequestSerializerTypeJSON`
- (DZRequestSerializerType)requestSerializerType;

// default is `DZResponseSerializerTypeJSON`
- (DZResponseSerializerType)responseSerializerType;

// default is `YES`
- (BOOL)useCookies;

// POST request overrate to upload such as images, default `nil`
- (DZConstructionBlock)constructionBodyBlock;


/**
 *  if overrate, call super
 */
- (void)start;
- (void)startWithRequestSuccessBlock:(void(^)(DZBaseRequest *request))success failureBlock:(void(^)(DZBaseRequest *request))failure;
- (void)stop;


- (void)clearRequestBlock;


@end

/**
 *  通知
 */
FOUNDATION_EXPORT NSString * const DZRequestWillStartNotification;
FOUNDATION_EXPORT NSString * const DZRequestDidFinishNotification;

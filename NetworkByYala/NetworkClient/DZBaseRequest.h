//
//  DZBaseRequest.h
//  NetworkByYala
//
//  Created by 文兵 左 on 12/11/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZRequestConfig.h"

/**
 *  HTTP request method
 */
typedef NS_ENUM(NSInteger, DZRequestMethod) {

    DZRequestMethodGET = 0,

    DZRequestMethodPOST,

    DZRequestMethodPUT,

    DZRequestMethodDELETE
};

/**
 *  request serializer type
 */
typedef NS_ENUM(NSInteger, DZRequestSerializerType) {
    /**
     *  content-type: application/x-www-form-urlencoded
     */
    DZRequestSerializerTypeForm = 0,
    /**
     *  content-type: application/json
     */
    DZRequestSerializerTypeJSON
};

/**
 *  response serializer type
 */
typedef NS_ENUM(NSInteger, DZResponseSerializerType) {
    /**
     *  JSON from server
     */
    DZResponseSerializerTypeJSON = 0,
    /**
     *  XML from server
     */
    DZResponseSerializerTypeXML
};

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
 *  overwrite to custom request
 *
 */
// default is `DZ_ENVIRONMENT`, `DZ_ENVIRONMENT` configured in config.h, or overwrite to support special base
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

// POST request overwrite to upload such as images, default `nil`
- (DZConstructionBlock)constructionBodyBlock;

// toggle when request success
- (void)requestCompleteSuccess;

/**
 *  if overwrite, call super
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

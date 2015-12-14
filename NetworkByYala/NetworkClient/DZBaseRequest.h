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
     *  content-type: application/x-www-form-urlencoded not json type
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
     *  get the origin data from server
     */
    DZResponseSerializerTypeHTTP= 0,
    /**
     *  JSON from server
     */
    DZResponseSerializerTypeJSON
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
 *  custom properties
 *
 */
// default is `DZ_ENVIRONMENT`, `DZ_ENVIRONMENT` configured in config.h, or set special value
@property (nonatomic, copy) NSString *baseURL;

// default is ``
@property (nonatomic, copy) NSString *requestURL;

// default is `DZRequestMethodGET`
@property (nonatomic, assign) DZRequestMethod requestMethod;

// default is `nil`
@property (nonatomic, strong) id requestParameters;

// default is `DZRequestSerializerTypeJSON`
@property (nonatomic, assign) DZRequestSerializerType requestSerializerType;

// default is `DZResponseSerializerTypeJSON`
@property (nonatomic, assign) DZResponseSerializerType responseSerializerType;

// default is `YES`
@property (nonatomic, assign) BOOL useCookies;

// POST upload request such as images, default `nil`
@property (nonatomic, copy) DZConstructionBlock constructionBodyBlock;

/**
 *  if overwrite, call super
 */
- (void)start;
- (void)startWithRequestSuccessBlock:(void(^)(DZBaseRequest *request))success failureBlock:(void(^)(DZBaseRequest *request))failure;
- (void)stop;


// toggle when request success
- (void)requestCompleteSuccess;

// set `requestStartBlock`, `requestSuccessBlock`, `requestFailureBlock` to nil
- (void)clearRequestBlock;


@end

/**
 *  通知
 */
FOUNDATION_EXPORT NSString * const DZRequestWillStartNotification;
FOUNDATION_EXPORT NSString * const DZRequestDidFinishNotification;

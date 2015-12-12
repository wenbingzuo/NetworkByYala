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
- (void)requestDidSuccess:(DZBaseRequest *)request;
- (void)requestDidFailure:(DZBaseRequest *)request;

@end

@interface DZBaseRequest : NSObject

@property (nonatomic, strong) NSURLSessionDataTask *task;

//------------------处理返回值的方式----------------------
// block
@property (nonatomic, copy) void(^requestSuccessBlock)(DZBaseRequest *);
@property (nonatomic, strong) id responseObject;

@property (nonatomic, copy) void(^requestFailureBlock)(DZBaseRequest *);
@property (nonatomic, strong) NSError *error;

// delegate
@property (nonatomic, weak) id <DZRequestDelegate> delegate;


//-----------------------------------------------------


//--------------子类可复写的方法------------------
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
- (BOOL)useCookies;
//---------------------------------


/**
 *  复写时需要调用super
 */
- (void)start;
- (void)stop;


- (void)clearRequestBlock;


@end

/**
 *  通知
 */
FOUNDATION_EXPORT NSString * const DZRequestDidStartNotification;
FOUNDATION_EXPORT NSString * const DZRequestDidFinishNotification;

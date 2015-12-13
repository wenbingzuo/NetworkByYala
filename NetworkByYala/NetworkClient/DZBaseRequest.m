//
//  DZBaseRequest.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/11/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DZBaseRequest.h"
#import "DZRequestConfig.h"
#import "DZRequestManager.h"

NSString * const DZRequestWillStartNotification = @"com.forever.HTTP.request.start";
NSString * const DZRequestDidFinishNotification = @"com.forever.HTTP.request.finish";

@implementation DZBaseRequest

- (DZConstructionBlock)constructionBodyBlock {
    return nil;
}

- (NSString *)baseURL {
    return DZ_ENVIRONMENT;
}

- (DZRequestMethod)requestMethod {
    return DZRequestMethodGET;
}

- (NSString *)requestURL {
    return @"";
}

- (id)requestParameters {
    return nil;
}

- (BOOL)useCookies {
    return YES;
}

- (DZRequestSerializerType)requestSerializerType {
    return DZRequestSerializerTypeJSON;
}

- (DZResponseSerializerType)responseSerializerType {
    return DZResponseSerializerTypeJSON;
}

- (void)start {
    [self requestWillStartTag];
    [[DZRequestManager shareManager] startRequest:self];
}

- (void)startWithRequestSuccessBlock:(void(^)(DZBaseRequest *request))success failureBlock:(void(^)(DZBaseRequest *request))failure {
    [self setRequestSuccessBlock:success failureBlock:failure];
    [self start];
}

- (void)setRequestSuccessBlock:(void(^)(DZBaseRequest *request))success failureBlock:(void(^)(DZBaseRequest *request))failure {
    self.requestSuccessBlock = success;
    self.requestFailureBlock = failure;
}

- (void)stop {
    [[DZRequestManager shareManager] cancelRequest:self];
}

- (void)dealloc {
    DZDebugLog(@"%@ dealloc", [self class]);
}

- (void)clearRequestBlock {
    self.requestSuccessBlock = nil;
    self.requestFailureBlock = nil;
}

#pragma mark - Private
- (void)requestWillStartTag {
    if (self.requestStartBlock) {
        self.requestStartBlock(self);
    }
    
    if ([self.delegate respondsToSelector:@selector(requestWillStart:)]) {
        [self.delegate requestWillStart:self];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:DZRequestWillStartNotification object:self];
    });
}

@end

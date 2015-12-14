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

- (instancetype)init {
    self = [super init];
    if (self) {
        self.baseURL = DZ_ENVIRONMENT;
        self.requestURL = @"";
        self.requestTimeoutInterval = 20;
        self.requestMethod = DZRequestMethodGET;
        self.requestParameters = nil;
        self.requestSerializerType = DZRequestSerializerTypeJSON;
        self.responseSerializerType = DZResponseSerializerTypeJSON;
        self.useCookies = YES;
        self.constructionBodyBlock = nil;
    }
    return self;
}

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

- (void)requestCompleteSuccess {
    
}

- (void)clearRequestBlock {
    self.requestStartBlock = nil;
    self.requestSuccessBlock = nil;
    self.requestFailureBlock = nil;
}

- (void)dealloc {
    DZDebugLog(@"%@ dealloc", [self class]);
}
@end

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

NSString * const DZRequestWillStartNotification = @"com.forever.request.start";
NSString * const DZRequestDidFinishNotification = @"com.forever.request.finish";

@interface DZBaseRequest ()

@property (nonatomic, assign) BOOL requesting;

@end

@implementation DZBaseRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requesting = NO;
        self.requestBaseURL = DZ_ENVIRONMENT;
        self.requestURL = @"";
        self.requestTimeoutInterval = 20;
        self.requestMethod = DZRequestMethodGET;
        self.requestParameters = nil;
        self.requestSerializerType = DZRequestSerializerTypeJSON;
        self.responseSerializerType = DZResponseSerializerTypeJSON;
        self.useCookies = YES;
        self.constructionBodyBlock = nil;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestWillStartNotification:) name:DZRequestWillStartNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestDidFinishNotification:) name:DZRequestDidFinishNotification object:nil];
    }
    return self;
}

- (void)requestWillStartNotification:(NSNotification *)notification {
    if (notification.object == self) {
        self.requesting = YES;
    }
}

- (void)requestDidFinishNotification:(NSNotification *)notification {
    if (notification.object == self) {
        self.requesting = NO;
    }
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
    
    [self requestWillStart];
}

- (void)start {
    if (self.requesting) {
        return;
    }
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

- (void)requestWillStart {
    
}

- (void)requestCompleteSuccess {
    
}

- (void)requestCompleteFailure {
    
}

//- (void)clearRequestBlock {
//    self.requestStartBlock = nil;
//    self.requestSuccessBlock = nil;
//    self.requestFailureBlock = nil;
//    self.uploadProgress = nil;
//}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DZDebugLog(@"%@ dealloc", [self class]);
}
@end

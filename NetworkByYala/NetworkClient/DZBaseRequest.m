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

NSString * const DZRequestDidFinishNotification = @"com.forever.HTTP.request.finish";
NSString * const DZRequestDidStartNotification = @"com.forever.HTTP.request.start";

@implementation DZBaseRequest

- (NSString *)baseURL {
    return DZ_ENVIRONMENT;
}

- (DZRequestMethod)requestMethod {
    return DZRequestMethodGet;
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

- (void)start {
    [[DZRequestManager shareManager] startRequest:self];
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

@end

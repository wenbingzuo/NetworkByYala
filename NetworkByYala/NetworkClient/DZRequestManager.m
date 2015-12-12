//
//  DZRequestManager.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/11/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DZRequestManager.h"
#import <AFNetworking.h>

@interface DZRequestManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation DZRequestManager

+ (instancetype)shareManager {
    static DZRequestManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - Private
- (instancetype)init {
    self = [super init];
    if (self) {
        self.sessionManager = [AFHTTPSessionManager manager];
    }
    return self;
}

- (NSString *)configRequestURL:(DZBaseRequest *)request {
    return @"";
}

- (void)handleReponseResult {
    
}

#pragma mark - Public
- (void)addRequest:(DZBaseRequest *)request {
    NSString *url = [self configRequestURL:request];
    
    id params = [request requestParameters];
    
    DZRequestMethod requestMethod = [request requestMethod];
    switch (requestMethod) {
        case DZRequestMethodGet:
        {
            
            [self.sessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
            break;
            
        default:
            break;
    }
    
}


@end

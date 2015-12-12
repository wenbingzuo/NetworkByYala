//
//  DZRequestManager.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/11/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DZRequestManager.h"
#import <AFNetworking.h>

#define DZ_HTTP_COOKIE_KEY @"DZHTTPCookieKey"

@interface DZRequestManager () <NSXMLParserDelegate>

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic, strong) NSMutableDictionary *requests;

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
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", @"application/json", nil];
        self.requests = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSString *)configRequestURL:(DZBaseRequest *)request {
    NSString *requestURL = [request requestURL];
    if ([requestURL hasPrefix:@"http"]) {
        return requestURL;
    }
    
    if ([[request baseURL] hasPrefix:@"http"]) {
        return [NSString stringWithFormat:@"%@%@", [request baseURL], [request requestURL]];
    } else {
        DZDebugLog(@"未配置好请求URL base: %@ requestURL: %@", [request baseURL], [request requestURL]);
        return @"";
    }
}

#pragma mark 处理返回数据
- (void)saveCookies {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [cookieStorage cookies];
    if (cookies.count > 0) {
        NSData *cookieData = [NSKeyedArchiver archivedDataWithRootObject:cookies];
        
        [[NSUserDefaults standardUserDefaults] setObject:cookieData forKey:DZ_HTTP_COOKIE_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)handleReponseResult:(NSURLSessionDataTask *)task response:(id)responseObject error:(NSError *)error{
    NSString *key = [self taskHashKey:task];
    DZBaseRequest *request = self.requests[key];
    
    // 使用cookie时需要保存cookie
    if ([request useCookies]) {
        [self saveCookies];
    }
    
    // block方式返回数据
    if (error) {
        if (request.requestFailureBlock) {
            request.error = error;
            request.requestFailureBlock(request);
        }
    } else {
        if (request.requestSuccessBlock) {
            request.responseObject = responseObject;
            request.requestSuccessBlock(request);
        }
    }
    [request clearRequestBlock];
    
    // 代理方式返回数据
    if (error) {
        if ([request.delegate respondsToSelector:@selector(requestDidFailure:)]) {
            [request.delegate requestDidFailure:request];
        }
    } else {
        if ([request.delegate respondsToSelector:@selector(requestDidSuccess:)]) {
            [request.delegate requestDidSuccess:request];
        }
    }
    
    // 发送完成通知
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:DZRequestDidFinishNotification object:request];
    });
    
    [self removeRequest:task];
}

- (NSString *)taskHashKey:(NSURLSessionDataTask *)task {
    return [NSString stringWithFormat:@"%lu", (unsigned long)[task hash]];
}

// 管理`request`的生命周期, 防止多线程处理同一key
- (void)addRequest:(DZBaseRequest *)request {
    if (request.task) {
        NSString *key = [self taskHashKey:request.task];
        @synchronized(self) {
            [self.requests setValue:request forKey:key];
        }
    }
}

- (void)removeRequest:(NSURLSessionDataTask *)task {
    NSString *key = [self taskHashKey:task];
    @synchronized(self) {
        [self.requests removeObjectForKey:key];
    }
}
#pragma mark - Public
- (void)startRequest:(DZBaseRequest *)request {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:DZRequestDidStartNotification object:request];
    });
    
    // 使用cookie
    if ([request useCookies]) {
        id cookieData = [[NSUserDefaults standardUserDefaults] objectForKey:DZ_HTTP_COOKIE_KEY];
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookieData];
        if ([cookies isKindOfClass:[NSArray class]] && cookies.count > 0) {
            NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (NSHTTPCookie *cookie in cookies) {
                [cookieStorage setCookie:cookie];
            }
        }
    }
    
    // 处理URL
    NSString *url = [self configRequestURL:request];
    
    // 处理参数
    id params = [request requestParameters];
    
    // 处理序列化类型
    DZRequestSerializerType requestSerializerType = [request requestSerializerType];
    switch (requestSerializerType) {
        case DZRequestSerializerTypeForm:
            self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case DZRequestSerializerTypeJSON:
            self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        default:
            break;
    }
    
    // 处理请求
    DZRequestMethod requestMethod = [request requestMethod];
    NSURLSessionDataTask *task = nil;
    switch (requestMethod) {
        case DZRequestMethodGet:
        {
            
            task = [self.sessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleReponseResult:task response:responseObject error:nil];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleReponseResult:task response:nil error:error];
            }];
        }
            break;
        
        case DZRequestMethodPost:
        {
            task = [self.sessionManager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleReponseResult:task response:responseObject error:nil];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleReponseResult:task response:nil error:error];
            }];
        }
            break;
            
        case DZRequestMethodPUT:
        {
            task = [self.sessionManager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleReponseResult:task response:responseObject error:nil];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleReponseResult:task response:nil error:error];
            }];
        }
            break;
        
        case DZRequestMethodDelete:
        {
            task = [self.sessionManager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleReponseResult:task response:responseObject error:nil];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleReponseResult:task response:nil error:error];
            }];
        }
            break;
        default:
            break;
    }
    
    request.task = task;
    [self addRequest:request];
}

- (void)cancelRequest:(DZBaseRequest *)request {
    [request.task cancel];
    [self removeRequest:request.task];
}

- (void)cancelAllRequests {
    for (NSString *key in self.requests) {
        DZBaseRequest *request = self.requests[key];
        [request stop];
    }
}

@end

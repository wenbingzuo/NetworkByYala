//
//  DZCacheRequest.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/13/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DZCacheRequest.h"
#import "DZRequestTool.h"

@interface DZCacheRequest ()

@property (nonatomic, strong) id cacheData;

@end

@implementation DZCacheRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.loadCache = YES;
        self.cacheTimeInterval = 60;
    }
    return self;
}

- (id)cacheData {
    if (!_cacheData) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *path = [self cacheFilePath];
        if ([fileManager fileExistsAtPath:path]) {
            _cacheData = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        }
    }
    return _cacheData;
}

- (void)createPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        DZDebugLog(@"error in creating cache folder:%@", error.localizedDescription);
    } else {
        [DZRequestTool addDoNotBackupAttribute:path];
    }
}

- (void)checkPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            if (error) {
                DZDebugLog(@"error in removing file：%@", error.localizedDescription);
            }
            [self createPath:path];
        }
    }
}

- (NSString *)cacheBasePath {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [cachePath stringByAppendingPathComponent:@"DZRequestCache"];
    
    [self checkPath:path];
    
    return path;
}

- (NSString *)cacheFileName {
    DZRequestMethod method = [self requestMethod];
    
    NSString *baseURL = [self baseURL];
    NSString *requestURL = [self requestURL];
    
    NSString *fileName = [NSString stringWithFormat:@"method-%d_host-%@_url:%@", method, baseURL, requestURL];
    
    return [DZRequestTool md5String:fileName];
}

- (NSString *)cacheFilePath {
    NSString *cacheBathPath = [self cacheBasePath];
    NSString *cacheFileName = [self cacheFileName];
    NSString *path = [cacheBathPath stringByAppendingPathComponent:cacheFileName];
    return path;
}

- (NSInteger)cacheFileTimeInterval:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSDictionary *attributes = [fileManager attributesOfItemAtPath:path error:&error];
    if (error) {
        return -1;
    }
    NSTimeInterval timeInterval = -[[attributes fileModificationDate] timeIntervalSinceNow];
    return timeInterval;
}

- (void)start {
    if (!self.loadCache) {
        [super start];
        return;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[self cacheFilePath]]) {
        [super start];
        return;
    }
    
    
    NSTimeInterval fileTimeInterval = [self cacheFileTimeInterval:[self cacheFilePath]];
    NSTimeInterval cacheTimeInterval = self.cacheTimeInterval;
    if (cacheTimeInterval <= 0 || cacheTimeInterval < fileTimeInterval) {
        [super start];
        return;
    }
    
    [self requestDidFinishTag];
}

- (void)requestDidFinishTag {
    self.responseObject = self.cacheData;
    
    if (self.error) {
        if (self.requestFailureBlock) {
            self.requestFailureBlock(self);
        }
        
        if ([self.delegate respondsToSelector:@selector(requestDidFailure:)]) {
            [self.delegate requestDidFailure:self];
        }
    } else {
        if (self.requestSuccessBlock) {
            self.requestSuccessBlock(self);
        }
        
        if ([self.delegate respondsToSelector:@selector(requestDidSuccess:)]) {
            [self.delegate requestDidSuccess:self];
        }
    }
    [self clearRequestBlock];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:DZRequestDidFinishNotification object:self];
    });

}

- (void)saveData:(id)responseObject {
    if (responseObject) {
        [NSKeyedArchiver archiveRootObject:responseObject toFile:[self cacheFilePath]];
    }
}

- (void)requestCompleteSuccess {
    [super requestCompleteSuccess];
    [self saveData:self.responseObject];
}

@end

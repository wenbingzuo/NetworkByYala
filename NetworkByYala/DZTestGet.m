//
//  DZTestGet.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/12/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DZTestGet.h"

@implementation DZTestGet

- (id)requestParameters {
    return @{@"filter":@"default"};
}

- (NSString *)baseURL {
    return  @"https://api.menke.joinmind.cn";
}

- (NSString *)requestURL {
    return @"/v1/feed/circle";
}

@end

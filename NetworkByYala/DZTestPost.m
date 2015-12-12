//
//  DZTestPost.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/12/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DZTestPost.h"

@implementation DZTestPost
- (NSString *)baseURL {
    return  @"https://api-menke.dev.joinmind.org";
}

- (NSString *)requestURL {
    return @"/v1/user/login";
}

- (id)requestParameters {
    return @{@"phone":@"17710280827", @"password":@"123456"};
//    return @"123";
}

- (DZRequestMethod)requestMethod {
    return DZRequestMethodPOST;
}

- (DZRequestSerializerType)requestSerializerType {
    return DZRequestSerializerTypeJSON;
}
@end

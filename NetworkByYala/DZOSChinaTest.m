//
//  DZOSChinaTest.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/12/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DZOSChinaTest.h"

@implementation DZOSChinaTest

- (NSString *)requestURL {
    return @"http://www.oschina.net/action/api/login_validate";
}

- (id)requestParameters {
    return @{@"username":@"Jaly201319@gmail.com", @"pwd":@"Yala1990v587"};
}

- (DZRequestMethod)requestMethod {
    return DZRequestMethodPOST;
}

- (DZRequestSerializerType)requestSerializerType {
    return DZRequestSerializerTypeForm;
}

@end

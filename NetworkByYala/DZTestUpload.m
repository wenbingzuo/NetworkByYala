//
//  DZTestUpload.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/12/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DZTestUpload.h"

@implementation DZTestUpload

- (NSString *)baseURL {
    return @"https://api-menke.dev.joinmind.org";
}

- (NSString *)requestURL {
    return @"/v1/misc/uploadImage/tweet";
}

- (DZRequestMethod)requestMethod {
    return DZRequestMethodPOST;
}

- (DZConstructionBlock)constructionBodyBlock {
    return ^(id <AFMultipartFormData> formData) {
        UIImage *image = [UIImage imageNamed:@"images.jpeg"];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        [formData appendPartWithFileData:imageData name:@"data" fileName:@"data" mimeType:@"image/jpeg"];
    };
}


@end

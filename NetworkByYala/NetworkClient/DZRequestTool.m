//
//  DZRequestTool.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/12/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DZRequestTool.h"

@implementation DZRequestTool

+ (BOOL)validateUrl:(NSString *)url {
    NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:url];
}

+ (BOOL)validateJSON:(id)json {
    if ([json isKindOfClass:[NSDictionary class]] || [json isKindOfClass:[NSArray class]]) {
        return YES;
    } else {
        return NO;
    }
                            
}

@end

//
//  DZRequestTool.h
//  NetworkByYala
//
//  Created by 文兵 左 on 12/12/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZRequestTool : NSObject

+ (BOOL)validateUrl:(NSString *)url;

+ (BOOL)validateJSON:(id)json;

@end
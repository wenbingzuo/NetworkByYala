//
//  DZRequestTool.h
//  NetworkByYala
//
//  Created by 文兵 左 on 12/12/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZRequestConfig.h"

@interface DZRequestTool : NSObject

+ (BOOL)validateUrl:(NSString *)url;

+ (NSString *)md5String:(NSString *)string;

+ (void)addDoNotBackupAttribute:(NSString *)path;

@end

//
//  YTHttpTool.h
//  ehero
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTHttpTool : NSObject

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;


@end

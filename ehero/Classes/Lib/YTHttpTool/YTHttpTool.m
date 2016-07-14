//
//  YTHttpTool.m
//  ehero
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "YTHttpTool.h"
#import "AFNetworking.h"
@implementation YTHttpTool

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 获取http请求管理者
   AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
   // 发送请求
   [session GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
       
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       if (success) {
           success(responseObject);
           }
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            }
   }];
    
    
    
}




@end

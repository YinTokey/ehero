//
//  YTHttpTool.m
//  ehero
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "YTHttpTool.h"
#import  "MBProgressHUD+YT.h"
@implementation YTHttpTool
// failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task ,id responseObj))success failure:(void (^)(NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3.发送GET请求
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {       
            success(task,responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task ,id responseObj))success failure:(void (^)(NSError *error))failure{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3.设置超时时间为10s
    mgr.requestSerializer.timeoutInterval = 10;
    // 4.发送POST请求
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)netCheck{
    //__block BOOL _netStatus ;
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status==AFNetworkReachabilityStatusReachableViaWiFi ||status==AFNetworkReachabilityStatusReachableViaWWAN) {
            NSLog(@"可以联网");
           // _netStatus = YES;
        }else if(status==AFNetworkReachabilityStatusNotReachable){
            [MBProgressHUD showError:@"检查网络连接"];
           // _netStatus = NO;
        }else{
            NSLog(@"未知网络");
        }
    }];
    [mgr.reachabilityManager startMonitoring];

}




@end

//
//  YTHttpTool.h
//  ehero
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef NS_ENUM(NSInteger, YTHttpRequestType)
{
    YTHttpRequestTypeGet,
    YTHttpRequestTypePost,
};

@interface YTHttpTool : NSObject



/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
//+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task ,id responseObj))success failure:(void (^)(NSError *error))failure;
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task ,id responseObj))success failure:(void (^)(NSError *error))failure;
/**
 *  联网状态监测
 */
+ (void)netCheck;
@property (nonatomic,assign)BOOL netStatus;

@end

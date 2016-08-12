//
//  EHNetBusinessManager.m
//  ehero
//
//  Created by Mac on 16/7/19.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHNetBusinessManager.h"
#import <MJExtension.h>
static EHNetBusinessManager *_manager;

@interface EHNetBusinessManager()

@property (nonatomic,copy) NSString *identifier;

@end


@implementation EHNetBusinessManager

+ (instancetype)businessManager {
    
    _manager = [[self alloc]init];
    return _manager;
}

+ (void)requestBusinessAction:(NSString *)action
                byRequestType:(YTHttpRequestType)requestType
                andParameters:(NSDictionary *)params
          andCallbackDelegate:(id)deleage
                  andDataType:(Class)dataClass andIdentifier:(NSString *)identifier;
{
    EHNetBusinessManager *manager = [self businessManager];
    manager.identifier = identifier;
    [manager requestBusinessAction:action byRequestType:requestType andParameters:params andCallbackDelegate:deleage andDataType:dataClass];
    
}

#pragma  - mark Call YTHttpTool
- (void)requestBusinessAction:(NSString *)action
                byRequestType:(YTHttpRequestType)requestType
                andParameters:(NSDictionary *)params
          andCallbackDelegate:(id)deleage
                  andDataType:(Class)dataClass
{
   // self.delegate = self;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",EheroHOST,action];
    
    [self logRequestUrlWithAction:action andParams:params];
    
    switch (requestType) {
        case YTHttpRequestTypeGet:
            [self get:urlStr params:params dataType:dataClass forAction:action];
            break;
        case YTHttpRequestTypePost:
            [self post:urlStr params:params dataType:dataClass forAction:action];
            break;
        default:
            NSLog(@"requestTyep unSupported!");
            break;
    }

}

#pragma mark - 整合网络请求和字典转模型
- (void)get:(NSString *)urlStr params:(NSDictionary *)params dataType:(Class)dataClass forAction:action
{
    [YTHttpTool get:urlStr params:params success:^(NSURLSessionTask *task, id responseObj) {
        if ([self.delegate respondsToSelector:@selector(EHNetBusinessDataFetchedSuccess:forAction:andIdentifier:)]) {
            
            if (dataClass) {
                if ([responseObj isKindOfClass:[NSDictionary class]]) {
                    [self.delegate EHNetBusinessDataFetchedSuccess:[dataClass mj_objectArrayWithKeyValuesArray:responseObj] forAction:action andIdentifier:self.identifier];
                }else
                {
                    [self.delegate EHNetBusinessDataFetchedSuccess:[dataClass mj_objectArrayWithKeyValuesArray:responseObj] forAction:action andIdentifier:self.identifier];
                }            }else
                {
                    [self.delegate EHNetBusinessDataFetchedSuccess:responseObj forAction:action andIdentifier:self.identifier];
                    
                }    
        }

    } failure:^(NSError *error) {
        if ([self.delegate respondsToSelector:@selector(EHNetBusinessDataFetchedError:forAction:andIdentifier:)]) {
            [self.delegate EHNetBusinessDataFetchedError:error forAction:action andIdentifier:self.identifier];
        }
    }];
}
#pragma mark - post
- (void)post:(NSString *)urlStr params:(NSDictionary *)params dataType:(Class)dataClass forAction:action
{
    [YTHttpTool post:urlStr params:params success:^(NSURLSessionDataTask *task,id responseObj) {
        if ([self.delegate respondsToSelector:@selector(EHNetBusinessDataFetchedSuccess:forAction:andIdentifier:)]) {
            
            if (dataClass) {
                if ([responseObj isKindOfClass:[NSDictionary class]]) {
                    [self.delegate EHNetBusinessDataFetchedSuccess:[dataClass mj_objectWithKeyValues:responseObj] forAction:action andIdentifier:self.identifier];
                }else
                {
                    [self.delegate EHNetBusinessDataFetchedSuccess:[dataClass mj_objectArrayWithKeyValuesArray:responseObj] forAction:action andIdentifier:self.identifier];
                }            }else
                {
                    [self.delegate EHNetBusinessDataFetchedSuccess:responseObj forAction:action andIdentifier:self.identifier];
                    
                }
            
        }
        
    } failure:^(NSError *error) {
        if ([self.delegate respondsToSelector:@selector(EHNetBusinessDataFetchedError:forAction:andIdentifier:)]) {
            [self.delegate EHNetBusinessDataFetchedError:error forAction:action andIdentifier:self.identifier];
        }
    }];


}

#pragma - mark selfMethod
- (void)logRequestUrlWithAction:(NSString *)action andParams:(NSDictionary *)params
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",EheroHOST,action];
    NSArray *allkeys = [params allKeys];
    NSMutableString *paramsString = [NSMutableString string];
    for (int i=0; i<allkeys.count; i++) {
        NSString *key = [allkeys objectAtIndex:i];
        NSString *value = [params objectForKey:key];
        if (i == allkeys.count-1) {
            [paramsString appendFormat:@"%@=%@",key,value];
        }else{
            [paramsString appendFormat:@"%@=%@&",key,value];
        }
    }
    
    if (paramsString.length > 0) {
        urlStr = [urlStr stringByAppendingString:paramsString];
    }
    NSLog(@"请求地址为:%@",urlStr);
}



@end

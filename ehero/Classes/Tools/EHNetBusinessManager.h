//
//  EHNetBusinessManager.h
//  ehero
//
//  Created by Mac on 16/7/19.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EHNetBusinessManagerDelegate <NSObject>
@required
/**< 返回业务数据信息成功  */
- (void)EHNetBusinessDataFetchedSuccess:(id)data forAction:(NSString *)action andIdentifier:(NSString *)identifier;

/**< 返回业务数据信息失败  */
- (void)EHNetBusinessDataFetchedError:(NSError *)error forAction:(NSString *)action andIdentifier:(NSString *)identifier;


@end


@interface EHNetBusinessManager : NSObject
@property (nonatomic,strong) id<EHNetBusinessManagerDelegate> delegate;

/**
 *  **< 请求业务数据
 *  @param action    MoudleUrl
 *  @param requestType   请求类型 get or post
 *  @param params    参数
 *  @param deleage   回调接受者
 *  @param className 返回的数据解析类型(基于MJExtension),nil表示返回字典,否则返回class对应的模型
 */
+ (void)requestBusinessAction:(NSString *)action
                byRequestType:(YTHttpRequestType)requestType
                andParameters:(NSDictionary *)params
          andCallbackDelegate:(id)deleage
                  andDataType:(Class)dataClass andIdentifier:(NSString *)identifier;

@end

//
//  EHAgentInfoNetViewModel.m
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoNetViewModel.h"
#import <MJExtension.h>
@implementation EHAgentInfoNetViewModel

- (void)callAgentWithIdStr:(NSString *)idStr
                      code:(NSString *)code
                   success:(void(^)())success
                   failure:(void (^)())failure{
    NSDictionary *param = @{@"from":[[NSUserDefaults standardUserDefaults]objectForKey:@"userPhoneNumber"],
                            @"id":idStr,
                            @"code":code
                            };
    //[MBProgressHUD showMessage:@"正在接通电话中..."];
    [YTHttpTool post:callAgentUrlStr params:param success:^(NSURLSessionDataTask *task, id responseObj) {
        NSLog(@"接通成功  %@",responseObj);
        success();
    } failure:^(NSError *error) {
        failure();
       // [modal hide:YES];
        [MBProgressHUD hideHUDForView:_superVC.view];
        [MBProgressHUD showError:@"拨打失败" toView:_superVC.view];
        NSLog(@"failed %@",error);
    }];
    
}

- (void)getAverageInfo:(void(^)(EHAverageInfo *averageInfo))success{
    [LBProgressHUD showHUDto:_superVC.view animated:NO];
    [YTHttpTool get:averageUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObj) {

        NSDictionary *dicObj  = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil] ;
        EHAverageInfo *averageInfo = [EHAverageInfo mj_objectWithKeyValues:dicObj];
        [LBProgressHUD hideAllHUDsForView:_superVC.view animated:NO];
        if(success){
        success(averageInfo);
     //   NSLog(@"lianjia %f",averageInfo.lianjia_rates_avg );
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"获取数据失败" toView:_superVC.view];
        NSLog(@"获取平均数值失败");
    }];
}

- (void)getAgentInfo:(NSString *)name
             success:(void(^)(NSArray *resultArray))success
             failure:(void(^)())failure{
  //  [LBProgressHUD showHUDto:_superVC.view animated:NO];
    NSDictionary *param = @{@"major":@"agents",
                            @"arg":name};
    [YTHttpTool post:searchAreaUrlStr
              params:param
             success:^(NSURLSessionDataTask *task, id responseObj) {
                 NSArray *resultArr = [EHAgentInfo mj_objectArrayWithKeyValuesArray:responseObj];
                // EHAgentInfo *info = [resultArr firstObject];
                 if (success) {
                     success(resultArr);
                 }
               //  [LBProgressHUD hideAllHUDsForView:_superVC.view animated:NO];
                // [MBProgressHUD showSuccess:@"" toView:_superVC.view];
              } failure:^(NSError *error) {
                //  [LBProgressHUD hideAllHUDsForView:_superVC.view animated:NO];
                  [MBProgressHUD showError:@"获取新数据失败" toView:_superVC.view];
              }];

}

@end

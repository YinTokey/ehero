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

- (void)callAgentWithIdStr:(NSString *)idStr code:(NSString *)code failure:(void (^)())failure{
    NSDictionary *param = @{@"from":[[NSUserDefaults standardUserDefaults]objectForKey:@"userPhoneNumber"],
                            @"id":idStr,
                            @"code":code
                            };
    [MBProgressHUD showMessage:@"正在接通电话中..."];
    [YTHttpTool post:callAgentUrlStr params:param success:^(NSURLSessionDataTask *task, id responseObj) {
        NSLog(@"接通成功  %@",responseObj);
        
    } failure:^(NSError *error) {
        failure();
       // [modal hide:YES];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"拨打失败"];
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
        NSLog(@"lianjia %f",averageInfo.lianjia_rates_avg );
        }
    } failure:^(NSError *error) {
        NSLog(@"获取平均数值失败");
    }];
}

@end

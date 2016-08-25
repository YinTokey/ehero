//
//  EHAgentInfoNetViewModel.m
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoNetViewModel.h"

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

@end

//
//  EHAntiDisturbNetViewModel.m
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAntiDisturbNetViewModel.h"

@implementation EHAntiDisturbNetViewModel

- (void)callAgentWithPhoneText:(NSString *)phoneText super:(UIViewController *)superVC code:(NSString *)code{

    NSDictionary *helper =  @{@"from":[[NSUserDefaults standardUserDefaults]objectForKey:@"userPhoneNumber"],
                              @"code":code,
                              @"to":phoneText};
    
    NSDictionary *param = @{@"helper":helper};
    
    [MBProgressHUD showMessage:@"正在接通电话中..." toView:superVC.view];
    [YTHttpTool post:anti_disturbCallUrlStr params:param success:^(NSURLSessionDataTask *task,id responseObj) {
        NSLog(@"呼叫成功 %@",responseObj);
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:superVC.view];
        [MBProgressHUD showError:@"呼叫失败"];
        NSLog(@"呼叫失败 %@",error);
    }];

}

@end

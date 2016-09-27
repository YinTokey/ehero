//
//  EHCommentAgentNetViewModel.m
//  ehero
//
//  Created by Mac on 16/8/29.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommentAgentNetViewModel.h"
#import "EHAgentInfo.h"
#import <MJExtension.h>

@implementation EHCommentAgentNetViewModel

- (void)submitWithText:(NSString *)text
                  Kind:(NSString *)commentKind
                 idStr:(NSString *)idStr
             community:(NSString *)community
             superVC:(UIViewController *)superVC
{
    NSDictionary *comment = @{@"author":[[NSUserDefaults standardUserDefaults]objectForKey:@"userPhoneNumber"],
                              @"community":community,
                              @"kind":commentKind,
                              @"text":text};

    NSDictionary *param = @{@"agent_id":idStr,
                            @"comment":comment};
    [LBProgressHUD showHUDto:superVC.view animated:NO];
    [YTHttpTool post:commentAgentUrlStr params:param  success:^(NSURLSessionDataTask *task,id responseObj) {
        NSLog(@"success %@",responseObj);
        NSString *responStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
        NSLog(@"responString %@",responStr);
        [LBProgressHUD hideAllHUDsForView:superVC.view animated:YES];
        [MBProgressHUD showSuccess:@"评论成功" toView:superVC.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [superVC.navigationController popViewControllerAnimated:YES];
        });
        
    } failure:^(NSError *error) {
        [LBProgressHUD hideAllHUDsForView:superVC.view animated:YES];
        [MBProgressHUD showSuccess:@"评论失败" toView:superVC.view];
        NSLog(@"failed %@",error);
    }];

}

- (void)searchWithURLString:(NSString *)urlString
                      Param:(NSDictionary *)param
                  superView:(UIView *)superView
                    success:(void(^)())success
                    failure:(void(^)())failure
{
    
    [YTHttpTool post:urlString params:param success:^(NSURLSessionTask *task,id responseObj) {
        //json转模型
        self.searchResultArr = [EHAgentInfo mj_objectArrayWithKeyValuesArray:responseObj];
        //如果找到经纪人，则取消控件的隐藏
        [LBProgressHUD hideAllHUDsForView:superView animated:NO];
        if (_searchResultArr.count > 0) {
            [MBProgressHUD showSuccess:@"为您找到经纪人" toView:superView];
            success();
        }else{
            [MBProgressHUD showError:@"没有找到经纪人" toView:superView];
            failure();
        }

    } failure:^(NSError *error) {
        [LBProgressHUD hideAllHUDsForView:superView animated:NO];
        [MBProgressHUD showSuccess:@"没有找到经纪人" toView:superView];
        NSLog(@"失败");
    }];
}


@end

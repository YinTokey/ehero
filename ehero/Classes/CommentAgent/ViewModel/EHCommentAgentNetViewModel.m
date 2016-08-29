//
//  EHCommentAgentNetViewModel.m
//  ehero
//
//  Created by Mac on 16/8/29.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommentAgentNetViewModel.h"

@implementation EHCommentAgentNetViewModel

- (void)submitWithText:(NSString *)text
                  Kind:(NSString *)commentKind
                 idStr:(NSString *)idStr
             superView:(UIView *)superView
{
    NSDictionary *comment = @{@"author":[[NSUserDefaults standardUserDefaults]objectForKey:@"userPhoneNumber"],
                              @"kind":commentKind,
                              @"text":text};
    
//    EHAgentInfo *agentInfo = [self.searchResultArr firstObject];
//    [agentInfo getIdStringFromDictionary];
    NSDictionary *param = @{@"agent_id":idStr,
                            @"comment":comment};
    
    [YTHttpTool post:commentAgentUrlStr params:param  success:^(NSURLSessionDataTask *task,id responseObj) {
        NSLog(@"success %@",responseObj);
        NSString *responStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
        NSLog(@"responString %@",responStr);
        [MBProgressHUD showSuccess:@"评论成功" toView:superView];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"评论失败" toView:superView];
        NSLog(@"failed %@",error);
    }];

}



@end

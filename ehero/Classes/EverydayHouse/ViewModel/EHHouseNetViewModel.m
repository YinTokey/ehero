//
//  EHHouseNetViewModel.m
//  易房好介
//
//  Created by Mac on 16/9/27.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHouseNetViewModel.h"

@implementation EHHouseNetViewModel

# pragma mark - 搜索方法
//- (void)searchWithURLString:(NSString *)urlString Param:(NSDictionary *)param{
//    
//    [YTHttpTool post:urlString params:param success:^(NSURLSessionTask *task, id responseObj) {
//        //json转模型
//        self.searchResultArr = [EHAgentInfo mj_objectArrayWithKeyValuesArray:responseObj];
//        [self searchStatusTest];
//        [LBProgressHUD hideAllHUDsForView:_superVC.view animated:NO];
//    } failure:^(NSError *error) {
//        [LBProgressHUD hideAllHUDsForView:_superVC.view animated:NO];
//        [MBProgressHUD showError:@"请求数据失败"];
//        NSLog(@"失败");
//    }];
//}

#pragma mark - 搜索结果检测
- (void)searchStatusTest{
    
    if (_searchResultArr.count == 0) {
        [MBProgressHUD showError:@"没有找到房源"];
    }else{
        [MBProgressHUD showSuccess:@"为您找到房源"];
    }
    
}


@end

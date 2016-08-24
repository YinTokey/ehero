//
//  EHSearchTableViewModel.m
//  ehero
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSearchTableViewModel.h"
#import <MJExtension.h>
#import "EHSearchResultCell.h"
#import "EHAgentInfoController.h"
#import "EHSearchViewController.h"
@implementation EHSearchTableViewModel


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _searchResultArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EHSearchResultCell *cell = [EHSearchResultCell searchResultCellWithTableView:tableView];
    EHAgentInfo *agentInfo = self.searchResultArr[indexPath.row];
    cell.isdrawRect = YES;
    [cell setResultCell:agentInfo];
    return cell;
}

-(void)agentInfoVCWithIndexPath:(NSIndexPath *)indexPath WithViewController:(UIViewController *)superController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    EHAgentInfoController *agentInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"AgentInfoController"];
    
    EHAgentInfo *agentInfo = self.searchResultArr[indexPath.row];
    [agentInfo getIdStringFromDictionary];
    
    agentInfoVC.agentInfo = agentInfo;
    [superController.navigationController pushViewController:agentInfoVC animated:YES];
}


# pragma mark - 搜索方法
- (void)searchWithURLString:(NSString *)urlString Param:(NSDictionary *)param{
    
    [YTHttpTool get:urlString params:param success:^(NSURLSessionTask *task, id responseObj) {
        //json转模型
        self.searchResultArr = [EHAgentInfo mj_objectArrayWithKeyValuesArray:responseObj];
        [self searchStatusTest];
//        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
    
}
#pragma mark - 搜索结果检测
- (void)searchStatusTest{
    
    if (_searchResultArr.count == 0) {
        [MBProgressHUD showError:@"没有找到经纪人"];
    }else{
        [MBProgressHUD showSuccess:@"为您找到经纪人"];
    }
    
}


@end

//
//  EHCollectedAgentsViewController.m
//  ehero
//
//  Created by Mac on 16/8/2.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCollectedAgentsViewController.h"
#import "EHSearchResultCell.h"
#import "EHAgentInfo.h"
#import "EHAgentInfoController.h"

@interface EHCollectedAgentsViewController ()<EHSearchResultCellDelegate>

@property (nonatomic,strong) NSMutableArray *collectedAgentsArr;

@end

@implementation EHCollectedAgentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = RGB(241, 243, 245);
    self.title = @"收藏的经纪人";
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //跳转到下一界面的返回按钮样式
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];

}

- (void)viewWillAppear:(BOOL)animated{
    //从数据库获取数据
    self.collectedAgentsArr = [NSMutableArray arrayWithArray:[EHAgentInfo findAll]];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _collectedAgentsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    EHSearchResultCell *cell = [EHSearchResultCell searchResultCellWithTableView:tableView];
    EHAgentInfo *agentInfo = self.collectedAgentsArr[indexPath.row];
    cell.isdrawRect = YES;
    [cell setResultCell:agentInfo];
    cell.delegate = self;
    return cell;
}
#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

#pragma mark - 选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EHAgentInfoController *agentInfoVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"AgentInfoController"];
    EHAgentInfo *agentInfo = self.collectedAgentsArr[indexPath.row];
    
    agentInfoVC.agentInfo = agentInfo;
    [self.navigationController pushViewController:agentInfoVC animated:YES];
}

#warning  删除的时候要先访问到数组再删除cell，否则会出现数组越界
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        //从数据库中删除对应的纪录
        EHAgentInfo *agentInfo = self.collectedAgentsArr[indexPath.row];
        [agentInfo deleteObject];

        //删除cell
        [self.collectedAgentsArr removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];


    return @[action];
}



@end

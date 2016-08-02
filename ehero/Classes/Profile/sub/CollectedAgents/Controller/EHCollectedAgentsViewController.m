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
    
    //从数据库获取数据
    self.collectedAgentsArr = [NSMutableArray arrayWithArray:[EHAgentInfo findAll]];
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    NSLog(@"collected count %d",_collectedAgentsArr.count);
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
  //  NSLog(@"%@",agentInfo);
//    [agentInfo getIdStringFromDictionary];
    
    agentInfoVC.agentInfo = agentInfo;
    NSLog(@"%@",agentInfoVC.agentInfo.name);
  // [self.navigationController pushViewController:agentInfoVC animated:YES];
}


@end

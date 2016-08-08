//
//  EHSkimedAgentsViewController.m
//  ehero
//
//  Created by Mac on 16/8/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSkimedAgentsViewController.h"
#import "EHSkimedAgentInfo.h"
#import "EHSearchResultCell.h"
@interface EHSkimedAgentsViewController ()

@property (nonatomic,strong) NSArray *skimedAgentsArr;

@end

@implementation EHSkimedAgentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = RGB(241, 243, 245);
    self.title = @"最近浏览的经纪人";
    //从数据库获取数据,数组反转输出
    self.skimedAgentsArr = [[[EHSkimedAgentInfo findAll]reverseObjectEnumerator]allObjects];
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _skimedAgentsArr.count;
}

#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EHSearchResultCell *cell = [EHSearchResultCell searchResultCellWithTableView:tableView];
    EHAgentInfo *agentInfo = self.skimedAgentsArr[indexPath.row];
    cell.isdrawRect = YES;
    [cell setResultCell:agentInfo];
    return cell;
}

@end

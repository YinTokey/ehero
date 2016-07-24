//
//  EHAgentInfoController.m
//  ehero
//
//  Created by Mac on 16/7/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoController.h"
#import "EHAgentInfoCommunityCell.h"
#import "EHSearchResultCell.h"
#import "EHAgentInfo.h"
@interface EHAgentInfoController ()

@end

@implementation EHAgentInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.name;
}



#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 125;
    }else
    return 110;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        EHSearchResultCell *cell = [EHSearchResultCell searchResultCellWithTableView:tableView];
        EHAgentInfo *agentInfo = [[EHAgentInfo alloc]init];
        agentInfo.name = self.name;
        agentInfo.tx = self.tx;
        agentInfo.position = self.position;
        agentInfo.company = self.company;
        agentInfo.region = self.region;
        agentInfo.rates = self.rates;
        agentInfo.community = self.community;
        [cell setResultCell:agentInfo];
        return cell;
    }else{
        EHAgentInfoCommunityCell *cell = [EHAgentInfoCommunityCell AgentInfoCommunityCellWithTableView:tableView];
        return cell;
    }
    
    
}

@end

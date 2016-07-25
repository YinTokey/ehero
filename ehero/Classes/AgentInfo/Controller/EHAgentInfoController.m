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
#import "EHAgentInfoCommentCell.h"
@interface EHAgentInfoController ()

@end

@implementation EHAgentInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.name;
    self.view.backgroundColor = RGB(241, 243, 245);
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0 || section == 1) {
        return 1;
    }else
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        EHSearchResultCell *cell = [EHSearchResultCell searchResultCellWithTableView:tableView];
        EHAgentInfo *agentInfo = [EHAgentInfo setWithAgentInfoController:self];
        [cell setResultCell:agentInfo];
        return cell;
    }else if(indexPath.section == 1){
        EHAgentInfoCommunityCell *cell = [EHAgentInfoCommunityCell AgentInfoCommunityCellWithTableView:tableView];
        return cell;
    }else{
        EHAgentInfoCommentCell *cell = [EHAgentInfoCommentCell AgentInfoCommentCellWithTableView:tableView];
        
        return cell;
    
    }

}

@end

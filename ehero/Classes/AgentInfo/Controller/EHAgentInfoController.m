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
    if (indexPath.section == 0) {
        return 125;
    }else if (indexPath.section == 1){
        return 115;
    }else{
        return 300;
//        EHAgentInfoCommentCell *cell = [EHAgentInfoCommentCell AgentInfoCommentCellWithTableView:tableView];
//        cell.translatesAutoresizingMaskIntoConstraints = NO;
//        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//        return 1  + size.height;
    }
    
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
        
        CGSize constraintSize;
        
        constraintSize. width = 300 ;
        
        constraintSize. height = MAXFLOAT ;
        
        CGSize sizeFrame =[@"此小区周边配套成熟，出门过马路就是钻石网球场和奥林匹克森林公园，学校：北大为明幼儿园、北师大附中附小； 医院：眼科医院、解放军306医院、北医三院、安贞医院等； 华润万家生活广场、新奥购物广场、家乐福、物美等。幼儿园、北师大附中附小； 医院：眼科医院、解放军306医院、北医三院、安贞医院等； 华润万家生活广场、新奥购物广场、家乐福、物美等。" sizeWithFont:cell.commentView.font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        cell.commentView.frame = CGRectMake( 0 , 0 ,sizeFrame.width,sizeFrame.height);
        
        
        return cell;
    
    }

}

@end

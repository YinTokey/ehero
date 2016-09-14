//
//  EHHouseDetailViewController.m
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHouseDetailViewController.h"
#import "EHHouseSourcesCell.h"
#import "EHHouseDetailCell.h"
#import "EHHouseDetailAgentCell.h"
#import "EHHouseDetailCallCell.h"

@interface EHHouseDetailViewController ()

@end

@implementation EHHouseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(241, 243, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSLog(@"%@",_agentInfo.company);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return ScreenHeight * 0.7958;
    }else if(indexPath.row == 1){
        EHHousesInfo *houseInfo = _houseInfo;
        return houseInfo.cellHeight;
    }else{
        return 36;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==  0) {
        EHHouseDetailCell *cell = [EHHouseDetailCell houseDetailCellWithTableView:tableView];
        cell.houseInfo = _houseInfo;
        return cell;
    }else if (indexPath.row == 1){
        EHHouseDetailAgentCell *cell = [EHHouseDetailAgentCell houseDetailAgentCellWithTableView:tableView];
        cell.houseInfo = _houseInfo;
        cell.agetnInfo = _agentInfo;
        return cell;
    }else{
        EHHouseDetailCallCell *cell = [EHHouseDetailCallCell houseDetailCallCellWithTableView:tableView];
        return cell;
    }
}



@end

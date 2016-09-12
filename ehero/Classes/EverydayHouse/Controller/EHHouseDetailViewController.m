//
//  EHHouseDetailViewController.m
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHouseDetailViewController.h"
#import "EHHouseSourcesCell.h"
@interface EHHouseDetailViewController ()

@end

@implementation EHHouseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(241, 243, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _houseInfo.cellHeight;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        EHHouseSourcesCell *cell = [EHHouseSourcesCell houseSourcesCellWithTableView:tableView];

        [cell setClickEvent];
        cell.houseInfo = _houseInfo;
    return cell;
}



@end

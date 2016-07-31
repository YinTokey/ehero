//
//  EHHouseDetailViewController.m
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHouseDetailViewController.h"
#import "EHHouseDetailCell.h"
#import "EHHouseDetailAgentCell.h"
#import "EHHouseDetailCallCell.h"
@interface EHHouseDetailViewController ()

@end

@implementation EHHouseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(241, 243, 245);
  
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //总高度的 0.51
       // return self.view.frame.size.height * 0.51;
        return ScreenHeight * 0.551;
    }else if (indexPath.row == 1){
        //总高度的 0.352
        //return self.view.frame.size.height * 0.352;
        return ScreenHeight * 0.3345;
    }else{
        return 36;
    }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        EHHouseDetailCell *cell = [EHHouseDetailCell houseDetailCellWithTableView:tableView];
        return cell;
    }else if (indexPath.row == 1){
        EHHouseDetailAgentCell *cell = [EHHouseDetailAgentCell houseDetailAgentCellWithTableView:tableView];
        return cell;
    }else{
        EHHouseDetailCallCell *cell = [EHHouseDetailCallCell houseDetailCallCellWithTableView:tableView];
        return cell;
        
    }
}



@end

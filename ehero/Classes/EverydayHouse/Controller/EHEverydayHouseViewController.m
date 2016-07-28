//
//  EHEverydayHouseViewController.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHEverydayHouseViewController.h"
#import "EHEverydayhouseCell.h"
#import "EHHouseDetailViewController.h"
@interface EHEverydayHouseViewController ()

@end

@implementation EHEverydayHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%f ",self.view.frame.size.height);
    NSLog(@"每日一房");
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 94;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EHEverydayhouseCell *cell = [EHEverydayhouseCell everydayhouseCellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    EHHouseDetailViewController *VC = [[self storyboard]instantiateViewControllerWithIdentifier:@"HouseDetailViewController"];
    [self.navigationController pushViewController:VC animated:YES];
    
}
@end

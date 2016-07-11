//
//  EHWechatGroupViewController.m
//  ehero
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHWechatGroupViewController.h"
#import "EHWechatGroupCell.h"
@interface EHWechatGroupViewController ()

@end

@implementation EHWechatGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"wechatGroup");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EHWechatGroupCell *cell = [EHWechatGroupCell wechatGroupCellWithTableView:tableView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 346;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

@end

//
//  EHProfileViewController.m
//  ehero
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHProfileViewController.h"

@interface EHProfileViewController ()

@end

@implementation EHProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"reuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"最近浏览的经纪人";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"最近浏览的房源";
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"收藏的锦囊";
    }
    else if (indexPath.row == 3) {
        cell.textLabel.text = @"收藏的经纪人";
    }
    else if (indexPath.row == 4) {
        cell.textLabel.text = @"手机登录";
    }
    else if (indexPath.row == 5) {
        cell.textLabel.text = @"联系我们";
    }
    else if (indexPath.row == 6) {
        cell.textLabel.text = @"关于我们";
    }
    
    
    
    return cell;
}


@end

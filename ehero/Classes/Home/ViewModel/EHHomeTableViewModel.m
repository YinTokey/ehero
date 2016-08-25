//
//  EHHomeTableViewModel.m
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHomeTableViewModel.h"
#import "EHHomeAgentCell.h"
#import "EHEverydayhouseCell.h"
#import "EHTipsViewController.h"
#import "EHEverydayHouseViewController.h"
#import "EHAntidisturbViewController.h"
#import "EHWechatGroupViewController.h"
@implementation EHHomeTableViewModel

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 3) {
        return 5;
    }else{
        return 1;
    }
}

#pragma mark - cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"reuseCell";
    //第一行 4个按钮
    if (indexPath.section == 0) {
        buttonCell *cell = [buttonCell buttonCellWithTableView:tableView];
        cell.delegate = self;
        [cell setClickEvent];
        return cell;
        //第二行 点评经纪人
    }else if(indexPath.section == 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.text = @"评价你的经纪人";
        return cell;
        //第三行，显示一个经纪人
    }else if(indexPath.section == 2){
        EHHomeAgentCell *cell = [EHHomeAgentCell homeAgentCellWithTableView:tableView];
        return cell;
        
        //第四行 每日一房
    }else{
        
        EHEverydayhouseCell *cell = [EHEverydayhouseCell everydayhouseCellWithTableView:tableView];
        return cell;
    }
    
}

- (void)firstBtnClick:(UITableViewCell *)cell{

    EHTipsViewController  *tipsViewController = [[self.superVC storyboard]instantiateViewControllerWithIdentifier:@"TipsViewController"];
    [self.superVC.navigationController pushViewController:tipsViewController animated:YES];
    
}

- (void)secondBtnClick:(UITableViewCell *)cell{
    
    EHAntidisturbViewController *antidisturbViewController = [[self.superVC storyboard]instantiateViewControllerWithIdentifier:@"AntidisturbViewController"];
    [self.superVC.navigationController pushViewController:antidisturbViewController animated:YES];
    
}

- (void)thirdBtnClick:(UITableViewCell *)cell{
    EHEverydayHouseViewController *everydayHouseViewController = [[self.superVC storyboard]instantiateViewControllerWithIdentifier:@"EverydayHouseViewController"];
    [self.superVC.navigationController pushViewController:everydayHouseViewController animated:YES];
}

- (void)fourthBtnClick:(UITableViewCell *)cell{
    EHWechatGroupViewController *wechatGroupViewController = [[self.superVC storyboard]instantiateViewControllerWithIdentifier:@"WechatGroupDetailViewController"];
    [self.superVC.navigationController pushViewController:wechatGroupViewController animated:YES];
    
}
@end

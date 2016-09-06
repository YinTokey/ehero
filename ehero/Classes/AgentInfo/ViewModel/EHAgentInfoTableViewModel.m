//
//  EHAgentInfoTableViewModel.m
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoTableViewModel.h"
#import "EHAgentInfoChartCell.h"
#import "EHAgentInfoCommentCell.h"
@implementation EHAgentInfoTableViewModel

#pragma mark - Table view data source

#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 125;
    }else if (indexPath.section == 1){
        return ScreenHeight * 0.42 + 30;
    }else{
        return 125;
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
        [cell setResultCell:self.agentInfo];
        cell.isdrawRect = NO;
        cell.delegate = self.superVC;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section == 1){
        EHAgentInfoChartCell *cell = [EHAgentInfoChartCell AgentInfoChartCellWithTableView:tableView];
        cell.backgroundColor = RGB(235, 247, 255);
        cell.chart.dataSource = self;
        cell.chart.delegate = self;
        [cell.chart reloadData];
        return cell;
    }else{
        EHAgentInfoCommentCell *cell = [EHAgentInfoCommentCell AgentInfoCommentCellWithTableView:tableView];
        
        return cell;
        
    }
}

#pragma mark - 雷达图代理
- (NSInteger)numberOfStepForRadarChart:(LQRadarChart *)radarChart
{
    return 10;
}
- (NSInteger)numberOfRowForRadarChart:(LQRadarChart *)radarChart
{
    return 5;
}
- (NSInteger)numberOfSectionForRadarChart:(LQRadarChart *)radarChart
{
    return 2;
}
- (NSString *)titleOfRowForRadarChart:(LQRadarChart *)radarChart row:(NSInteger)row
{
    NSArray * title = @[@"销售",@"出租",@"关注量",@"好评率",@"浏览量"];
    return title[row];
}
- (CGFloat)valueOfSectionForRadarChart:(LQRadarChart *)radarChart row:(NSInteger)row section:(NSInteger)section
{
    if (section == 0 ){
        return (CGFloat)(MAX(MIN(row + 1, 4), 3));
    } else {
        return (CGFloat)(MAX(MIN(row + 2, 5), 1));
    }
}



- (UIColor *)colorOfTitleForRadarChart:(LQRadarChart *)radarChart
{
    return [UIColor blackColor];
    
}
- (UIColor *)colorOfLineForRadarChart:(LQRadarChart *)radarChart
{
    return RGB(192,191, 190);
    
}
- (UIColor *)colorOfFillStepForRadarChart:(LQRadarChart *)radarChart step:(NSInteger)step
{
    UIColor * color = [UIColor clearColor];
    //    switch (step) {
    //        case 1:
    //            color = [UIColor colorWithRed:0.545 green:0.906 blue:0.996 alpha:1];
    //            break;
    //        case 2:
    //            color = [UIColor colorWithRed:0.706 green:0.929 blue:0.988 alpha:1];
    //            break;
    //        case 3:
    //            color = [UIColor colorWithRed:0.831 green:0.949 blue:0.984 alpha:1];
    //            break;
    //        case 4:
    //            color = [UIColor colorWithRed:0.922 green:0.976 blue:0.998 alpha:1];
    //            break;
    //
    //        default:
    //            break;
    //    }
    return color;
}
- (UIColor *)colorOfSectionFillForRadarChart:(LQRadarChart *)radarChart section:(NSInteger)section
{
    if (section == 0) {
        return RGBA(22, 127, 246,0.3);
    }else{
        return RGBA(138, 142, 165,0.3);
    }
}
//数据组边框颜色
- (UIColor *)colorOfSectionBorderForRadarChart:(LQRadarChart *)radarChart section:(NSInteger)section
{
    if (section == 0) {
        return RGB(22, 127, 246);
    }else{
        return RGB(138, 142, 165);
    }
    
}
- (UIFont *)fontOfTitleForRadarChart:(LQRadarChart *)radarChart
{
    return [UIFont systemFontOfSize:11];
    
}

@end

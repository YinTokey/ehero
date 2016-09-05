//
//  EHAgentInfoCommunityCell.m
//  ehero
//
//  Created by Mac on 16/7/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoChartCell.h"
@implementation EHAgentInfoChartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)AgentInfoChartCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"AgentInfoChartCell";
    EHAgentInfoChartCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHAgentInfoChartCell" owner:nil options:nil] lastObject];
 //       cell.chartViewModel = [[EHChartViewModel alloc]init];
//        cell.chart.dataSource = cell.chartViewModel;
//        cell.chart.delegate = cell.chartViewModel;
        
        cell.backgroundColor = RGB(235, 247, 255);
        cell.userInteractionEnabled = NO;
        cell.chart = [[LQRadarChart alloc]initWithFrame:CGRectMake(0, ScreenWidth - 300, ScreenWidth, ScreenWidth)];
        cell.chart.center = cell.center;
        cell.chart.radius = ScreenWidth / 2.7;
        [cell addSubview:cell.chart];
    }
    
    return cell;
    
}

@end

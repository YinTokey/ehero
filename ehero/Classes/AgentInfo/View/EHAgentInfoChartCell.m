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
        
        cell.backgroundColor = RGB(235, 247, 255);
        cell.userInteractionEnabled = NO;
        cell.chart = [[LQRadarChart alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
        [cell.chart setCenter:CGPointMake(cell.center.x, cell.center.y - 25)];
        cell.chart.radius = ScreenWidth / 3.0;
        cell.chartView.backgroundColor = [UIColor clearColor];
        [cell.chartView addSubview:cell.chart];
    }
    
    return cell;
    
}

@end

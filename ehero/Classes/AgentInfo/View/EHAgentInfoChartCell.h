//
//  EHAgentInfoCommunityCell.h
//  ehero
//
//  Created by Mac on 16/7/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQRadarChart.h"


@interface EHAgentInfoChartCell : UITableViewCell
@property (nonatomic,strong) LQRadarChart * chart;
@property (weak, nonatomic) IBOutlet UILabel *person;
@property (weak, nonatomic) IBOutlet UILabel *average;
@property (weak, nonatomic) IBOutlet UIView *chartView;

+ (instancetype)AgentInfoChartCellWithTableView:(UITableView *)tableView;

@end

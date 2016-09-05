//
//  EHAgentInfoCommunityCell.h
//  ehero
//
//  Created by Mac on 16/7/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQRadarChart.h"
#import "EHChartViewModel.h"

@interface EHAgentInfoChartCell : UITableViewCell
@property (nonatomic,strong) LQRadarChart * chart;
@property (nonatomic,strong) EHChartViewModel *chartViewModel;

+ (instancetype)AgentInfoChartCellWithTableView:(UITableView *)tableView;

@end

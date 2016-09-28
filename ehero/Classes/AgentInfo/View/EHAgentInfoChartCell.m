//
//  EHAgentInfoCommunityCell.m
//  ehero
//
//  Created by Mac on 16/7/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoChartCell.h"
#import "UILabel+GetWidth.h"


@implementation EHAgentInfoChartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    // Initialization code
}

- (void)layoutSubviews{
    [super layoutSubviews];
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
        cell.backgroundColor = RGB(238, 245, 250);
        cell.userInteractionEnabled = NO;
        cell.chart = [[LQRadarChart alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
        [cell.chart setCenter:CGPointMake(ScreenWidth/2, cell.frame.origin.y + ScreenWidth/3 +15)];

        cell.chart.radius = ScreenWidth / 3.0;
        cell.chartView.backgroundColor = [UIColor clearColor];
        [cell.chartView addSubview:cell.chart];
        
        CGRect rect = [cell.average.text boundingRectWithSize:CGSizeMake(300,9999) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        
        cell.average.frame = CGRectMake(ScreenWidth/2 - rect.size.width, cell.person.frame.origin.y, rect.size.width, 21);
    }
    
    return cell;
    
}

@end

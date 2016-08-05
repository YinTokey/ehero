//
//  EHAgentInfoCommunityCell.m
//  ehero
//
//  Created by Mac on 16/7/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoCommunityCell.h"

@implementation EHAgentInfoCommunityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)AgentInfoCommunityCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"AgentInfoCommunityCell";
    EHAgentInfoCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHAgentInfoCommunityCell" owner:nil options:nil] lastObject];
        cell.backgroundColor = RGB(241, 243, 245);
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
    
}

@end

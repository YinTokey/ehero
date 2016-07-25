//
//  EHAgentInfoCommentCell.m
//  ehero
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoCommentCell.h"

@implementation EHAgentInfoCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)AgentInfoCommentCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"AgentInfoCommentCell";
    EHAgentInfoCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHAgentInfoCommentCell" owner:nil options:nil] lastObject];
        cell.commentView.layer.cornerRadius = 5;
        cell.layer.masksToBounds = YES;
        cell.backgroundColor = RGB(241, 243, 245);
        //cell.commentView.con
        
    }
    
    return cell;
    
}




@end

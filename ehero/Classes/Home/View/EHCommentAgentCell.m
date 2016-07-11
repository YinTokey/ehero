//
//  EHCommentAgentCell.m
//  ehero
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommentAgentCell.h"

@implementation EHCommentAgentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)commentAgentCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"reuseCommentAgentCell";
    EHCommentAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHCommentAgentCell" owner:nil options:nil] lastObject];
        
    }
    
    return cell;
    
}

@end

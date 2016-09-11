//
//  EHNoCommentCell.m
//  易房好介
//
//  Created by Mac on 16/9/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHNoCommentCell.h"

@implementation EHNoCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)noCommentCellCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"NoCommentCell";
    EHNoCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHNoCommentCell" owner:nil options:nil] lastObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


@end

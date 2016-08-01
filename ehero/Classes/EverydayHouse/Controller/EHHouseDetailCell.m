//
//  EHHouseDetailCell.m
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHouseDetailCell.h"

@implementation EHHouseDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)houseDetailCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"reuseHouseDetailCell";
    EHHouseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHHouseDetailCell" owner:nil options:nil] lastObject];
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
    
}



@end

//
//  EHHouseDetailCallCell.m
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHouseDetailCallCell.h"

@implementation EHHouseDetailCallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)callClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(callClick:)]) {
        [self.delegate callClick:self];
    }

}

+ (instancetype)houseDetailCallCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"reuseHouseDetailCallCell";
    EHHouseDetailCallCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHHouseDetailCallCell" owner:nil options:nil] lastObject];
        
    }
    
    return cell;
    
}


@end

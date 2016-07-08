//
//  buttonCell.m
//  ehero
//
//  Created by Mac on 16/7/8.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "buttonCell.h"

@implementation buttonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)buttonCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"reuseButtonCell";
    buttonCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"buttonCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

@end

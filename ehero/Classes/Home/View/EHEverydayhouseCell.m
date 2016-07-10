//
//  EHEverydayhouseCell.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHEverydayhouseCell.h"

@implementation EHEverydayhouseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)everydayhouseCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"reuseEverydayhouseCell";
    EHEverydayhouseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHEverydayhouseCell" owner:nil options:nil] lastObject];
        
    }
    
    return cell;
    
}


@end

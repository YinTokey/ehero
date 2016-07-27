//
//  EHWechatGroupCell.m
//  ehero
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHWechatGroupCell.h"

@implementation EHWechatGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)wechatGroupCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"WechatGroupCell";
    EHWechatGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHWechatGroupCell" owner:nil options:nil] lastObject];
        cell.backgroundColor = RGB(231, 233, 235);
        
    }
    
    return cell;
    
}

@end

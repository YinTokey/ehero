//
//  EHHouseDetailAgentCell.m
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHouseDetailAgentCell.h"
@interface EHHouseDetailAgentCell()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end
@implementation EHHouseDetailAgentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)houseDetailAgentCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"reuseHouseDetailAgentCell";
    EHHouseDetailAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHHouseDetailAgentCell" owner:nil options:nil] lastObject];
        cell.backgroundColor = RGB(241, 243, 245);
        cell.contentView.layer.cornerRadius = 5;
        cell.layer.masksToBounds = YES;
    }
    
    return cell;
    
}

@end

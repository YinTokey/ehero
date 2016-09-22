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
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
    
}

- (void)setHouseInfo:(EHHousesInfo *)houseInfo{
    _houseInfo = houseInfo;
    self.descriptions.text = _houseInfo.descriptions;
    CGSize textSize = self.descriptions.contentSize;
    houseInfo.cellHeight = textSize.height + 90;
}

- (void)setAgetnInfo:(EHAgentInfo *)agetnInfo{
    _agetnInfo = agetnInfo;
    self.name.text = _agetnInfo.name;
    self.company.text = _agetnInfo.company;
//    NSString *regionStr = [NSString stringWithFormat:@"  %@   ",_agetnInfo.region];
//    self.region.text = regionStr;
    self.region.text = _agetnInfo.region;
    if (_agetnInfo.region.length > 1) {
        NSString *regionStr = [NSString stringWithFormat:@"%@    ",_agetnInfo.region];
        self.region.text = regionStr;
    }
 //   self.region.adjustsFontSizeToFitWidth = YES;
    if (_agetnInfo.percentile) {
        NSString *percentileStr = [NSString stringWithFormat:@"公司内排名 %@％",_agetnInfo.percentile];
        self.percentile.text = percentileStr;
    }else{
      self.percentile.text = @"";
    }
    self.txView.image = [YTNetCommand downloadImageWithImgStr:_agetnInfo.tx
                                          placeholderImageStr:@"Profile"
                                                    imageView:_txView];
    
}


@end

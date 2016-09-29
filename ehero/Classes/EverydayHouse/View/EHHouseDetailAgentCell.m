//
//  EHHouseDetailAgentCell.m
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHouseDetailAgentCell.h"
#import "EHLabel.h"
@interface EHHouseDetailAgentCell()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *mainRegion;

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
//    self.region.text = _agetnInfo.region;
//    if (_agetnInfo.region.length > 1) {
//        NSString *regionStr = [NSString stringWithFormat:@"%@",_agetnInfo.region];
//        self.region.text = regionStr;
//      //  [self.region setAdjustsFontSizeToFitWidth:YES];
//       CGFloat textWidth = [UILabel getWidthWithTitle:self.region.text font:[UIFont systemFontOfSize:12.0]];
//        self.region.sd_layout.
//        widthIs(textWidth + 20);
//
//    }
    NSArray *rArray = [agetnInfo.region componentsSeparatedByString:@" "];
    NSMutableArray *regionsArray = [NSMutableArray array];
    for (NSString *str in rArray) {
        if (str.length > 1) {
            [regionsArray addObject:str];
        }
    }
    CGFloat y = 65;
    if (regionsArray.count == 1) {
        NSString *regionStr = regionsArray[0];
        EHLabel *label = [EHLabel LabelWithText:regionStr];
        label.frame = CGRectMake(self.mainRegion.frame.origin.x + 73,y, label.textWidth+10, 17);
        [self addSubview:label];
    }
    
    if (regionsArray.count == 2) {
        NSString *regionStr0 = regionsArray[0];
        NSString *regionStr1 = regionsArray[1];
        EHLabel *label0 = [EHLabel LabelWithText:regionStr0];
        label0.frame = CGRectMake(self.mainRegion.frame.origin.x + 73,y, label0.textWidth+10, 17);
        [self addSubview:label0];
        EHLabel *label1 = [EHLabel LabelWithText:regionStr1];
        label1.frame = CGRectMake(label0.frame.origin.x + label0.frame.size.width + 5 ,y, label1.textWidth+10, 17);
        [self addSubview:label1];
    }
    if (regionsArray.count >=3) {
        NSString *regionStr0 = regionsArray[0];
        NSString *regionStr1 = regionsArray[1];
        NSString *regionStr2 = regionsArray[2];
        EHLabel *label0 = [EHLabel LabelWithText:regionStr0];
        label0.frame = CGRectMake(self.mainRegion.frame.origin.x + 73,y, label0.textWidth+10, 17);
        [self addSubview:label0];
        EHLabel *label1 = [EHLabel LabelWithText:regionStr1];
        label1.frame = CGRectMake(label0.frame.origin.x + label0.frame.size.width + 5 ,y, label1.textWidth+10, 17);
        [self addSubview:label1];
        EHLabel *label2 = [EHLabel LabelWithText:regionStr2];
        label2.frame = CGRectMake(label1.frame.origin.x + label1.frame.size.width + 5 ,y, label2.textWidth+10, 17);
        [self addSubview:label2];
    }
    
    
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

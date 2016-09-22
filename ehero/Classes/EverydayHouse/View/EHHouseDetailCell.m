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

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}

- (void)setHouseInfo:(EHHousesInfo *)houseInfo{
    _houseInfo = houseInfo;
    self.titleLabel.text = _houseInfo.title;
    self.price.text = _houseInfo.price;
    NSString *updated_at = [_houseInfo.updated_at substringWithRange:NSMakeRange(0, 10)];
    self.updated_at.text = updated_at;
    self.model.text = _houseInfo.model;
    self.area.text = _houseInfo.area;
    self.toward.text = _houseInfo.toward;
    self.floor.text = _houseInfo.floor;
    self.location.text = _houseInfo.location;
    if (_houseInfo.clicks == nil) {
        NSString *clickStr = [NSString stringWithFormat:@"点击量：0"];
        self.click.text = clickStr;
    }else{
        NSString *clickStr = [NSString stringWithFormat:@"点击量：%@",_houseInfo.clicks];
        self.click.text = clickStr;
    }
    
    //处理图片下载
    NSArray *imgUrlStrArray = [_houseInfo.thumbs componentsSeparatedByString:@" "];
    //设置轮播图片
    self.cycleView.imageURLStringsGroup = imgUrlStrArray;
    self.cycleView.autoScrollTimeInterval = 4;

}


@end
